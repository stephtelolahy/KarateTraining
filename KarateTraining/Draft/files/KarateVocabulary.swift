//
//  KarateVocabulary.swift
//  KataKit — Shotokan kata modelisation
//
//  All "well known" domain values are modelled as string-backed enums so they are
//  Codable, exhaustive (`CaseIterable`), and usable directly as SwiftUI pickers.
//

import Foundation

// MARK: - Naming

/// Shared behaviour for every karate term: a romaji reading, the kanji, and an
/// English translation. Raw values are camelCase identifiers; romaji is derived.
public protocol KarateTerm: RawRepresentable, CaseIterable, Codable, Hashable, Identifiable
where RawValue == String {
    /// Suffix appended to the romaji reading (e.g. `-dachi`, `-uke`). Empty by default.
    static var romajiSuffix: String { get }
    var kanji: String { get }
    var english: String { get }
}

public extension KarateTerm {
    static var romajiSuffix: String { "" }

    var id: String { rawValue }

    /// "uchiHachiji" + suffix "-dachi" -> "uchi-hachiji-dachi"
    var romaji: String { KarateNaming.hyphenated(rawValue) + Self.romajiSuffix }

    /// Human readable label, e.g. "gedan-barai (downward block)".
    var displayName: String { "\(romaji) (\(english))" }
}

public enum KarateNaming {
    public static func hyphenated(_ raw: String) -> String {
        var out = ""
        for ch in raw {
            if ch.isUppercase { out.append("-"); out.append(Character(ch.lowercased())) }
            else { out.append(ch) }
        }
        return out
    }
}

// MARK: - Height / side / body weapon

/// Height level of a technique (also used as a target height).
public enum Level: String, KarateTerm {
    case jodan, chudan, gedan

    public var kanji: String {
        switch self {
        case .jodan: "上段"
        case .chudan: "中段"
        case .gedan: "下段"
        }
    }

    public var english: String {
        switch self {
        case .jodan: "upper level (head/neck)"
        case .chudan: "middle level (torso)"
        case .gedan: "lower level (below the belt)"
        }
    }
}

/// Which limb performs the technique.
public enum Side: String, KarateTerm {
    case hidari      // left
    case migi        // right
    case morote      // both hands / two-handed
    case unspecified

    public var kanji: String {
        switch self {
        case .hidari: "左"
        case .migi: "右"
        case .morote: "諸手"
        case .unspecified: ""
        }
    }

    public var english: String {
        switch self {
        case .hidari: "left"
        case .migi: "right"
        case .morote: "both / two-handed"
        case .unspecified: "unspecified"
        }
    }

    /// Used when mirroring a whole kata.
    public var mirrored: Side {
        switch self {
        case .hidari: .migi
        case .migi: .hidari
        default: self
        }
    }
}

/// The striking or blocking surface actually used (buki / body weapon).
public enum BodyWeapon: String, KarateTerm {
    // hand
    case seiken, uraken, tettsui, shuto, haito, haishu, teisho, nukite
    case ipponKen, nakadakaKen, washide, keito, kumade, koko, seiryuto
    // arm
    case empi, haiwan, naiwan, gaiwan, hiji
    // leg
    case koshi, sokuto, kakato, haisoku, tsumasaki, hiza, sune

    public var kanji: String {
        switch self {
        case .seiken: "正拳"; case .uraken: "裏拳"; case .tettsui: "鉄槌"
        case .shuto: "手刀"; case .haito: "背刀"; case .haishu: "背手"
        case .teisho: "底掌"; case .nukite: "貫手"; case .ipponKen: "一本拳"
        case .nakadakaKen: "中高拳"; case .washide: "鷲手"; case .keito: "鶏頭"
        case .kumade: "熊手"; case .koko: "虎口"; case .seiryuto: "青柳刀"
        case .empi: "猿臂"; case .haiwan: "背腕"; case .naiwan: "内腕"
        case .gaiwan: "外腕"; case .hiji: "肘"
        case .koshi: "腰"; case .sokuto: "足刀"; case .kakato: "踵"
        case .haisoku: "背足"; case .tsumasaki: "爪先"; case .hiza: "膝"; case .sune: "脛"
        }
    }

