import Foundation
import Observation

/// Charge et valide le contenu pédagogique depuis `training.json`.
@Observable
final class ContentStore {
    private(set) var programs: [TrainingProgram] = []
    /// Message d'erreur lisible si le JSON est absent, invalide ou incohérent.
    private(set) var loadError: String?

    init(bundle: Bundle = .main, resource: String = "training") {
        do {
            guard let url = bundle.url(forResource: resource, withExtension: "json") else {
                throw ContentError.fileNotFound("\(resource).json")
            }
            let data = try Data(contentsOf: url)
            let content = try JSONDecoder().decode(TrainingContent.self, from: data)
            let issues = content.validationIssues()
            guard issues.isEmpty else { throw ContentError.invalid(issues) }
            programs = content.programs
        } catch {
            loadError = Self.describe(error)
        }
    }

    // MARK: Erreurs

    private static func describe(_ error: Error) -> String {
        if let error = error as? ContentError { return error.errorDescription ?? "Erreur de contenu" }
        guard let decoding = error as? DecodingError else { return error.localizedDescription }

        func path(_ context: DecodingError.Context) -> String {
            context.codingPath
                .map { $0.intValue.map(String.init) ?? $0.stringValue }
                .joined(separator: " › ")
        }
        switch decoding {
        case .dataCorrupted(let c):
            return "Données corrompues (\(path(c))) : \(c.debugDescription)"
        case .keyNotFound(let key, let c):
            return "Clé manquante « \(key.stringValue) » (\(path(c)))"
        case .typeMismatch(_, let c), .valueNotFound(_, let c):
            return "Valeur invalide (\(path(c))) : \(c.debugDescription)"
        @unknown default:
            return decoding.localizedDescription
        }
    }
}

enum ContentError: LocalizedError {
    case fileNotFound(String)
    case invalid([String])

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let name):
            "Fichier \(name) introuvable dans l'application."
        case .invalid(let issues):
            "Contenu incohérent :\n" + issues.map { "• \($0)" }.joined(separator: "\n")
        }
    }
}
