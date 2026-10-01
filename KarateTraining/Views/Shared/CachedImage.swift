import CryptoKit
import SwiftUI
import UIKit

// MARK: - Cache d'images (mémoire + disque)

/// Garde chaque image téléchargée dans Application Support, que iOS ne vide pas
/// tout seul. Les photos des techniques ne changent pas : une fois enregistrée,
/// une image n'est plus jamais retéléchargée.
actor ImageCache {
    static let shared = ImageCache()

    private let memory = NSCache<NSURL, UIImage>()
    private var inFlight: [URL: Task<UIImage, Error>] = [:]
    private let directory: URL

    init() {
        var directory = URL.applicationSupportDirectory
            .appending(path: "ImageCache", directoryHint: .isDirectory)
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? directory.setResourceValues(values)
        self.directory = directory
    }

    func image(for url: URL) async throws -> UIImage {
        if let image = memory.object(forKey: url as NSURL) { return image }
        if let task = inFlight[url] { return try await task.value }

        let file = fileURL(for: url)
        let task = Task.detached { () throws -> UIImage in
            if let data = try? Data(contentsOf: file), let image = UIImage(data: data) {
                return image
            }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                let image = UIImage(data: data)
            else { throw URLError(.cannotDecodeContentData) }
            try? data.write(to: file, options: .atomic)
            return image
        }
        inFlight[url] = task
        defer { inFlight[url] = nil }

        let image = try await task.value
        memory.setObject(image, forKey: url as NSURL)
        return image
    }

    private func fileURL(for url: URL) -> URL {
        let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
            .map { String(format: "%02x", $0) }
            .joined()
        return directory.appending(path: hash)
    }
}

// MARK: - Vue

/// Remplace `AsyncImage` en passant par `ImageCache`, avec les mêmes phases.
struct CachedImage<Content: View>: View {
    let url: URL
    @ViewBuilder let content: (AsyncImagePhase) -> Content

    @State private var phase: AsyncImagePhase = .empty

    var body: some View {
        content(phase)
            .task(id: url) {
                do {
                    let image = try await ImageCache.shared.image(for: url)
                    phase = .success(Image(uiImage: image))
                } catch {
                    if !Task.isCancelled { phase = .failure(error) }
                }
            }
    }
}