    public var english: String {
        switch self {
        case .seiken: "fore-fist"; case .uraken: "back-fist"; case .tettsui: "hammer-fist"
        case .shuto: "knife-hand"; case .haito: "ridge-hand"; case .haishu: "back-hand"
        case .teisho: "palm-heel"; case .nukite: "spear-hand"; case .ipponKen: "one-knuckle fist"
        case .nakadakaKen: "middle-finger knuckle fist"; case .washide: "eagle hand"
        case .keito: "chicken-head wrist"; case .kumade: "bear hand"; case .koko: "tiger mouth"
        case .seiryuto: "ox-jaw hand"
        case .empi: "elbow"; case .haiwan: "back of the forearm"; case .naiwan: "inner forearm"
        case .gaiwan: "outer forearm"; case .hiji: "elbow (alt. reading)"
        case .koshi: "ball of the foot"; case .sokuto: "foot edge"; case .kakato: "heel"
        case .haisoku: "instep"; case .tsumasaki: "toe tips"; case .hiza: "knee"; case .sune: "shin"
        }
    }
}

// MARK: - Stances (dachi)

public enum Dachi: String, KarateTerm {
    case heisoku, musubi, heiko, hachiji, uchiHachiji, shizentai
    case zenkutsu, kokutsu, kiba, shiko, fudo, moto
    case nekoashi, sanchin, hangetsu, kosa, tsuruashi, renoji, teiji, jigotai

    public static var romajiSuffix: String { "-dachi" }

    public var kanji: String {
        switch self {
        case .heisoku: "閉足立"; case .musubi: "結び立"; case .heiko: "平行立"
        case .hachiji: "八字立"; case .uchiHachiji: "内八字立"; case .shizentai: "自然体"
        case .zenkutsu: "前屈立"; case .kokutsu: "後屈立"; case .kiba: "騎馬立"
        case .shiko: "四股立"; case .fudo: "不動立"; case .moto: "基立"
        case .nekoashi: "猫足立"; case .sanchin: "三戦立"; case .hangetsu: "半月立"
        case .kosa: "交差立"; case .tsuruashi: "鶴足立"; case .renoji: "レの字立"
        case .teiji: "丁字立"; case .jigotai: "自護体"
        }
    }

    public var english: String {
        switch self {
        case .heisoku: "closed-feet stance"; case .musubi: "open-foot attention stance"
        case .heiko: "parallel stance"; case .hachiji: "natural open-leg stance"
        case .uchiHachiji: "inverted open-leg stance"; case .shizentai: "natural posture"
        case .zenkutsu: "front stance"; case .kokutsu: "back stance"; case .kiba: "horse-riding stance"
        case .shiko: "square stance"; case .fudo: "rooted stance (sochin-dachi)"
        case .moto: "short front stance"; case .nekoashi: "cat-foot stance"
        case .sanchin: "hourglass stance"; case .hangetsu: "half-moon stance"
        case .kosa: "crossed-feet stance"; case .tsuruashi: "crane stance"
        case .renoji: "L stance"; case .teiji: "T stance"; case .jigotai: "defensive straddle stance"
        }
    }

    /// Stances whose weight is essentially on one leg — useful for balance warnings.
    public var isOneLegged: Bool { self == .tsuruashi }
}

// MARK: - Guard positions (kamae)

public enum Kamae: String, KarateTerm {
    case yoi, naore, kamaete, shizentai
    case jodanKamae, chudanKamae, gedanKamae
    case manjiKamae, moroteKamae, ryowanKamae, kosaKamae, haiwanKamae, nekoashiKamae

    public var kanji: String {
        switch self {
        case .yoi: "用意"; case .naore: "直れ"; case .kamaete: "構えて"; case .shizentai: "自然体"
        case .jodanKamae: "上段構え"; case .chudanKamae: "中段構え"; case .gedanKamae: "下段構え"
        case .manjiKamae: "卍構え"; case .moroteKamae: "諸手構え"; case .ryowanKamae: "両腕構え"
        case .kosaKamae: "交差構え"; case .haiwanKamae: "背腕構え"; case .nekoashiKamae: "猫足構え"
        }
    }

    public var english: String {
        switch self {
        case .yoi: "ready position"; case .naore: "return to rest"; case .kamaete: "assume the guard"
        case .shizentai: "natural posture"; case .jodanKamae: "upper guard"
        case .chudanKamae: "middle guard"; case .gedanKamae: "lower guard"
        case .manjiKamae: "swastika guard (high/low opposite arms)"
        case .moroteKamae: "two-handed guard"; case .ryowanKamae: "both-arms guard"
        case .kosaKamae: "crossed-arms guard"; case .haiwanKamae: "back-forearm guard"
        case .nekoashiKamae: "cat-stance guard"
        }
    }
}

