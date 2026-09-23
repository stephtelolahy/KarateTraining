import Foundation

/// Une technique de base (kihon).
struct Technique: Identifiable, Hashable {
    let id: TechniqueID
    /// Nom japonais romanisé (ex. « Oi-zuki »).
    let romaji: String
    /// Traduction française.
    let french: String
    let category: TechniqueCategory
    let description: String?
}

/// Identifiant unique de chaque technique du kihon.
/// La `rawValue` (camelCase) est la clé utilisée dans `training.json`.
enum TechniqueID: String, Codable, CaseIterable, Identifiable, Hashable {
    // Tsuki
    case chokuZuki, oiZuki, gyakuZuki
    // Uchi
    case nukite, yokoEmpiUchi
    // Geri
    case maeGeri, mawashiGeri, yokoGeriKeikomi, yokoGeriKeage
    // Uke
    case ageUke, sotoUke, uchiUke, shutoUke, gedanBarai
    // Dachi
    case zenkutsuDachi, kokutsuDachi, kibaDachi
    // Ido
    case ayumiAshi, suriAshi, tsugiAshi, taiSabaki

    var id: String { rawValue }
}

/// Catégories du kihon. L'ensemble est fermé → enum.
enum TechniqueCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case tsuki   // attaques de poing
    case uchi    // frappes main ouverte / coude
    case geri    // attaques de pied
    case uke     // blocages
    case dachi   // positions
    case ido     // déplacements

    var id: String { rawValue }

    var title: String {
        switch self {
        case .tsuki: "Attaques de poing"
        case .uchi:  "Frappes (Uchi)"
        case .geri:  "Attaques de pied"
        case .uke:   "Blocages"
        case .dachi: "Positions (Dachi)"
        case .ido:   "Déplacements"
        }
    }

    var japanese: String {
        switch self {
        case .tsuki: "Tsuki-waza"
        case .uchi:  "Uchi-waza"
        case .geri:  "Geri-waza"
        case .uke:   "Uke-waza"
        case .dachi: "Dachi-kata"
        case .ido:   "Ashi-sabaki"
        }
    }

    /// Symbole SF Symbols utilisé dans l'interface.
    var symbol: String {
        switch self {
        case .tsuki: "figure.martial.arts"
        case .uchi:  "burst.fill"
        case .geri:  "figure.kickboxing"
        case .uke:   "shield.lefthalf.filled"
        case .dachi: "figure.stand"
        case .ido:   "figure.walk"
        }
    }
}
