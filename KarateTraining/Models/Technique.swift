import Foundation

/// Une technique de base (kihon).
struct Technique: Identifiable, Hashable {
    let id: TechniqueID
    /// Nom japonais romanisé.
    let romaji: String
    /// Traduction / description courte française.
    let french: String
    let category: TechniqueCategory
    var description: String?
}

/// Identifiant unique de chaque technique du kihon.
enum TechniqueID: String, Codable, CaseIterable, Identifiable, Hashable {

    // MARK: - Kamae

    case gankakuKamae
    case gedanKamae
    case gyakuHanmi
    case hizaKamae
    case jiaiKamae
    case jujiKamae
    case kaiunNoTe
    case kitsutsukiNoKamae
    case kokoKamae
    case kosaKamae
    case koshiKamae
    case soeteKoshiKamae
    case haitoKoshiKamae
    case manjiKamae
    case mizuNagareNoKamae
    case ryusuiKamae
    case musoKamae
    case ryokenKoshiKamae
    case ryowanKamae
    case kaishuRyowanKamae
    case shizentai
    case yamaKamae
    case kaishuYamaKamae

    // MARK: - Dachi

    case fudoDachi
    case hachijiDachi
    case hangetsuDachi
    case heikoDachi
    case heisokuDachi
    case kataHizaDachi
    case kibaDachi
    case kokutsuDachi
    case kaseiKokutsuDachi
    case kosaDachi
    case kakeDachi
    case motoDachi
    case musubiDachi
    case nekoAshiDachi
    case renojiDachi
    case sagiAshiDachi
    case sanchinDachi
    case shikoDachi
    case sochinDachi
    case teijiDachi
    case tsuruAshiDachi
    case gangakuDachi
    case uchiHachijiDachi
    case zenkutsuDachi

    // MARK: - Unsoku

    case ayumiAshi
    case hikiAshi
    case mawariAshi
    case omawariAshi
    case okuriAshi
    case suriAshi
    case tsugiAshi
    case ushiroMawariAshi
    case yoriAshi

    // MARK: - Uke

    case empiUke
    case gedanBarai
    case gedanUchiBarai
    case haishuUke
    case heikoUke
    case jodanAgeUke
    case jujiUke
    case jodanJujiUke
    case gedanJujiUke
    case kakiwakeUke
    case kokenUke
    case kakutoUke
    case manjiUke
    case moroteUchiUke
    case nagashiUke
    case teNagashiUke
    case haiwanNagashiUke
    case osaeUke
    case otoshiUke
    case shutoUke
    case sotoUdeUke
    case sukuiUke
    case uchiSukuiUke
    case sotoSukuiUke
    case tateShutoUke
    case teishoUke
    case uchiUdeUke

    // MARK: - Tsuki

    case ageZuki
    case chokuZuki
    case gyakuZuki
    case kagiZuki
    case kizamiZuki
    case maeteZuki
    case mawashiZuki
    case furiZuki
    case moroteZuki
    case heikoZuki
    case hasamiZuki
    case moroteUraZuki
    case awaseZuki
    case yamaZuki
    case nagashiZuki
    case nukite
    case gohonNukite
    case ipponNukite
    case nihonNukite
    case yohonNukite
    case oiZuki
    case junZuki
    case otoshiZuki
    case tateZuki
    case teishoZuki
    case uraZuki

    // MARK: - Uchi

    case empiUchi
    case maeEmpiUchi
    case otoshiEmpiUchi
    case tateEmpiUchi
    case ushiroEmpiUchi
    case yokoEmpiUchi
    case yokoMawashiEmpiUchi
    case haishuUchi
    case haitoUchi
    case kokenUchi
    case kakutoUchi
    case shutoUchi
    case mawashiShutoUchi
    case sotoShutoUchi
    case hasamiShutoUchi
    case teishoUchi
    case hasamiTeishoUchi
    case tettsuiUchi
    case moroteTettsuiUchi
    case hasamiTettsuiUchi
    case urakenUchi
    case tateUrakenUchi
    case urakenShomenUchi
    case yokoUrakenUchi
    case seikenMawashiUchi

    // MARK: - Barai

    case ashiBarai
    case maeAshiBarai
    case ushiroAshiBarai
    case tobiAshiBarai
    case ushiroMawashiBarai

    // MARK: - Geri

    case fumikiri
    case fumikomiGeri
    case gedanGeri
    case sokutoFumikomi
    case kansetsuGeri
    case ushiroFumikomi
    case hizaGeri
    case hitsuiGeri
    case kakatoGeri
    case maeKakatoGeri
    case maeGeri
    case maeAshiMaeGeri
    case kizamiMaeGeri
    case ushiroAshiMaeGeri
    case maeGeriKeage
    case maeSokutoGeri
    case nidanGeri
    case surikondeMaeGeri
    case tobikondeMaeGeri
    case tobiMaeGeri
    case mawashiGeri
    case maeAshiMawashiGeri
    case kizamiMawashiGeri
    case ushiroAshiMawashiGeri
    case kaseiMawashiGeri
    case surikondeMawashiGeri
    case tobikondeMawashiGeri
    case tobiMawashiGeri
    case mikazukiGeri
    case gyakuMikazukiGeri
    case surikondeMikazukiGeri
    case tobikondeMikazukiGeri
    case namiAshi
    case tobiGeri
    case tobiUshiroMawashiGeri
    case tobiYokoGeri
    case uraMawashiGeri
    case ushiroGeri
    case maeAshiUshiroGeri
    case ushiroAshiUshiroGeri
    case ushiroGeriKekomi
    case yokoGeri
    case yokoGeriKeage
    case yokoGeriKekomi
    case maeAshiYokoGeri
    case ushiroAshiYokoGeri

    var id: String {
        rawValue
    }
}

/// Catégories du kihon.
enum TechniqueCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case kamae
    case tsuki
    case uchi
    case geri
    case uke
    case dachi
    case ido
    case barai

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .kamae: "Gardes"
        case .tsuki: "Attaques de poing"
        case .uchi: "Percussions"
        case .geri: "Attaques de pied"
        case .uke: "Défenses"
        case .dachi: "Positions"
        case .ido: "Déplacements"
        case .barai: "Balayages"
        }
    }

    var japanese: String {
        switch self {
        case .kamae: "Kamae"
        case .tsuki: "Tsuki-waza"
        case .uchi: "Uchi-waza"
        case .geri: "Keri-waza"
        case .uke: "Uke-waza"
        case .dachi: "Dachi"
        case .ido: "Unsoku"
        case .barai: "Barai"
        }
    }

    var symbol: String {
        switch self {
        case .kamae: "figure.stand"
        case .tsuki: "figure.martial.arts"
        case .uchi: "burst.fill"
        case .geri: "figure.kickboxing"
        case .uke: "shield.lefthalf.filled"
        case .dachi: "figure.stand"
        case .ido: "figure.walk"
        case .barai: "figure.martial.arts"
        }
    }
}

