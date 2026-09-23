//
//  KataCatalog.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 23/09/2026.
//

enum KataCatalog {
    static let all: [Kata] = KataID.allCases.map(\.definition)
}

extension KataID {
    var definition: Kata {
        switch self {
        case .heianShodan:
            return Kata(
                id: self,
                name: "Heian Shodan",
                meaning: "Paix et tranquillité — 1er niveau",
                moveCount: 21,
                summary: "Premier kata de la série Heian, point de départ de l'apprentissage : déplacements et blocages fondamentaux."
            )
        case .heianNidan:
            return Kata(
                id: self,
                name: "Heian Nidan",
                meaning: "Paix et tranquillité — 2e niveau",
                moveCount: 26,
                summary: "Deuxième kata de la série Heian, aux enchaînements plus élaborés que le premier."
            )
        case .heianSandan:
            return Kata(
                id: self,
                name: "Heian Sandan",
                meaning: "Paix et tranquillité — 3e niveau",
                moveCount: 20,
                summary: "Troisième kata de la série Heian."
            )
        case .heianYondan:
            return Kata(
                id: self,
                name: "Heian Yondan",
                meaning: "Paix et tranquillité — 4e niveau",
                moveCount: 27,
                summary: "Quatrième kata de la série Heian, plus long et plus technique."
            )
        case .heianGodan:
            return Kata(
                id: self,
                name: "Heian Godan",
                meaning: "Paix et tranquillité — 5e niveau",
                moveCount: 23,
                summary: "Cinquième et dernier kata de la série Heian, qui prépare aux katas supérieurs."
            )
        case .tekkiShodan:
            return Kata(
                id: self,
                name: "Tekki Shodan",
                meaning: "Cavalier de fer — 1er niveau",
                moveCount: 29,
                summary: "Kata exécuté entièrement en kiba-dachi, avec des déplacements latéraux sur une ligne : stabilité et contrôle des hanches."
            )
        }
    }
}

extension KataID {
    var name: String { definition.name }
    var meaning: String { definition.meaning }
    var moveCount: Int { definition.moveCount }
    var summary: String { definition.summary }
}
