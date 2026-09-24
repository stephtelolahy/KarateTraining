//
//  KataModel.swift
//  KataKit — Shotokan kata modelisation
//
//  Aggregate: KataSeries -> Kata -> Movement -> Technique
//

import Foundation

// MARK: - Technique

/// A technique family. Associated values keep the specific enum strongly typed
/// while allowing one heterogeneous list per movement.
public enum TechniqueKind: Codable, Hashable {
    case block(Uke)
    case punch(Tsuki)
    case strike(Uchi)
    case elbow(Empi)
    case kick(Keri)
    case grappling(GrapplingWaza)
    case posture(Kamae)
    /// Escape hatch for regional variants or kata created by the user.
    case other(name: String, translation: String)

    public var romaji: String {
        switch self {
        case .block(let v): v.romaji
        case .punch(let v): v.romaji
        case .strike(let v): v.romaji
        case .elbow(let v): v.romaji
        case .kick(let v): v.romaji
        case .grappling(let v): v.romaji
        case .posture(let v): v.romaji
        case .other(let name, _): name
        }
    }

    public var english: String {
        switch self {
        case .block(let v): v.english
        case .punch(let v): v.english
        case .strike(let v): v.english
        case .elbow(let v): v.english
        case .kick(let v): v.english
        case .grappling(let v): v.english
        case .posture(let v): v.english
        case .other(_, let translation): translation
        }
    }

    public var category: TechniqueCategory {
        switch self {
        case .block: .uke
        case .punch: .tsuki
        case .strike: .uchi
        case .elbow: .uchi
        case .kick: .keri
        case .grappling: .nage
        case .posture: .kamae
        case .other: .other
        }
    }

    /// Height usually associated with the technique, used as a default when editing.
    public var defaultLevel: Level? {
        switch self {
        case .block(let v): v.defaultLevel
        case .punch, .strike, .elbow, .kick: .chudan
        case .grappling, .posture, .other: nil
        }
    }

    public var defaultWeapon: BodyWeapon? {
        switch self {
        case .kick(let v): v.defaultWeapon
        case .punch: .seiken
        case .elbow: .empi
        default: nil
        }
    }
}

public enum TechniqueCategory: String, Codable, CaseIterable, Identifiable {
    case uke, tsuki, uchi, keri, nage, kamae, other
    public var id: String { rawValue }

    public var english: String {
        switch self {
        case .uke: "block"; case .tsuki: "punch"; case .uchi: "strike"
        case .keri: "kick"; case .nage: "throw / grappling"; case .kamae: "guard position"
        case .other: "other"
        }
    }
}

/// A single technique performed within a movement.
public struct Technique: Identifiable, Codable, Hashable {
    public var id: UUID
    public var kind: TechniqueKind
    public var side: Side
    public var level: Level?
    /// Contact surface; defaults to the one implied by `kind`.
    public var weapon: BodyWeapon?
    /// Hand kept at the hip (or elsewhere) during the technique.
    public var hikiteSide: Side?
    /// True when the technique is executed at the same time as the previous one
    /// in the movement (e.g. block + punch together).
    public var isSimultaneous: Bool
    public var tension: Tension
    public var notes: String?

    public init(
        id: UUID = UUID(),
        kind: TechniqueKind,
        side: Side = .unspecified,
        level: Level? = nil,
        weapon: BodyWeapon? = nil,
        hikiteSide: Side? = nil,
        isSimultaneous: Bool = false,
        tension: Tension = .moderate,
        notes: String? = nil
    ) {
        self.id = id
        self.kind = kind
        self.side = side
        self.level = level ?? kind.defaultLevel
        self.weapon = weapon ?? kind.defaultWeapon
        self.hikiteSide = hikiteSide ?? side.mirrored
        self.isSimultaneous = isSimultaneous
        self.tension = tension
        self.notes = notes
    }

    /// e.g. "hidari gedan-barai (chudan)".
    public var label: String {
        var parts: [String] = []
        if side != .unspecified { parts.append(side.romaji) }
        if let level, kind.category != .kamae { parts.append(level.romaji) }
        parts.append(kind.romaji)
        return parts.joined(separator: " ")
    }

    public var mirrored: Technique {
        var copy = self
        copy.side = side.mirrored
        copy.hikiteSide = hikiteSide?.mirrored
        return copy
    }

    // Convenience builders ------------------------------------------------

    public static func block(_ uke: Uke, _ side: Side, _ level: Level? = nil) -> Technique {
        Technique(kind: .block(uke), side: side, level: level)
    }

    public static func punch(_ tsuki: Tsuki, _ side: Side, _ level: Level = .chudan) -> Technique {
        Technique(kind: .punch(tsuki), side: side, level: level)
    }

    public static func strike(_ uchi: Uchi, _ side: Side, _ level: Level = .jodan) -> Technique {
        Technique(kind: .strike(uchi), side: side, level: level)
    }