// MARK: - Blocks (uke)

public enum Uke: String, KarateTerm {
    case gedanBarai, ageUke, sotoUke, uchiUke, shutoUke, moroteUke
    case jujiUke, kakiwakeUke, haishuUke, teishoUke, osaeUke, sukuiUke
    case nagashiUke, otoshiUke, tateShutoUke, manjiUke, kakeUke
    case keitoUke, washideUke, empiUke, haiwanUke, awaseUke, kosaUke

    public var kanji: String {
        switch self {
        case .gedanBarai: "下段払い"; case .ageUke: "上げ受け"; case .sotoUke: "外受け"
        case .uchiUke: "内受け"; case .shutoUke: "手刀受け"; case .moroteUke: "諸手受け"
        case .jujiUke: "十字受け"; case .kakiwakeUke: "掻き分け受け"; case .haishuUke: "背手受け"
        case .teishoUke: "底掌受け"; case .osaeUke: "押さえ受け"; case .sukuiUke: "掬い受け"
        case .nagashiUke: "流し受け"; case .otoshiUke: "落とし受け"; case .tateShutoUke: "縦手刀受け"
        case .manjiUke: "卍受け"; case .kakeUke: "掛け受け"; case .keitoUke: "鶏頭受け"
        case .washideUke: "鷲手受け"; case .empiUke: "猿臂受け"; case .haiwanUke: "背腕受け"
        case .awaseUke: "合わせ受け"; case .kosaUke: "交差受け"
        }
    }

    public var english: String {
        switch self {
        case .gedanBarai: "downward sweeping block"; case .ageUke: "rising block"
        case .sotoUke: "outside-inward block"; case .uchiUke: "inside-outward block"
        case .shutoUke: "knife-hand block"; case .moroteUke: "augmented forearm block"
        case .jujiUke: "X block"; case .kakiwakeUke: "wedge block"
        case .haishuUke: "back-hand block"; case .teishoUke: "palm-heel block"
        case .osaeUke: "pressing block"; case .sukuiUke: "scooping block"
        case .nagashiUke: "flowing/deflecting block"; case .otoshiUke: "dropping block"
        case .tateShutoUke: "vertical knife-hand block"; case .manjiUke: "swastika block"
        case .kakeUke: "hooking block"; case .keitoUke: "chicken-head wrist block"
        case .washideUke: "eagle-hand block"; case .empiUke: "elbow block"
        case .haiwanUke: "back-forearm block"; case .awaseUke: "joined-hands block"
        case .kosaUke: "crossed block"
        }
    }

    /// Default height usually taught for this block (can be overridden per movement).
    public var defaultLevel: Level {
        switch self {
        case .gedanBarai, .otoshiUke, .osaeUke, .sukuiUke: .gedan
        case .ageUke, .haishuUke, .nagashiUke: .jodan
        default: .chudan
        }
    }
}

// MARK: - Punches (tsuki / zuki)

public enum Tsuki: String, KarateTerm {
    case chokuZuki, oiZuki, gyakuZuki, kizamiZuki, uraZuki, moroteZuki
    case yamaZuki, awaseZuki, heikoZuki, hasamiZuki, tateZuki, kagiZuki
    case ageZuki, mawashiZuki, nukiteZuki, ipponNukite, nihonNukite, tobikomiZuki

    public var kanji: String {
        switch self {
        case .chokuZuki: "直突き"; case .oiZuki: "追い突き"; case .gyakuZuki: "逆突き"
        case .kizamiZuki: "刻み突き"; case .uraZuki: "裏突き"; case .moroteZuki: "諸手突き"
        case .yamaZuki: "山突き"; case .awaseZuki: "合わせ突き"; case .heikoZuki: "平行突き"
        case .hasamiZuki: "鋏突き"; case .tateZuki: "縦突き"; case .kagiZuki: "鉤突き"
        case .ageZuki: "上げ突き"; case .mawashiZuki: "回し突き"; case .nukiteZuki: "貫手突き"
        case .ipponNukite: "一本貫手"; case .nihonNukite: "二本貫手"; case .tobikomiZuki: "飛び込み突き"
        }
    }

