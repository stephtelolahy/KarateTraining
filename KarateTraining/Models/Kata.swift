import Foundation

struct Kata: Codable, Hashable {
    let id: KataID
    let name: String
    let meaning: String
    let moveCount: Int
    let summary: String
}

/// Katas disponibles. Les valeurs de `rawValue` sont utilisées dans `training.json`.
enum KataID: String, Codable, CaseIterable, Identifiable, Hashable {
    case heianShodan, heianNidan, heianSandan, heianYondan, heianGodan
    case tekkiShodan

    var id: String { rawValue }
}
