import Foundation

extension Step {
    /// Ex. « Oi-zuki jodan » ou « Mae-geri chudan (sur place) ».
    var label: String {
        var text = techniques.map(\.definition.romaji).joined(separator: " + ")
        if let target { text += " \(target.rawValue)" }
        return text
    }

    /// Ex. « Migi (droite) », ou « Migi + Hidari » quand les techniques
    /// de l'étape ne sont pas du même côté. `nil` si aucun côté n'est indiqué.
    var sideText: String? {
        let known = sides.compactMap { $0 }
        guard let first = known.first else { return nil }
        if known.allSatisfy({ $0 == first }) { return first.title }
        return sides.map { $0?.romaji ?? "—" }.joined(separator: " + ")
    }
}

extension Exercise {
    /// Titre lisible, ex. « Zenkutsu-dachi + Age-uke + Gyaku-zuki »
    /// ou « Oi-zuki jodan / Age-uke + Gyaku-zuki » pour un ippon kumite.
    var displayTitle: String {
        if let title, !title.isEmpty { return title }

        switch type {
        case .kata:
            return title ?? "Kata"

        case .kumite:
            let attack = Self.segments(for: steps.filter { $0.role == .attack })
            let response = Self.segments(for: steps.filter { $0.role != .attack })
            return attack.joined(separator: " + ") + " / " + response.joined(separator: " + ")

        case .technique, .combo:
            let body = Self.segments(for: steps).joined(separator: " + ")
            return body
        }
    }

    /// Une position précède sa technique, sauf pour un coup de pied
    /// (on retombe dans la position après la frappe).
    private static func segments(for steps: [Step]) -> [String] {
        steps.map(\.label)
    }
}