/// Base de données du kihon.
enum TechniqueCatalog {

    static let all: [Technique] = TechniqueID.allCases.map(\.definition)

    static func techniques(
        in category: TechniqueCategory
    ) -> [Technique] {
        all.filter { $0.category == category }
    }
}

// MARK: - Definitions

extension TechniqueID {

    var definition: Technique {

        switch self {

        // ============================================================
        // MARK: Kamae
        // ============================================================

        case .gankakuKamae:
            Technique(
                id: self,
                romaji: "Gankaku-kamae",
                french: "Garde de la grue",
                category: .kamae,
                description: "Posture combinant tsuru-ashi-dachi pour le bas du corps et manji-uke pour le haut du corps."
            )

        case .gedanKamae:
            Technique(
                id: self,
                romaji: "Gedan-kamae",
                french: "Garde basse",
                category: .kamae,
                description: "La main avant est en parade basse et le poing opposé est en hikité."
            )

        case .gyakuHanmi:
            Technique(
                id: self,
                romaji: "Gyaku-hanmi",
                french: "Profil inversé",
                category: .kamae,
                description: "Posture de profil inversée avec le bassin orienté à environ 45°."
            )

        case .hizaKamae:
            Technique(
                id: self,
                romaji: "Hiza-kamae",
                french: "Garde avec genou levé",
                category: .kamae,
                description: "Un genou est élevé devant le corps afin de le protéger."
            )

        case .jiaiKamae:
            Technique(
                id: self,
                romaji: "Jiai-kamae",
                french: "Posture de bienveillance",
                category: .kamae,
                description: "Debout pieds joints, mains levées devant le menton, la main gauche couvrant le poing droit."
            )

        case .jujiKamae:
            Technique(
                id: self,
                romaji: "Juji-kamae",
                french: "Garde en croix",
                category: .kamae,
                description: "Les bras sont croisés devant le corps, au niveau jodan ou chudan."
            )

        case .kaiunNoTe:
            Technique(
                id: self,
                romaji: "Kaiun-no-te",
                french: "Mains qui séparent les nuages",
                category: .kamae,
                description: "Bras tendus de part et d'autre du corps, mains ouvertes et paumes tournées vers l'extérieur."
            )

        case .kitsutsukiNoKamae:
            Technique(
                id: self,
                romaji: "Kitsutsuki-no-kamae",
                french: "Garde du pic",
                category: .kamae,
                description: "Un poignet est disposé en tête de poulet et l'autre main est crochetée derrière le coude."
            )

        case .kokoKamae:
            Technique(
                id: self,
                romaji: "Koko-kamae",
                french: "Garde gueule du tigre",
                category: .kamae,
                description: "Les mains sont disposées pour pouvoir saisir simultanément la gorge et le bas-ventre."
            )

        case .kosaKamae:
            Technique(
                id: self,
                romaji: "Kosa-kamae",
                french: "Garde croisée basse et moyenne",
                category: .kamae,
                description: "Un bras exécute gedan-barai et l'autre un uchi-ude-uke chudan."
            )

        case .koshiKamae:
            Technique(
                id: self,
                romaji: "Koshi-kamae",
                french: "Garde aux hanches",
                category: .kamae,
                description: "Les deux poings sont tirés au niveau de la même hanche, l'un placé au-dessus de l'autre."
            )

        case .soeteKoshiKamae:
            Technique(
                id: self,
                romaji: "Soete-koshi-kamae",
                french: "Variante de garde aux hanches",
                category: .kamae,
                description: "Variante de koshi-kamae où le poing supérieur repose dans la paume de la main inférieure."
            )

        case .haitoKoshiKamae:
            Technique(
                id: self,
                romaji: "Haito-koshi-kamae",
                french: "Garde haito aux hanches",
                category: .kamae,
                description: "Les mains sont positionnées sur le flanc d'une hanche, une main fermée et l'autre avec le tranchant vers le haut."
            )

        case .manjiKamae:
            Technique(
                id: self,
                romaji: "Manji-kamae",
                french: "Garde manji",
                category: .kamae,
                description: "Un bras effectue gedan-barai tandis que l'autre exécute un uchi-ude-uke haut, généralement en kokutsu-dachi."
            )

        case .mizuNagareNoKamae:
            Technique(
                id: self,
                romaji: "Mizu-nagare-no-kamae",
                french: "Garde de l'eau qui coule",
                category: .kamae,
                description: "Pieds joints, bras dans une position proche de kagi-zuki, avant-bras parallèles à la poitrine et poing arrière en hikité."
            )

        case .ryusuiKamae:
            Technique(
                id: self,
                romaji: "Ryusui-kamae",
                french: "Garde de l'eau courante",
                category: .kamae,
                description: "Variante de mizu-nagare-kamae avec la main avant ouverte sur le poing en hikité."
            )

        case .musoKamae:
            Technique(
                id: self,
                romaji: "Muso-kamae",
                french: "Posture incomparable",
                category: .kamae,
                description: "Un bras est en gedan-barai et l'autre en age-uke, avec le corps de trois-quarts."
            )

        case .ryokenKoshiKamae:
            Technique(
                id: self,
                romaji: "Ryoken-koshi-kamae",
                french: "Garde des deux poings aux hanches",
                category: .kamae,
                description: "Chaque poing est appliqué contre le flanc, au-dessus de sa hanche respective."
            )

        case .ryowanKamae:
            Technique(
                id: self,
                romaji: "Ryowan-kamae",
                french: "Garde des deux bras abaissés",
                category: .kamae,
                description: "Les deux bras sont écartés et tendus vers le bas, symétriquement, avec les poings fermés."
            )

        case .kaishuRyowanKamae:
            Technique(
                id: self,
                romaji: "Kaishu-ryowan-kamae",
                french: "Garde des deux bras, mains ouvertes",
                category: .kamae,
                description: "Variante de ryowan-kamae avec les mains ouvertes."
            )

        case .shizentai:
            Technique(
                id: self,
                romaji: "Shizentai",
                french: "Posture naturelle",
                category: .kamae,
                description: "Posture naturelle debout, pieds écartés de la largeur des hanches, pointes légèrement ouvertes et genoux légèrement fléchis."
            )

        case .yamaKamae:
            Technique(
                id: self,
                romaji: "Yama-kamae",
                french: "Garde de la montagne",
                category: .kamae,
                description: "Corps de profil, bras écartés à hauteur de poitrine, avant-bras verticaux et jambes en kiba-dachi."
            )

        case .kaishuYamaKamae:
            Technique(
                id: self,
                romaji: "Kaishu-yama-kamae",
                french: "Garde de la montagne, mains ouvertes",
                category: .kamae,
                description: "Variante de yama-kamae avec les mains ouvertes."
            )

        // ============================================================
        // MARK: Dachi
        // ============================================================

        case .fudoDachi:
            Technique(
                id: self,
                romaji: "Fudo-dachi",
                french: "Position enracinée",
                category: .dachi,
                description: "Position équilibrée sur les deux jambes, combinant une jambe arrière proche du kiba-dachi et une jambe avant proche du zenkutsu-dachi."
            )

        case .hachijiDachi:
            Technique(
                id: self,
                romaji: "Hachiji-dachi",
                french: "Position naturelle en V",
                category: .dachi,
                description: "Pieds écartés de la largeur des hanches, pointes dirigées vers l'extérieur."
            )

        case .hangetsuDachi:
            Technique(
                id: self,
                romaji: "Hangetsu-dachi",
                french: "Position demi-lune",
                category: .dachi,
                description: "Position proche d'un fudo-dachi accentué à 45°, avec les genoux dirigés vers l'intérieur."
            )

        case .heikoDachi:
            Technique(
                id: self,
                romaji: "Heiko-dachi",
                french: "Position parallèle",
                category: .dachi,
                description: "Pieds parallèles, écartés de la largeur des hanches."
            )

        case .heisokuDachi:
            Technique(
                id: self,
                romaji: "Heisoku-dachi",
                french: "Position pieds joints",
                category: .dachi,
                description: "Les pieds sont joints et parallèles."
            )

        case .kataHizaDachi:
            Technique(
                id: self,
                romaji: "Kata-hiza-dachi",
                french: "Position agenouillée",
                category: .dachi,
                description: "Le genou arrière repose au sol tandis que la jambe avant est fléchie."
            )

        case .kibaDachi:
            Technique(
                id: self,
                romaji: "Kiba-dachi",
                french: "Position du cavalier",
                category: .dachi,
                description: "Pieds parallèles, largement écartés, genoux fléchis et orientés vers l'extérieur, poids réparti également."
            )

        case .kokutsuDachi:
            Technique(
                id: self,
                romaji: "Kokutsu-dachi",
                french: "Position arrière",
                category: .dachi,
                description: "Environ 70 % du poids repose sur la jambe arrière fortement fléchie."
            )

        case .kaseiKokutsuDachi:
            Technique(
                id: self,
                romaji: "Kasei-kokutsu-dachi",
                french: "Position arrière basse",
                category: .dachi,
                description: "Variante plus basse que le kokutsu-dachi classique."
            )

        case .kosaDachi, .kakeDachi:
            Technique(
                id: self,
                romaji: self == .kosaDachi ? "Kosa-dachi" : "Kake-dachi",
                french: "Position jambes croisées",
                category: .dachi,
                description: "Les jambes sont croisées et le poids du corps repose principalement sur la jambe avant."
            )

        case .motoDachi:
            Technique(
                id: self,
                romaji: "Moto-dachi",
                french: "Position fondamentale courte",
                category: .dachi,
                description: "Fente avant raccourcie, souvent appelée petit zenkutsu-dachi."
            )

        case .musubiDachi:
            Technique(
                id: self,
                romaji: "Musubi-dachi",
                french: "Position du salut",
                category: .dachi,
                description: "Talons joints, pointes des pieds écartées en V."
            )

        case .nekoAshiDachi:
            Technique(
                id: self,
                romaji: "Neko-ashi-dachi",
                french: "Position du chat",
                category: .dachi,
                description: "Le poids est placé sur la jambe arrière fléchie ; le pied avant repose légèrement au sol."
            )

        case .renojiDachi:
            Technique(
                id: self,
                romaji: "Renoji-dachi",
                french: "Position en L",
                category: .dachi,
                description: "Les axes des pieds forment un L, avec les talons sur une même ligne."
            )

        case .sagiAshiDachi:
            Technique(
                id: self,
                romaji: "Sagi-ashi-dachi",
                french: "Position du héron",
                category: .dachi,
                description: "Position debout sur une jambe, le pied libre légèrement en avant du genou."
            )

        case .sanchinDachi:
            Technique(
                id: self,
                romaji: "Sanchin-dachi",
                french: "Position du sablier",
                category: .dachi,
                description: "Les pieds sont rapprochés sur une même ligne et les orteils orientés vers l'intérieur, genoux resserrés."
            )

        case .shikoDachi:
            Technique(
                id: self,
                romaji: "Shiko-dachi",
                french: "Position du sumotori",
                category: .dachi,
                description: "Position proche du kiba-dachi, mais avec les pointes de pieds dirigées vers l'extérieur."
            )

        case .sochinDachi:
            Technique(
                id: self,
                romaji: "Sochin-dachi",
                french: "Position Sochin",
                category: .dachi,
                description: "Position proche du kiba-dachi, orientée à 45° par rapport à la ligne d'attaque."
            )

        case .teijiDachi:
            Technique(
                id: self,
                romaji: "Teiji-dachi",
                french: "Position en T",
                category: .dachi,
                description: "Les pieds sont pratiquement perpendiculaires, le talon du pied avant étant au milieu du pied arrière."
            )

        case .tsuruAshiDachi, .gangakuDachi:
            Technique(
                id: self,
                romaji: self == .tsuruAshiDachi ? "Tsuru-ashi-dachi" : "Gangaku-dachi",
                french: "Position de la grue",
                category: .dachi,
                description: "Position sur une jambe, le pied libre étant crocheté derrière le genou de la jambe d'appui."
            )

        case .uchiHachijiDachi:
            Technique(
                id: self,
                romaji: "Uchi-hachiji-dachi",
                french: "Position naturelle en V inversé",
                category: .dachi,
                description: "Pieds écartés de la largeur des hanches avec les pointes dirigées vers l'intérieur."
            )

        case .zenkutsuDachi:
            Technique(
                id: self,
                romaji: "Zenkutsu-dachi",
                french: "Position avant",
                category: .dachi,
                description: "Jambe avant fléchie et chargée à environ 70 %, jambe arrière tendue, pieds orientés dans le sens du déplacement."
            )

        // ============================================================
        // MARK: Unsoku
        // ============================================================

        case .ayumiAshi:
            Technique(
                id: self,
                romaji: "Ayumi-ashi",
                french: "Pas de marche",
                category: .ido,
                description: "Déplacement d'un pas vers l'avant, comme une marche normale."
            )

        case .hikiAshi:
            Technique(
                id: self,
                romaji: "Hiki-ashi",
                french: "Pas arrière",
                category: .ido,
                description: "Reculer d'un pas afin d'absorber une attaque et retrouver sa stabilité."
            )

        case .mawariAshi:
            Technique(
                id: self,
                romaji: "Mawari-ashi",
                french: "Rotation sur la jambe avant",
                category: .ido,
                description: "Rotation autour du pied avant qui sert de pivot."
            )

        case .omawariAshi:
            Technique(
                id: self,
                romaji: "Omawari-ashi",
                french: "Grande rotation",
                category: .ido,
                description: "Forme ample de mawari-ashi."
            )

        case .okuriAshi:
            Technique(
                id: self,
                romaji: "Okuri-ashi",
                french: "Double pas",
                category: .ido,
                description: "Double pas permettant d'avancer rapidement sans changer de garde."
            )

        case .suriAshi:
            Technique(
                id: self,
                romaji: "Suri-ashi",
                french: "Pas glissé",
                category: .ido,
                description: "Déplacement glissé sans décoller les pieds du sol."
            )

        case .tsugiAshi:
            Technique(
                id: self,
                romaji: "Tsugi-ashi",
                french: "Pas chassé",
                category: .ido,
                description: "Le corps est propulsé vers l'avant sans changement de garde."
            )

        case .ushiroMawariAshi:
            Technique(
                id: self,
                romaji: "Ushiro-mawari-ashi",
                french: "Rotation sur la jambe arrière",
                category: .ido,
                description: "Rotation autour du pied arrière qui sert de pivot."
            )

        case .yoriAshi:
            Technique(
                id: self,
                romaji: "Yori-ashi",
                french: "Pas glissé court",
                category: .ido,
                description: "Pas glissé de faible amplitude, rapide et puissant, utilisable dans toutes les directions."
            )

        // ============================================================
        // MARK: Uke
        // ============================================================

        case .empiUke:
            Technique(
                id: self,
                romaji: "Empi-uke",
                french: "Blocage du coude",
                category: .uke,
                description: "Blocage avec le coude, destiné notamment à protéger le buste."
            )

        case .gedanBarai:
            Technique(
                id: self,
                romaji: "Gedan-barai",
                french: "Défense basse",
                category: .uke,
                description: "Balayage vers le bas avec la partie externe de l'avant-bras."
            )

        case .gedanUchiBarai:
            Technique(
                id: self,
                romaji: "Gedan-uchi-barai",
                french: "Défense basse intérieure",
                category: .uke,
                description: "Gedan-barai exécuté de l'extérieur vers l'intérieur."
            )

        case .haishuUke:
            Technique(
                id: self,
                romaji: "Haishu-uke",
                french: "Blocage avec le dos de la main",
                category: .uke,
                description: "Blocage circulaire effectué avec le dos de la main ouverte."
            )

        case .heikoUke:
            Technique(
                id: self,
                romaji: "Heiko-uke",
                french: "Blocage double parallèle",
                category: .uke,
                description: "Défense double avec les deux bras parallèles sur une même ligne horizontale."
            )

        case .jodanAgeUke:
            Technique(
                id: self,
                romaji: "Jodan-age-uke",
                french: "Blocage montant haut",
                category: .uke,
                description: "Blocage vers le haut avec la partie externe de l'avant-bras pour protéger la tête."
            )

        case .jujiUke:
            Technique(
                id: self,
                romaji: "Juji-uke",
                french: "Blocage croisé",
                category: .uke,
                description: "Défense double avec les deux bras croisés."
            )

        case .jodanJujiUke:
            Technique(
                id: self,
                romaji: "Jodan-juji-uke",
                french: "Blocage croisé haut",
                category: .uke,
                description: "Blocage croisé des mains au niveau du visage."
            )

        case .gedanJujiUke:
            Technique(
                id: self,
                romaji: "Gedan-juji-uke",
                french: "Blocage croisé bas",
                category: .uke,
                description: "Blocage bas avec les poignets croisés."
            )

        case .kakiwakeUke:
            Technique(
                id: self,
                romaji: "Kakiwake-uke",
                french: "Blocage double d'écartement",
                category: .uke,
                description: "Les avant-bras écartent une attaque ou une double saisie de l'intérieur vers l'extérieur."
            )

        case .kokenUke, .kakutoUke:
            Technique(
                id: self,
                romaji: self == .kokenUke ? "Koken-uke" : "Kakuto-uke",
                french: "Blocage avec le poignet plié",
                category: .uke,
                description: "Blocage utilisant le dessus du poignet fortement plié."
            )

        case .manjiUke:
            Technique(
                id: self,
                romaji: "Manji-uke",
                french: "Blocage manji",
                category: .uke,
                description: "Un bras exécute gedan-barai et l'autre un uchi-ude-uke haut."
            )

        case .moroteUchiUke:
            Technique(
                id: self,
                romaji: "Morote-uchi-uke",
                french: "Blocage renforcé",
                category: .uke,
                description: "Uchi-ude-uke renforcé par l'autre main posée sur l'avant-bras."
            )

        case .nagashiUke:
            Technique(
                id: self,
                romaji: "Nagashi-uke",
                french: "Blocage balayé",
                category: .uke,
                description: "La défense accompagne l'attaque adverse au lieu de la stopper brutalement."
            )

        case .teNagashiUke:
            Technique(
                id: self,
                romaji: "Te-nagashi-uke",
                french: "Blocage balayé de la main",
                category: .uke,
                description: "Forme de nagashi-uke réalisée avec la main ouverte."
            )

        case .haiwanNagashiUke:
            Technique(
                id: self,
                romaji: "Haiwan-nagashi-uke",
                french: "Blocage balayé de l'avant-bras",
                category: .uke,
                description: "Forme de nagashi-uke réalisée avec l'avant-bras."
            )

        case .osaeUke:
            Technique(
                id: self,
                romaji: "Osae-uke",
                french: "Blocage poussé vers le bas",
                category: .uke,
                description: "Blocage descendant avec la paume dirigée vers le bas."
            )

        case .otoshiUke:
            Technique(
                id: self,
                romaji: "Otoshi-uke",
                french: "Blocage descendant",
                category: .uke,
                description: "Blocage avec le tranchant externe de l'avant-bras dans un mouvement du haut vers le bas."
            )

        case .shutoUke:
            Technique(
                id: self,
                romaji: "Shuto-uke",
                french: "Blocage en sabre de main",
                category: .uke,
                description: "Blocage latéral effectué avec le tranchant de la main, généralement en kokutsu-dachi."
            )

        case .sotoUdeUke:
            Technique(
                id: self,
                romaji: "Soto-ude-uke",
                french: "Blocage extérieur-intérieur",
                category: .uke,
                description: "Mouvement circulaire de l'extérieur vers l'intérieur avec le côté externe de l'avant-bras."
            )

        case .sukuiUke:
            Technique(
                id: self,
                romaji: "Sukui-uke",
                french: "Blocage en cuillère",
                category: .uke,
                description: "Défense main ouverte destinée notamment à ramasser et soulever une jambe adverse."
            )

        case .uchiSukuiUke:
            Technique(
                id: self,
                romaji: "Uchi-sukui-uke",
                french: "Blocage en cuillère intérieur-extérieur",
                category: .uke,
                description: "Variante de sukui-uke allant de l'intérieur vers l'extérieur."
            )

        case .sotoSukuiUke:
            Technique(
                id: self,
                romaji: "Soto-sukui-uke",
                french: "Blocage en cuillère extérieur-intérieur",
                category: .uke,
                description: "Variante de sukui-uke allant de l'extérieur vers l'intérieur."
            )

        case .tateShutoUke:
            Technique(
                id: self,
                romaji: "Tate-shuto-uke",
                french: "Blocage vertical en sabre de main",
                category: .uke,
                description: "Blocage utilisant une large trajectoire intérieure-extérieure avec le tranchant de la main."
            )

        case .teishoUke:
            Technique(
                id: self,
                romaji: "Teisho-uke",
                french: "Blocage avec le talon de la paume",
                category: .uke,
                description: "Blocage main ouverte avec la partie charnue de la paume."
            )

        case .uchiUdeUke:
            Technique(
                id: self,
                romaji: "Uchi-ude-uke",
                french: "Blocage intérieur-extérieur",
                category: .uke,
                description: "Mouvement circulaire de l'intérieur vers l'extérieur avec la partie interne de l'avant-bras."
            )

        // ============================================================
        // MARK: Tsuki
        // ============================================================

        case .ageZuki:
            Technique(
                id: self,
                romaji: "Age-zuki",
                french: "Coup de poing remontant",
                category: .tsuki,
                description: "Coup de poing remontant sur une trajectoire circulaire, généralement vers le menton."
            )

        case .chokuZuki:
            Technique(
                id: self,
                romaji: "Choku-zuki",
                french: "Coup de poing direct",
                category: .tsuki,
                description: "Coup de poing rectiligne avec rotation complète du poignet à l'impact."
            )

        case .gyakuZuki:
            Technique(
                id: self,
                romaji: "Gyaku-zuki",
                french: "Coup de poing inversé",
                category: .tsuki,
                description: "Coup de poing avec le bras opposé à la jambe avant, accompagné d'une rotation des hanches."
            )

        case .kagiZuki:
            Technique(
                id: self,
                romaji: "Kagi-zuki",
                french: "Coup de poing en crochet",
                category: .tsuki,
                description: "Coup de poing en crochet dans un plan parallèle à la poitrine."
            )

        case .kizamiZuki:
            Technique(
                id: self,
                romaji: "Kizami-zuki",
                french: "Coup de poing avant",
                category: .tsuki,
                description: "Coup de poing avant effectué sur place ou avec yori-ashi."
            )

        case .maeteZuki:
            Technique(
                id: self,
                romaji: "Maete-zuki",
                french: "Coup de poing avant",
                category: .tsuki,
                description: "Coup de poing avec le bras avant, sur place ou avec yori-ashi."
            )

        case .mawashiZuki, .furiZuki:
            Technique(
                id: self,
                romaji: self == .mawashiZuki ? "Mawashi-zuki" : "Furi-zuki",
                french: "Coup de poing circulaire",
                category: .tsuki,
                description: "Coup de poing circulaire de l'extérieur vers l'intérieur."
            )

        case .moroteZuki:
            Technique(
                id: self,
                romaji: "Morote-zuki",
                french: "Double coup de poing",
                category: .tsuki,
                description: "Deux poings frappent simultanément."
            )

        case .heikoZuki:
            Technique(
                id: self,
                romaji: "Heiko-zuki",
                french: "Double coup de poing parallèle",
                category: .tsuki,
                description: "Les deux poings arrivent au même niveau sur une trajectoire horizontale."
            )

        case .hasamiZuki:
            Technique(
                id: self,
                romaji: "Hasami-zuki",
                french: "Double coup de poing en ciseaux",
                category: .tsuki,
                description: "Les deux poings frappent selon deux trajectoires circulaires convergentes."
            )

        case .moroteUraZuki:
            Technique(
                id: self,
                romaji: "Morote-ura-zuki",
                french: "Double ura-zuki",
                category: .tsuki,
                description: "Deux poings frappent simultanément sur une trajectoire ascendante."
            )

        case .awaseZuki:
            Technique(
                id: self,
                romaji: "Awase-zuki",
                french: "Double coup de poing à deux niveaux",
                category: .tsuki,
                description: "Les deux poings frappent simultanément à deux hauteurs différentes."
            )

        case .yamaZuki:
            Technique(
                id: self,
                romaji: "Yama-zuki",
                french: "Double coup de poing montagne",
                category: .tsuki,
                description: "Double frappe à deux niveaux avec rotation des hanches amenant le buste de profil."
            )

        case .nagashiZuki:
            Technique(
                id: self,
                romaji: "Nagashi-zuki",
                french: "Coup de poing avec esquive",
                category: .tsuki,
                description: "Coup de poing avant accompagné d'une esquive du corps juste avant l'impact."
            )

        case .nukite:
            Technique(
                id: self,
                romaji: "Nukite",
                french: "Pique de doigts",
                category: .tsuki,
                description: "Frappe directe avec le bout des doigts vers les points sensibles."
            )

        case .gohonNukite:
            Technique(
                id: self,
                romaji: "Gohon-nukite",
                french: "Pique à cinq doigts",
                category: .tsuki,
                description: "Nukite exécuté avec les cinq doigts alignés."
            )

        case .ipponNukite:
            Technique(
                id: self,
                romaji: "Ippon-nukite",
                french: "Pique à un doigt",
                category: .tsuki,
                description: "Nukite effectué avec un seul doigt."
            )

        case .nihonNukite:
            Technique(
                id: self,
                romaji: "Nihon-nukite",
                french: "Pique à deux doigts",
                category: .tsuki,
                description: "Nukite effectué avec deux doigts, en fourchette ou en pince."
            )

        case .yohonNukite:
            Technique(
                id: self,
                romaji: "Yohon-nukite",
                french: "Pique à quatre doigts",
                category: .tsuki,
                description: "Nukite effectué avec quatre doigts."
            )

        case .oiZuki, .junZuki:
            Technique(
                id: self,
                romaji: self == .oiZuki ? "Oi-zuki" : "Jun-zuki",
                french: "Coup de poing en avançant",
                category: .tsuki,
                description: "Coup de poing direct exécuté avec un pas en avant."
            )

        case .otoshiZuki:
            Technique(
                id: self,
                romaji: "Otoshi-zuki",
                french: "Coup de poing descendant",
                category: .tsuki,
                description: "Coup de poing suivant une trajectoire descendante."
            )

        case .tateZuki:
            Technique(
                id: self,
                romaji: "Tate-zuki",
                french: "Coup de poing vertical",
                category: .tsuki,
                description: "Coup de poing direct avec rotation partielle du poignet, laissant le poing vertical."
            )

        case .teishoZuki:
            Technique(
                id: self,
                romaji: "Teisho-zuki",
                french: "Coup direct de la paume",
                category: .tsuki,
                description: "Attaque directe avec la base de la paume, poignet plié."
            )

        case .uraZuki:
            Technique(
                id: self,
                romaji: "Ura-zuki",
                french: "Coup de poing paume vers le haut",
                category: .tsuki,
                description: "Coup direct avec la paume tournée vers le haut, sans rotation du poignet à l'impact."
            )

        // ============================================================
        // MARK: Uchi
        // ============================================================

        case .empiUchi:
            Technique(
                id: self,
                romaji: "Empi-uchi",
                french: "Frappe de coude",
                category: .uchi,
                description: "Percussion effectuée avec le coude."
            )

        case .maeEmpiUchi:
            Technique(
                id: self,
                romaji: "Mae-empi-uchi",
                french: "Coude circulaire avant",
                category: .uchi,
                description: "Coup de coude circulaire vers l'avant."
            )

        case .otoshiEmpiUchi:
            Technique(
                id: self,
                romaji: "Otoshi-empi-uchi",
                french: "Coude descendant",
                category: .uchi,
                description: "Coup de coude écrasant vers le bas."
            )

        case .tateEmpiUchi:
            Technique(
                id: self,
                romaji: "Tate-empi-uchi",
                french: "Coude remontant",
                category: .uchi,
                description: "Coup de coude remontant."
            )

        case .ushiroEmpiUchi:
            Technique(
                id: self,
                romaji: "Ushiro-empi-uchi",
                french: "Coude arrière",
                category: .uchi,
                description: "Coup de coude vers l'arrière, notamment pour se dégager d'une saisie."
            )

        case .yokoEmpiUchi:
            Technique(
                id: self,
                romaji: "Yoko-empi-uchi",
                french: "Coude latéral",
                category: .uchi,
                description: "Coup de coude latéral en ligne directe."
            )

        case .yokoMawashiEmpiUchi:
            Technique(
                id: self,
                romaji: "Yoko-mawashi-empi-uchi",
                french: "Coude circulaire latéral",
                category: .uchi,
                description: "Coup de coude circulaire fouetté vers l'avant."
            )

        case .haishuUchi:
            Technique(
                id: self,
                romaji: "Haishu-uchi",
                french: "Frappe du dos de la main",
                category: .uchi,
                description: "Frappe avec le dos de la main ouverte dans un mouvement circulaire."
            )

        case .haitoUchi:
            Technique(
                id: self,
                romaji: "Haito-uchi",
                french: "Frappe du tranchant interne",
                category: .uchi,
                description: "Frappe avec le tranchant interne de la main, côté pouce."
            )

        case .kokenUchi, .kakutoUchi:
            Technique(
                id: self,
                romaji: self == .kokenUchi ? "Koken-uchi" : "Kakuto-uchi",
                french: "Frappe du poignet plié",
                category: .uchi,
                description: "Frappe effectuée avec le dessus du poignet fortement plié."
            )

        case .shutoUchi:
            Technique(
                id: self,
                romaji: "Shuto-uchi",
                french: "Frappe du sabre de la main",
                category: .uchi,
                description: "Frappe avec le tranchant externe de la main ouverte."
            )

        case .mawashiShutoUchi:
            Technique(
                id: self,
                romaji: "Mawashi-shuto-uchi",
                french: "Sabar de main circulaire intérieur-extérieur",
                category: .uchi,
                description: "Shuto-uchi allant de l'intérieur vers l'extérieur."
            )

        case .sotoShutoUchi:
            Technique(
                id: self,
                romaji: "Soto-shuto-uchi",
                french: "Sabar de main extérieur-intérieur",
                category: .uchi,
                description: "Shuto-uchi allant de l'extérieur vers l'intérieur."
            )

        case .hasamiShutoUchi:
            Technique(
                id: self,
                romaji: "Hasami-shuto-uchi",
                french: "Double sabre en ciseaux",
                category: .uchi,
                description: "Double frappe shuto effectuée en ciseaux."
            )

        case .teishoUchi:
            Technique(
                id: self,
                romaji: "Teisho-uchi",
                french: "Frappe du talon de la paume",
                category: .uchi,
                description: "Percussion avec le talon de la paume."
            )

        case .hasamiTeishoUchi:
            Technique(
                id: self,
                romaji: "Hasami-teisho-uchi",
                french: "Double frappe de paume en ciseaux",
                category: .uchi,
                description: "Double percussion indirecte des paumes en ciseaux."
            )

        case .tettsuiUchi:
            Technique(
                id: self,
                romaji: "Tettsui-uchi",
                french: "Frappe en marteau",
                category: .uchi,
                description: "Frappe circulaire avec la main en marteau."
            )

        case .moroteTettsuiUchi:
            Technique(
                id: self,
                romaji: "Morote-tettsui-uchi",
                french: "Double frappe en marteau",
                category: .uchi,
                description: "Double tettsui frappant simultanément les flancs."
            )

        case .hasamiTettsuiUchi:
            Technique(
                id: self,
                romaji: "Hasami-tettsui-uchi",
                french: "Double marteau en ciseaux",
                category: .uchi,
                description: "Double frappe tettsui indirecte en ciseaux."
            )

        case .urakenUchi:
            Technique(
                id: self,
                romaji: "Uraken-uchi",
                french: "Frappe du revers du poing",
                category: .uchi,
                description: "Frappe circulaire avec le dos du poing, exécutée comme un fouet."
            )

        case .tateUrakenUchi:
            Technique(
                id: self,
                romaji: "Tate-uraken-uchi",
                french: "Uraken vertical",
                category: .uchi,
                description: "Uraken sur un plan vertical."
            )

        case .urakenShomenUchi:
            Technique(
                id: self,
                romaji: "Uraken-shomen-uchi",
                french: "Uraken frontal",
                category: .uchi,
                description: "Uraken dirigé vers la tête."
            )

        case .yokoUrakenUchi:
            Technique(
                id: self,
                romaji: "Yoko-uraken-uchi",
                french: "Uraken horizontal",
                category: .uchi,
                description: "Uraken sur un plan horizontal, de l'intérieur vers l'extérieur."
            )

        case .seikenMawashiUchi:
            Technique(
                id: self,
                romaji: "Seiken-mawashi-uchi",
                french: "Uraken horizontal extérieur-intérieur",
                category: .uchi,
                description: "Frappe horizontale de l'extérieur vers l'intérieur."
            )

        // ============================================================
        // MARK: Barai
        // ============================================================

        case .ashiBarai:
            Technique(
                id: self,
                romaji: "Ashi-barai",
                french: "Balayage de jambe",
                category: .barai,
                description: "Balayage avec le côté interne du pied."
            )

        case .maeAshiBarai:
            Technique(
                id: self,
                romaji: "Mae-ashi-barai",
                french: "Balayage avec la jambe avant",
                category: .barai,
                description: "Ashi-barai effectué avec la jambe avant."
            )

        case .ushiroAshiBarai:
            Technique(
                id: self,
                romaji: "Ushiro-ashi-barai",
                french: "Balayage avec la jambe arrière",
                category: .barai,
                description: "Ashi-barai effectué avec la jambe arrière après pivot du corps."
            )

        case .tobiAshiBarai:
            Technique(
                id: self,
                romaji: "Tobi-ashi-barai",
                french: "Balayage sauté",
                category: .barai,
                description: "Balayage de jambe effectué en sautant."
            )

        case .ushiroMawashiBarai:
            Technique(
                id: self,
                romaji: "Ushiro-mawashi-barai",
                french: "Balayage tournant arrière",
                category: .barai,
                description: "Balayage tournant vers l'arrière effectué avec le talon dans un large mouvement circulaire."
            )

        // ============================================================
        // MARK: Geri
        // ============================================================

        case .fumikiri:
            Technique(
                id: self,
                romaji: "Fumikiri",
                french: "Coup de pied coupant",
                category: .geri,
                description: "Coup de pied bas oblique donné avec le tranchant interne ou externe du pied."
            )

        case .fumikomiGeri:
            Technique(
                id: self,
                romaji: "Fumikomi-geri",
                french: "Coup de pied écrasant",
                category: .geri,
                description: "Coup de pied oblique et écrasant donné avec le tranchant, le talon ou la plante du pied."
            )

        case .gedanGeri:
            Technique(
                id: self,
                romaji: "Gedan-geri",
                french: "Coup de pied bas",
                category: .geri,
                description: "Frappe basse avec le tranchant interne du pied."
            )

        case .sokutoFumikomi:
            Technique(
                id: self,
                romaji: "Sokuto-fumikomi",
                french: "Coup écrasant du tranchant externe",
                category: .geri,
                description: "Frappe écrasante avec le tranchant externe du pied."
            )

        case .kansetsuGeri:
            Technique(
                id: self,
                romaji: "Kansetsu-geri",
                french: "Coup de pied à l'articulation",
                category: .geri,
                description: "Frappe dirigée vers le côté du genou."
            )

        case .ushiroFumikomi:
            Technique(
                id: self,
                romaji: "Ushiro-fumikomi",
                french: "Coup écrasant arrière",
                category: .geri,
                description: "Frappe du talon vers la cheville ou le pied de l'adversaire."
            )

        case .hizaGeri, .hitsuiGeri:
            Technique(
                id: self,
                romaji: self == .hizaGeri ? "Hiza-geri" : "Hitsui-geri",
                french: "Coup de genou",
                category: .geri,
                description: "Percussion avec le genou, particulièrement adaptée au corps-à-corps."
            )

        case .kakatoGeri:
            Technique(
                id: self,
                romaji: "Kakato-geri",
                french: "Coup de talon",
                category: .geri,
                description: "Attaque effectuée avec le talon."
            )

        case .maeKakatoGeri:
            Technique(
                id: self,
                romaji: "Mae-kakato-geri",
                french: "Coup de talon avant",
                category: .geri,
                description: "Frappe du talon vers l'avant, cheville fortement pliée."
            )

        case .maeGeri:
            Technique(
                id: self,
                romaji: "Mae-geri",
                french: "Coup de pied avant",
                category: .geri,
                description: "Coup de pied direct vers l'avant, généralement avec le koshi."
            )

        case .maeAshiMaeGeri, .kizamiMaeGeri:
            Technique(
                id: self,
                romaji: self == .maeAshiMaeGeri ? "Mae-ashi-mae-geri" : "Kizami-mae-geri",
                french: "Mae-geri jambe avant",
                category: .geri,
                description: "Mae-geri donné avec le pied avant."
            )

        case .ushiroAshiMaeGeri:
            Technique(
                id: self,
                romaji: "Ushiro-ashi-mae-geri",
                french: "Mae-geri jambe arrière",
                category: .geri,
                description: "Mae-geri effectué avec la jambe arrière."
            )

        case .maeGeriKeage:
            Technique(
                id: self,
                romaji: "Mae-geri-keage",
                french: "Mae-geri fouetté",
                category: .geri,
                description: "Coup de pied direct fouetté vers l'avant, ramené rapidement."
            )

        case .maeSokutoGeri:
            Technique(
                id: self,
                romaji: "Mae-sokuto-geri",
                french: "Coup de pied avant au tranchant",
                category: .geri,
                description: "Coup de pied direct avec le tranchant externe du pied."
            )

        case .nidanGeri:
            Technique(
                id: self,
                romaji: "Nidan-geri",
                french: "Double coup de pied sauté",
                category: .geri,
                description: "Coup de pied sauté enchaînant deux mae-geri à deux niveaux."
            )

        case .surikondeMaeGeri:
            Technique(
                id: self,
                romaji: "Surikonde-mae-geri",
                french: "Mae-geri après pas chassé",
                category: .geri,
                description: "Mae-geri effectué après un pas chassé."
            )

        case .tobikondeMaeGeri:
            Technique(
                id: self,
                romaji: "Tobikonde-mae-geri",
                french: "Mae-geri après pas croisé",
                category: .geri,
                description: "Mae-geri effectué après un pas croisé."
            )

        case .tobiMaeGeri:
            Technique(
                id: self,
                romaji: "Tobi-mae-geri",
                french: "Mae-geri sauté",
                category: .geri,
                description: "Mae-geri effectué en sautant."
            )

        case .mawashiGeri:
            Technique(
                id: self,
                romaji: "Mawashi-geri",
                french: "Coup de pied circulaire",
                category: .geri,
                description: "Coup de pied circulaire de l'extérieur vers l'intérieur."
            )

        case .maeAshiMawashiGeri, .kizamiMawashiGeri:
            Technique(
                id: self,
                romaji: self == .maeAshiMawashiGeri
                    ? "Mae-ashi-mawashi-geri"
                    : "Kizami-mawashi-geri",
                french: "Mawashi-geri jambe avant",
                category: .geri,
                description: "Mawashi-geri donné avec la jambe avant."
            )

        case .ushiroAshiMawashiGeri:
            Technique(
                id: self,
                romaji: "Ushiro-ashi-mawashi-geri",
                french: "Mawashi-geri jambe arrière",
                category: .geri,
                description: "Mawashi-geri donné avec la jambe arrière."
            )

        case .kaseiMawashiGeri:
            Technique(
                id: self,
                romaji: "Kasei-mawashi-geri",
                french: "Mawashi-geri en contre-plongée",
                category: .geri,
                description: "Mawashi-geri délivré par-dessous ou depuis le sol."
            )

        case .surikondeMawashiGeri:
            Technique(
                id: self,
                romaji: "Surikonde-mawashi-geri",
                french: "Mawashi-geri après pas chassé",
                category: .geri,
                description: "Mawashi-geri effectué après un pas chassé."
            )

        case .tobikondeMawashiGeri:
            Technique(
                id: self,
                romaji: "Tobikonde-mawashi-geri",
                french: "Mawashi-geri après pas croisé",
                category: .geri,
                description: "Mawashi-geri effectué après un pas croisé."
            )

        case .tobiMawashiGeri:
            Technique(
                id: self,
                romaji: "Tobi-mawashi-geri",
                french: "Mawashi-geri sauté",
                category: .geri,
                description: "Mawashi-geri effectué en sautant."
            )

        case .mikazukiGeri:
            Technique(
                id: self,
                romaji: "Mikazuki-geri",
                french: "Coup de pied en croissant",
                category: .geri,
                description: "Coup de pied en croissant avec la plante du pied, de l'extérieur vers l'intérieur."
            )

        case .gyakuMikazukiGeri:
            Technique(
                id: self,
                romaji: "Gyaku-mikazuki-geri",
                french: "Croissant inversé",
                category: .geri,
                description: "Coup de pied en croissant de l'intérieur vers l'extérieur."
            )

        case .surikondeMikazukiGeri:
            Technique(
                id: self,
                romaji: "Surikonde-mikazuki-geri",
                french: "Mikazuki-geri après pas chassé",
                category: .geri,
                description: "Mikazuki-geri effectué après un pas chassé."
            )

        case .tobikondeMikazukiGeri:
            Technique(
                id: self,
                romaji: "Tobikonde-mikazuki-geri",
                french: "Mikazuki-geri après pas croisé",
                category: .geri,
                description: "Mikazuki-geri effectué après un pas croisé."
            )

        case .namiAshi:
            Technique(
                id: self,
                romaji: "Nami-ashi",
                french: "Coup de pied en vague",
                category: .geri,
                description: "Mouvement remontant avec la plante du pied, notamment utilisé pour balayer une attaque basse."
            )

        case .tobiGeri:
            Technique(
                id: self,
                romaji: "Tobi-geri",
                french: "Coup de pied sauté",
                category: .geri,
                description: "Famille de coups de pied exécutés en sautant."
            )

        case .tobiUshiroMawashiGeri:
            Technique(
                id: self,
                romaji: "Tobi-ushiro-mawashi-geri",
                french: "Coup de pied sauté circulaire arrière",
                category: .geri,
                description: "Coup de pied sauté circulaire arrière avec pivot du buste et ouverture de la hanche."
            )

        case .tobiYokoGeri:
            Technique(
                id: self,
                romaji: "Tobi-yoko-geri",
                french: "Coup de pied latéral sauté",
                category: .geri,
                description: "Coup de pied latéral effectué en sautant."
            )

        case .uraMawashiGeri:
            Technique(
                id: self,
                romaji: "Ura-mawashi-geri",
                french: "Coup de pied circulaire inversé",
                category: .geri,
                description: "Coup de pied en revers tournant, de l'intérieur vers l'extérieur, avec la plante ou le talon."
            )

        case .ushiroGeri:
            Technique(
                id: self,
                romaji: "Ushiro-geri",
                french: "Coup de pied arrière",
                category: .geri,
                description: "Coup de pied direct vers l'arrière donné avec le talon."
            )

        case .maeAshiUshiroGeri:
            Technique(
                id: self,
                romaji: "Mae-ashi-ushiro-geri",
                french: "Coup de pied arrière jambe avant",
                category: .geri,
                description: "Ushiro-geri effectué avec la jambe avant."
            )

        case .ushiroAshiUshiroGeri:
            Technique(
                id: self,
                romaji: "Ushiro-ashi-ushiro-geri",
                french: "Coup de pied arrière jambe arrière",
                category: .geri,
                description: "Ushiro-geri effectué avec la jambe arrière."
            )

        case .ushiroGeriKekomi:
            Technique(
                id: self,
                romaji: "Ushiro-geri-kekomi",
                french: "Coup de pied arrière pénétrant",
                category: .geri,
                description: "Frappe pénétrante du talon ou du tranchant du pied."
            )

        case .yokoGeri:
            Technique(
                id: self,
                romaji: "Yoko-geri",
                french: "Coup de pied latéral",
                category: .geri,
                description: "Coup de pied latéral avec le tranchant externe du pied ou le talon."
            )

        case .yokoGeriKeage:
            Technique(
                id: self,
                romaji: "Yoko-geri-keage",
                french: "Coup de pied latéral fouetté",
                category: .geri,
                description: "Coup de pied latéral fouetté."
            )

        case .yokoGeriKekomi:
            Technique(
                id: self,
                romaji: "Yoko-geri-kekomi",
                french: "Coup de pied latéral pénétrant",
                category: .geri,
                description: "Coup de pied latéral pénétrant avec poussée des hanches."
            )

        case .maeAshiYokoGeri:
            Technique(
                id: self,
                romaji: "Mae-ashi-yoko-geri",
                french: "Yoko-geri jambe avant",
                category: .geri,
                description: "Coup de pied latéral donné avec la jambe avant."
            )

        case .ushiroAshiYokoGeri:
            Technique(
                id: self,
                romaji: "Ushiro-ashi-yoko-geri",
                french: "Yoko-geri jambe arrière",
                category: .geri,
                description: "Coup de pied latéral donné avec la jambe arrière."
            )
        }
    }
}