    public var english: String {
        switch self {
        case .chokuZuki: "straight punch"; case .oiZuki: "lunge punch"
        case .gyakuZuki: "reverse punch"; case .kizamiZuki: "jab (leading punch)"
        case .uraZuki: "close punch"; case .moroteZuki: "double-fist punch"
        case .yamaZuki: "mountain punch"; case .awaseZuki: "combined punch"
        case .heikoZuki: "parallel punch"; case .hasamiZuki: "scissors punch"
        case .tateZuki: "vertical-fist punch"; case .kagiZuki: "hook punch"
        case .ageZuki: "rising punch"; case .mawashiZuki: "roundhouse punch"
        case .nukiteZuki: "spear-hand thrust"; case .ipponNukite: "one-finger spear hand"
        case .nihonNukite: "two-finger spear hand"; case .tobikomiZuki: "jumping-in punch"
        }
    }
}

// MARK: - Strikes (uchi)

public enum Uchi: String, KarateTerm {
    case urakenUchi, tettsuiUchi, shutoUchi, haitoUchi, haishuUchi, teishoUchi
    case seiryutoUchi, kumadeUchi, otoshiUchi, mawashiUchi, yokoUchi, ageUchi
    case shutoSakotsuUchi, shutoSakotsuUchikomi, ushiroUchi

    public var kanji: String {
        switch self {
        case .urakenUchi: "裏拳打ち"; case .tettsuiUchi: "鉄槌打ち"; case .shutoUchi: "手刀打ち"
        case .haitoUchi: "背刀打ち"; case .haishuUchi: "背手打ち"; case .teishoUchi: "底掌打ち"
        case .seiryutoUchi: "青柳刀打ち"; case .kumadeUchi: "熊手打ち"; case .otoshiUchi: "落とし打ち"
        case .mawashiUchi: "回し打ち"; case .yokoUchi: "横打ち"; case .ageUchi: "上げ打ち"
        case .shutoSakotsuUchi: "手刀鎖骨打ち"; case .shutoSakotsuUchikomi: "手刀鎖骨打ち込み"
        case .ushiroUchi: "後ろ打ち"
        }
    }

    public var english: String {
        switch self {
        case .urakenUchi: "back-fist strike"; case .tettsuiUchi: "hammer-fist strike"
        case .shutoUchi: "knife-hand strike"; case .haitoUchi: "ridge-hand strike"
        case .haishuUchi: "back-hand strike"; case .teishoUchi: "palm-heel strike"
        case .seiryutoUchi: "ox-jaw strike"; case .kumadeUchi: "bear-hand strike"
        case .otoshiUchi: "dropping strike"; case .mawashiUchi: "roundhouse strike"
        case .yokoUchi: "side strike"; case .ageUchi: "rising strike"
        case .shutoSakotsuUchi: "knife-hand collarbone strike"
        case .shutoSakotsuUchikomi: "knife-hand collarbone driving strike"
        case .ushiroUchi: "rearward strike"
        }
    }
}

// MARK: - Elbow techniques (empi / hiji ate)

public enum Empi: String, KarateTerm {
    case maeEmpi, yokoEmpi, ushiroEmpi, tateEmpi, otoshiEmpi, mawashiEmpi

    public var kanji: String {
        switch self {
        case .maeEmpi: "前猿臂"; case .yokoEmpi: "横猿臂"; case .ushiroEmpi: "後ろ猿臂"
        case .tateEmpi: "縦猿臂"; case .otoshiEmpi: "落とし猿臂"; case .mawashiEmpi: "回し猿臂"
        }
    }

    public var english: String {
        switch self {
        case .maeEmpi: "forward elbow strike"; case .yokoEmpi: "side elbow strike"
        case .ushiroEmpi: "rear elbow strike"; case .tateEmpi: "upward elbow strike"
        case .otoshiEmpi: "downward elbow strike"; case .mawashiEmpi: "roundhouse elbow strike"
        }
    }
}

// MARK: - Kicks (keri / geri)

public enum Keri: String, KarateTerm {
    case maeGeriKeage, maeGeriKekomi, yokoGeriKeage, yokoGeriKekomi
    case mawashiGeri, uraMawashiGeri, ushiroGeri, ushiroMawashiGeri
    case mikazukiGeri, gyakuMikazukiGeri, fumikomi, fumikiri
    case hizaGeri, kinGeri, namiGaeshi, ashiBarai, kansetsuGeri
    case tobiGeri, nidanGeri, mikazukiGeriTobi