    public static func kick(_ keri: Keri, _ side: Side, _ level: Level = .chudan) -> Technique {
        Technique(kind: .kick(keri), side: side, level: level)
    }

    public static func kamae(_ kamae: Kamae, _ side: Side = .unspecified) -> Technique {
        Technique(kind: .posture(kamae), side: side)
    }
}

// MARK: - Transition

/// How the body travels from the previous position to this one.
public struct Transition: Codable, Hashable {
    public var step: StepType
    public var rotation: Rotation
    /// Amount of rotation in degrees (0, 45, 90, 135, 180, 270...).
    public var rotationDegrees: Int
    /// Foot used as the pivot, when relevant.
    public var pivotFoot: Side?
    /// Leg that moves.
    public var movingLeg: Side?

    public init(
        step: StepType = .none,
        rotation: Rotation = .none,
        rotationDegrees: Int = 0,
        pivotFoot: Side? = nil,
        movingLeg: Side? = nil
    ) {
        self.step = step
        self.rotation = rotation
        self.rotationDegrees = rotationDegrees
        self.pivotFoot = pivotFoot
        self.movingLeg = movingLeg
    }

    public static let stationary = Transition()

    public var mirrored: Transition {
        var copy = self
        copy.rotation = rotation.mirrored
        copy.pivotFoot = pivotFoot?.mirrored
        copy.movingLeg = movingLeg?.mirrored
        return copy
    }

    public var summary: String {
        var parts: [String] = []
        if rotationDegrees != 0 { parts.append("\(rotation.english) \(rotationDegrees)°") }
        if step != .none { parts.append(step.romaji) }
        return parts.isEmpty ? "on the spot" : parts.joined(separator: ", ")
    }
}

// MARK: - Movement

/// One counted movement of a kata (one "temps" / one count from the sensei).
public struct Movement: Identifiable, Codable, Hashable {
    public var id: UUID
    /// 1-based count within the kata; kept in sync by `Kata.renumber()`.
    public var number: Int
    /// Optional label when the count is not a plain number ("5a", "yoi", "naore").
    public var countLabel: String?

    public var stance: Dachi
    /// Direction the body faces on the embusen after the movement.
    public var facing: Facing
    public var transition: Transition
    /// Ordered list; `Technique.isSimultaneous` marks the ones done together.
    public var techniques: [Technique]

    public var timing: Timing
    public var breathing: Breathing
    public var hasKiai: Bool
    /// Where the eyes look (chakugan); usually equal to `facing`.
    public var gaze: Facing?

    public var teachingPoints: [String]
    public var bunkai: [String]
    public var commonMistakes: [String]
    /// Reference to a local or remote media asset (video, picture).
    public var mediaReferences: [URL]
    public var notes: String?

    public init(
        id: UUID = UUID(),
        number: Int = 0,
        countLabel: String? = nil,
        stance: Dachi,
        facing: Facing = .shomen,
        transition: Transition = .stationary,
        techniques: [Technique] = [],
        timing: Timing = .normal,
        breathing: Breathing = .kime,
        hasKiai: Bool = false,
        gaze: Facing? = nil,
        teachingPoints: [String] = [],
        bunkai: [String] = [],
        commonMistakes: [String] = [],
        mediaReferences: [URL] = [],
        notes: String? = nil
    ) {
        self.id = id
        self.number = number
        self.countLabel = countLabel
        self.stance = stance
        self.facing = facing
        self.transition = transition
        self.techniques = techniques
        self.timing = timing
        self.breathing = breathing
        self.hasKiai = hasKiai
        self.gaze = gaze ?? facing
        self.teachingPoints = teachingPoints
        self.bunkai = bunkai
        self.commonMistakes = commonMistakes
        self.mediaReferences = mediaReferences
        self.notes = notes
    }

    public var displayCount: String { countLabel ?? "\(number)" }

    /// e.g. "3 — hidari gedan-barai, zenkutsu-dachi (rear 180°)".
    public var summary: String {
        let techs = techniques.map(\.label).joined(separator: " + ")
        return "\(displayCount) — \(techs.isEmpty ? "—" : techs), \(stance.romaji) [\(facing.english)]"
            + (hasKiai ? " KIAI" : "")
    }

    public var categories: Set<TechniqueCategory> {
        Set(techniques.map { $0.kind.category })
    }

    /// Reference duration in seconds, used to estimate the length of the kata.
    public var estimatedDuration: TimeInterval { 1.2 * timing.durationFactor }

    public var mirrored: Movement {
        var copy = self
        copy.id = UUID()
        copy.facing = facing.mirrored
        copy.gaze = gaze?.mirrored
        copy.transition = transition.mirrored
        copy.techniques = techniques.map(\.mirrored)
        return copy
    }
}

// MARK: - Kata

