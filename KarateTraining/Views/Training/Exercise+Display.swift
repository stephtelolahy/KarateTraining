import Foundation

extension Step {
    /// Ex. « Oi-zuki jodan » ou « Mae-geri chudan (sur place) ».
    var label: String {
        var text = technique.definition.romaji
        if let target { text += " \(target.rawValue)" }
        return text
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