    public var kanji: String {
        switch self {
        case .maeGeriKeage: "前蹴り上げ"; case .maeGeriKekomi: "前蹴り込み"
        case .yokoGeriKeage: "横蹴り上げ"; case .yokoGeriKekomi: "横蹴り込み"
        case .mawashiGeri: "回し蹴り"; case .uraMawashiGeri: "裏回し蹴り"
        case .ushiroGeri: "後ろ蹴り"; case .ushiroMawashiGeri: "後ろ回し蹴り"
        case .mikazukiGeri: "三日月蹴り"; case .gyakuMikazukiGeri: "逆三日月蹴り"
        case .fumikomi: "踏み込み"; case .fumikiri: "踏み切り"; case .hizaGeri: "膝蹴り"
        case .kinGeri: "金蹴り"; case .namiGaeshi: "波返し"; case .ashiBarai: "足払い"
        case .kansetsuGeri: "関節蹴り"; case .tobiGeri: "飛び蹴り"; case .nidanGeri: "二段蹴り"
        case .mikazukiGeriTobi: "飛び三日月蹴り"
        }
    }

    public var english: String {
        switch self {
        case .maeGeriKeage: "front snap kick"; case .maeGeriKekomi: "front thrust kick"
        case .yokoGeriKeage: "side snap kick"; case .yokoGeriKekomi: "side thrust kick"
        case .mawashiGeri: "roundhouse kick"; case .uraMawashiGeri: "hook kick"
        case .ushiroGeri: "back kick"; case .ushiroMawashiGeri: "spinning hook kick"
        case .mikazukiGeri: "crescent kick"; case .gyakuMikazukiGeri: "inside crescent kick"
        case .fumikomi: "stamping kick"; case .fumikiri: "cutting stamp kick"
        case .hizaGeri: "knee strike"; case .kinGeri: "groin kick"
        case .namiGaeshi: "returning wave kick"; case .ashiBarai: "foot sweep"
        case .kansetsuGeri: "joint (knee) kick"; case .tobiGeri: "jumping kick"
        case .nidanGeri: "double jumping kick"; case .mikazukiGeriTobi: "jumping crescent kick"
        }
    }

    public var defaultWeapon: BodyWeapon {
        switch self {
        case .maeGeriKeage, .maeGeriKekomi, .mawashiGeri: .koshi
        case .yokoGeriKeage, .yokoGeriKekomi, .fumikomi, .fumikiri, .kansetsuGeri: .sokuto
        case .ushiroGeri, .ushiroMawashiGeri, .uraMawashiGeri: .kakato
        case .hizaGeri: .hiza
        case .mikazukiGeri, .gyakuMikazukiGeri, .mikazukiGeriTobi, .namiGaeshi: .haisoku
        default: .koshi
        }
    }
}

// MARK: - Throws, grabs and joint techniques (nage / tsukami / kansetsu waza)

public enum GrapplingWaza: String, KarateTerm {
    case tsukami, hikite, kuzushi, ashiBaraiNage, koshiNage, udeGarami
    case kubiNage, taniOtoshi, kansetsuWaza, hazushi

    public var kanji: String {
        switch self {
        case .tsukami: "掴み"; case .hikite: "引き手"; case .kuzushi: "崩し"
        case .ashiBaraiNage: "足払い投げ"; case .koshiNage: "腰投げ"; case .udeGarami: "腕絡み"
        case .kubiNage: "首投げ"; case .taniOtoshi: "谷落とし"; case .kansetsuWaza: "関節技"
        case .hazushi: "外し"
        }
    }

    public var english: String {
        switch self {
        case .tsukami: "grab"; case .hikite: "pulling hand"; case .kuzushi: "balance breaking"
        case .ashiBaraiNage: "sweeping throw"; case .koshiNage: "hip throw"
        case .udeGarami: "arm entanglement"; case .kubiNage: "neck throw"
        case .taniOtoshi: "valley drop throw"; case .kansetsuWaza: "joint technique"
        case .hazushi: "release from a grab"
        }
    }
}

// MARK: - Geometry of the embusen

/// Facing on the embusen, expressed relative to shomen (0° = front of the dojo).
public enum Facing: String, KarateTerm {
    case shomen, migi45, migi90, migi135, ushiro, hidari135, hidari90, hidari45

