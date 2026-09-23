import Foundation

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