public struct Kata: Identifiable, Codable, Hashable {
    public var id: UUID
    /// Free-form name; a user-created kata has no `standard` value.
    public var name: String
    public var standard: ShotokanKata?
    public var kanji: String?
    public var meaning: String?
    public var group: KataSeriesGroup
    public var embusen: Embusen
    public var requiredRank: Rank?
    /// Official count when the kata is a standard one; `nil` for custom sequences.
    public var officialMovementCount: Int?
    public var movements: [Movement]

    public var author: String?
    public var tags: [String]
    public var createdAt: Date
    public var updatedAt: Date
    /// Bumped on every saved edit, useful for sync and history.
    public var revision: Int

    public init(
        id: UUID = UUID(),
        name: String,
        standard: ShotokanKata? = nil,
        kanji: String? = nil,
        meaning: String? = nil,
        group: KataSeriesGroup = .custom,
        embusen: Embusen = .complex,
        requiredRank: Rank? = nil,
        officialMovementCount: Int? = nil,
        movements: [Movement] = [],
        author: String? = nil,
        tags: [String] = [],
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        revision: Int = 1
    ) {
        self.id = id
        self.name = name
        self.standard = standard
        self.kanji = kanji ?? standard?.kanji
        self.meaning = meaning ?? standard?.english
        self.group = standard?.series ?? group
        self.embusen = embusen
        self.requiredRank = requiredRank ?? standard?.suggestedRank
        self.officialMovementCount = officialMovementCount ?? standard?.officialMovementCount
        self.movements = movements
        self.author = author
        self.tags = tags
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.revision = revision
    }

    /// Build a kata pre-filled from the standard syllabus.
    public init(standard: ShotokanKata, movements: [Movement] = []) {
        self.init(
            name: standard.romaji,
            standard: standard,
            embusen: Kata.defaultEmbusen(for: standard),
            movements: movements
        )
    }

    // Derived data --------------------------------------------------------

    public var movementCount: Int { movements.count }

    public var kiaiPoints: [Int] { movements.filter(\.hasKiai).map(\.number) }

    public var estimatedDuration: TimeInterval {
        movements.reduce(0) { $0 + $1.estimatedDuration }
    }

    public var stancesUsed: Set<Dachi> { Set(movements.map(\.stance)) }

    /// How many times each technique appears — feeds statistics screens.
    public var techniqueHistogram: [String: Int] {
        movements
            .flatMap(\.techniques)
            .reduce(into: [:]) { counts, technique in
                counts[technique.kind.romaji, default: 0] += 1
            }
    }

    public func movement(numbered number: Int) -> Movement? {
        movements.first { $0.number == number }
    }

    public static func defaultEmbusen(for kata: ShotokanKata) -> Embusen {
        switch kata {
        case .tekkiShodan, .tekkiNidan, .tekkiSandan: .straightLine
        case .taikyokuShodan, .taikyokuNidan, .taikyokuSandan,
             .heianShodan, .heianNidan, .heianSandan, .heianYondan, .heianGodan: .iShape
        case .jion, .jiin, .jitte: .iShape
        case .kankuDai, .kankuSho, .unsu, .gojushihoDai, .gojushihoSho: .complex
        default: .complex
        }
    }
}

// MARK: - Series

/// An ordered set of kata: either an official group (Heian, Tekki…) or a
/// training programme built by the user.
public struct KataSeries: Identifiable, Codable, Hashable {
    public var id: UUID
    public var title: String
    public var subtitle: String?
    public var group: KataSeriesGroup
    public var kata: [Kata]
    public var targetRank: Rank?
    public var isEditable: Bool
    public var createdAt: Date
    public var updatedAt: Date

    public init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        group: KataSeriesGroup = .custom,
        kata: [Kata] = [],
        targetRank: Rank? = nil,
        isEditable: Bool = true,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.group = group
        self.kata = kata
        self.targetRank = targetRank
        self.isEditable = isEditable
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public var totalMovements: Int { kata.reduce(0) { $0 + $1.movementCount } }
    public var estimatedDuration: TimeInterval { kata.reduce(0) { $0 + $1.estimatedDuration } }
}

// MARK: - Practice tracking (optional but usually needed by such an app)

public struct PracticeSession: Identifiable, Codable, Hashable {
    public var id: UUID
    public var kataID: UUID
    public var date: Date
    public var repetitions: Int
    public var selfRating: Int?          // 1...5
    public var instructorFeedback: String?
    /// Movement numbers the practitioner wants to work on.
    public var focusMovements: [Int]

    public init(
        id: UUID = UUID(),
        kataID: UUID,
        date: Date = Date(),
        repetitions: Int = 1,
        selfRating: Int? = nil,
        instructorFeedback: String? = nil,
        focusMovements: [Int] = []
    ) {
        self.id = id
        self.kataID = kataID
        self.date = date
        self.repetitions = repetitions
        self.selfRating = selfRating
        self.instructorFeedback = instructorFeedback
        self.focusMovements = focusMovements
    }
}