    public var degrees: Int {
        switch self {
        case .shomen: 0; case .migi45: 45; case .migi90: 90; case .migi135: 135
        case .ushiro: 180; case .hidari135: 225; case .hidari90: 270; case .hidari45: 315
        }
    }

    public init(degrees: Int) {
        let normalized = ((degrees % 360) + 360) % 360
        self = Facing.allCases.min {
            abs($0.degrees - normalized) < abs($1.degrees - normalized)
        } ?? .shomen
    }

    public var mirrored: Facing { Facing(degrees: 360 - degrees) }

    public var kanji: String {
        switch self {
        case .shomen: "正面"; case .ushiro: "後ろ"
        case .migi45, .migi90, .migi135: "右"
        case .hidari45, .hidari90, .hidari135: "左"
        }
    }

    public var english: String {
        switch self {
        case .shomen: "front (0°)"; case .migi45: "right 45°"; case .migi90: "right 90°"
        case .migi135: "right 135°"; case .ushiro: "rear 180°"; case .hidari135: "left 135°"
        case .hidari90: "left 90°"; case .hidari45: "left 45°"
        }
    }
}

/// How the practitioner travels into the next position (ashi-sabaki / unsoku).
public enum StepType: String, KarateTerm {
    case none, ayumiAshi, yoriAshi, tsugiAshi, okuriAshi, suriAshi
    case mawariAshi, kaiten, hikiAshi, fumikomi, kosaStep, tobi, tenshin

    public var kanji: String {
        switch self {
        case .none: "—"; case .ayumiAshi: "歩み足"; case .yoriAshi: "寄り足"
        case .tsugiAshi: "継ぎ足"; case .okuriAshi: "送り足"; case .suriAshi: "摺り足"
        case .mawariAshi: "回り足"; case .kaiten: "回転"; case .hikiAshi: "引き足"
        case .fumikomi: "踏み込み"; case .kosaStep: "交差歩"; case .tobi: "跳び"
        case .tenshin: "転身"
        }
    }

    public var english: String {
        switch self {
        case .none: "no displacement"; case .ayumiAshi: "natural stepping"
        case .yoriAshi: "sliding both feet"; case .tsugiAshi: "shuffle step"
        case .okuriAshi: "sending step"; case .suriAshi: "sliding foot"
        case .mawariAshi: "circular step"; case .kaiten: "turning on the spot"
        case .hikiAshi: "withdrawing step"; case .fumikomi: "stamping step-in"
        case .kosaStep: "crossing step"; case .tobi: "jump"; case .tenshin: "body shifting"
        }
    }
}

/// Rotation direction of a turn.
public enum Rotation: String, KarateTerm {
    case clockwise, counterClockwise, none

    public var kanji: String {
        switch self {
        case .clockwise: "右回り"; case .counterClockwise: "左回り"; case .none: "—"
        }
    }

    public var english: String {
        switch self {
        case .clockwise: "clockwise (to the right)"
        case .counterClockwise: "counter-clockwise (to the left)"
        case .none: "no rotation"
        }
    }

    public var mirrored: Rotation {
        switch self {
        case .clockwise: .counterClockwise
        case .counterClockwise: .clockwise
        case .none: .none
        }
    }
}

// MARK: - Expression: rhythm, breathing, tension

public enum Timing: String, KarateTerm {
    case normal, slow, fast, explosive, continuous, pause

    public var kanji: String {
        switch self {
        case .normal: "普通"; case .slow: "ゆっくり"; case .fast: "速い"
        case .explosive: "瞬発"; case .continuous: "連続"; case .pause: "間"
        }
    }

    public var english: String {
        switch self {
        case .normal: "normal speed"; case .slow: "slow (yukkuri)"; case .fast: "fast"
        case .explosive: "explosive"; case .continuous: "continuous (renzoku)"
        case .pause: "pause (ma)"
        }
    }

    /// Rough multiplier applied to the reference duration of a movement.
    public var durationFactor: Double {
        switch self {
        case .normal: 1.0; case .slow: 2.5; case .fast: 0.7
        case .explosive: 0.5; case .continuous: 0.6; case .pause: 1.8
        }
    }
}

public enum Breathing: String, KarateTerm {
    case natural, inhale, exhale, ibuki, nogare, kime

    public var kanji: String {
        switch self {
        case .natural: "自然呼吸"; case .inhale: "吸う"; case .exhale: "吐く"
        case .ibuki: "息吹"; case .nogare: "ノガレ"; case .kime: "決め"
        }
    }

