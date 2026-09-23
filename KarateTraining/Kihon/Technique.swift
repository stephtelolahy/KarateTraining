import Foundation

/// Une technique de base (kihon).
struct Technique: Identifiable, Hashable {
    let id: TechniqueID
    /// Nom japonais romanisé (ex. « Oi-zuki »).
    let romaji: String
    /// Traduction anglaise (ex. « Lunge Punch »).
    let english: String
    /// Traduction française.
    let french: String
    let category: TechniqueCategory
    let description: String?
}

extension Technique {
    /// Recherche insensible à la casse, aux accents et aux tirets.
    func matches(_ query: String) -> Bool {
        let q = Self.normalize(query)
        guard !q.isEmpty else { return true }
        return [romaji, english, french].contains { Self.normalize($0).contains(q) }
    }

    private static func normalize(_ text: String) -> String {
        text.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .replacingOccurrences(of: "-", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