    public var english: String {
        switch self {
        case .natural: "natural breathing"; case .inhale: "inhale"; case .exhale: "exhale"
        case .ibuki: "forceful audible breathing"; case .nogare: "silent controlled breathing"
        case .kime: "sharp exhalation with focus"
        }
    }
}

/// Muscular tension asked for during the movement.
public enum Tension: String, KarateTerm {
    case relaxed, moderate, maximum

    public var kanji: String {
        switch self {
        case .relaxed: "脱力"; case .moderate: "中"; case .maximum: "全力"
        }
    }

    public var english: String {
        switch self {
        case .relaxed: "relaxed"; case .moderate: "moderate tension"; case .maximum: "full tension"
        }
    }
}

// MARK: - Kata identity

/// The 26 kata of the standard Shotokan (JKA) syllabus, plus the Taikyoku set.
public enum ShotokanKata: String, KarateTerm {
    case taikyokuShodan, taikyokuNidan, taikyokuSandan
    case heianShodan, heianNidan, heianSandan, heianYondan, heianGodan
    case tekkiShodan, tekkiNidan, tekkiSandan
    case bassaiDai, bassaiSho, kankuDai, kankuSho
    case jion, jiin, jitte, empi, hangetsu, gankaku, chinte
    case sochin, nijushiho, meikyo, unsu, wankan, gojushihoDai, gojushihoSho

    public var kanji: String {
        switch self {
        case .taikyokuShodan: "太極初段"; case .taikyokuNidan: "太極二段"; case .taikyokuSandan: "太極三段"
        case .heianShodan: "平安初段"; case .heianNidan: "平安二段"; case .heianSandan: "平安三段"
        case .heianYondan: "平安四段"; case .heianGodan: "平安五段"
        case .tekkiShodan: "鉄騎初段"; case .tekkiNidan: "鉄騎二段"; case .tekkiSandan: "鉄騎三段"
        case .bassaiDai: "披塞大"; case .bassaiSho: "披塞小"; case .kankuDai: "観空大"
        case .kankuSho: "観空小"; case .jion: "慈恩"; case .jiin: "慈陰"; case .jitte: "十手"
        case .empi: "燕飛"; case .hangetsu: "半月"; case .gankaku: "岩鶴"; case .chinte: "珍手"
        case .sochin: "壮鎮"; case .nijushiho: "二十四歩"; case .meikyo: "明鏡"; case .unsu: "雲手"
        case .wankan: "王冠"; case .gojushihoDai: "五十四歩大"; case .gojushihoSho: "五十四歩小"
        }
    }

    /// Meaning of the name, commonly used in the dojo.
    public var english: String {
        switch self {
        case .taikyokuShodan, .taikyokuNidan, .taikyokuSandan: "first cause / great ultimate"
        case .heianShodan, .heianNidan, .heianSandan, .heianYondan, .heianGodan: "peaceful mind"
        case .tekkiShodan, .tekkiNidan, .tekkiSandan: "iron horse riding"
        case .bassaiDai: "to storm a fortress (major)"; case .bassaiSho: "to storm a fortress (minor)"
        case .kankuDai: "to view the sky (major)"; case .kankuSho: "to view the sky (minor)"
        case .jion: "temple sound / mercy"; case .jiin: "temple grounds"
        case .jitte: "ten hands"; case .empi: "flying swallow"; case .hangetsu: "half moon"
        case .gankaku: "crane on a rock"; case .chinte: "unusual hands"
        case .sochin: "preserve the peace / strength and calm"
        case .nijushiho: "twenty-four steps"; case .meikyo: "bright mirror"; case .unsu: "cloud hands"
        case .wankan: "king's crown"
        case .gojushihoDai: "fifty-four steps (major)"; case .gojushihoSho: "fifty-four steps (minor)"
        }
    }

    public var series: KataSeriesGroup {
        switch self {
        case .taikyokuShodan, .taikyokuNidan, .taikyokuSandan: .taikyoku
        case .heianShodan, .heianNidan, .heianSandan, .heianYondan, .heianGodan: .heian
        case .tekkiShodan, .tekkiNidan, .tekkiSandan: .tekki
        case .bassaiDai, .kankuDai, .jion, .empi, .hangetsu, .jitte: .sentei
        default: .tokui
        }
    }

    /// Official number of counted movements (JKA reference).
    public var officialMovementCount: Int {
        switch self {
        case .taikyokuShodan, .taikyokuNidan, .taikyokuSandan: 20
        case .heianShodan: 21; case .heianNidan: 26; case .heianSandan: 20
        case .heianYondan: 27; case .heianGodan: 23
        case .tekkiShodan: 29; case .tekkiNidan: 24; case .tekkiSandan: 36
        case .bassaiDai: 42; case .bassaiSho: 27; case .kankuDai: 65; case .kankuSho: 48
        case .jion: 47; case .jiin: 38; case .jitte: 24; case .empi: 37; case .hangetsu: 41
        case .gankaku: 42; case .chinte: 32; case .sochin: 41; case .nijushiho: 34
        case .meikyo: 33; case .unsu: 48; case .wankan: 24
        case .gojushihoDai: 67; case .gojushihoSho: 65
        }
    }

    /// Typical minimum grade at which the kata is taught in most Shotokan dojo.
    public var suggestedRank: Rank {
        switch self {
        case .taikyokuShodan, .taikyokuNidan, .taikyokuSandan: .kyu9
        case .heianShodan: .kyu8; case .heianNidan: .kyu7; case .heianSandan: .kyu6
        case .heianYondan: .kyu5; case .heianGodan: .kyu4
        case .tekkiShodan: .kyu3; case .bassaiDai: .kyu2; case .jion, .empi, .kankuDai: .kyu1
        case .hangetsu, .jitte, .tekkiNidan: .dan1
        case .bassaiSho, .kankuSho, .jiin, .gankaku, .tekkiSandan: .dan2
        case .sochin, .nijushiho, .meikyo, .chinte, .wankan: .dan3
        case .unsu, .gojushihoDai, .gojushihoSho: .dan4
        }
    }
}

/// Pedagogical grouping of the kata.
public enum KataSeriesGroup: String, KarateTerm {
    case taikyoku, heian, tekki, sentei, tokui, custom

    public var kanji: String {
        switch self {
        case .taikyoku: "太極"; case .heian: "平安"; case .tekki: "鉄騎"
        case .sentei: "指定"; case .tokui: "得意"; case .custom: "自作"
        }
    }

    public var english: String {
        switch self {
        case .taikyoku: "beginner forms"; case .heian: "basic forms (peaceful mind)"
        case .tekki: "horse-stance forms"; case .sentei: "required/selected kata"
        case .tokui: "free choice / advanced kata"; case .custom: "user-defined sequence"
        }
    }
}

/// Floor pattern of the kata.
public enum Embusen: String, KarateTerm {
    case straightLine, iShape, tShape, plusShape, hShape, yShape, complex

    public var kanji: String {
        switch self {
        case .straightLine: "一直線"; case .iShape: "I字"; case .tShape: "T字"
        case .plusShape: "十字"; case .hShape: "H字"; case .yShape: "Y字"; case .complex: "複雑"
        }
    }

    public var english: String {
        switch self {
        case .straightLine: "straight line"; case .iShape: "I shape"; case .tShape: "T shape"
        case .plusShape: "cross shape"; case .hShape: "H shape"; case .yShape: "Y shape"
        case .complex: "complex pattern"
        }
    }
}

/// Kyu and dan grades.
public enum Rank: String, KarateTerm, Comparable {
    case kyu9, kyu8, kyu7, kyu6, kyu5, kyu4, kyu3, kyu2, kyu1
    case dan1, dan2, dan3, dan4, dan5, dan6, dan7, dan8

    public var kanji: String { rawValue.hasPrefix("kyu") ? "級" : "段" }

    public var english: String {
        let number = String(rawValue.dropFirst(3))
        return rawValue.hasPrefix("kyu") ? "\(number)th kyu" : "\(number)th dan"
    }

    /// Belt colour commonly associated with the grade (varies between federations).
    public var beltColorName: String {
        switch self {
        case .kyu9, .kyu8: "white"; case .kyu7: "yellow"; case .kyu6: "orange"
        case .kyu5: "green"; case .kyu4, .kyu3: "blue"; case .kyu2, .kyu1: "brown"
        default: "black"
        }
    }

    private var ordering: Int {
        let number = Int(rawValue.dropFirst(3)) ?? 0
        return rawValue.hasPrefix("kyu") ? -number : number
    }

    public static func < (lhs: Rank, rhs: Rank) -> Bool { lhs.ordering < rhs.ordering }
}
