//
//  KataSamples.swift
//  KataKit — sample data showing how the model is filled in
//

import Foundation

public enum KataSamples {

    /// First nine movements of Heian Shodan (the rest follows the same pattern).
    public static var heianShodan: Kata {
        var kata = Kata(standard: .heianShodan)

        kata.append(Movement(
            countLabel: "yoi",
            stance: .hachiji,
            facing: .shomen,
            techniques: [.kamae(.yoi)],
            timing: .slow,
            breathing: .natural,
            teachingPoints: ["Fists at groin width", "Shoulders relaxed, eyes to the front"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .hidari90,
            transition: .init(step: .ayumiAshi, rotation: .counterClockwise,
                              rotationDegrees: 90, pivotFoot: .migi, movingLeg: .hidari),
            techniques: [.block(.gedanBarai, .hidari, .gedan)],
            teachingPoints: ["Turn the head before the body", "Hip in shomen at the end"],
            bunkai: ["Deflect a mae-geri coming from the left side"],
            commonMistakes: ["Blocking arm too far from the thigh"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .hidari90,
            transition: .init(step: .ayumiAshi, movingLeg: .migi),
            techniques: [.punch(.oiZuki, .migi, .chudan)],
            teachingPoints: ["Punch and stance arrive together (kime)"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .migi90,
            transition: .init(step: .mawariAshi, rotation: .clockwise,
                              rotationDegrees: 180, pivotFoot: .hidari, movingLeg: .migi),
            techniques: [.block(.gedanBarai, .migi, .gedan)],
            teachingPoints: ["Keep the hips low during the 180° turn"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .migi90,
            transition: .init(step: .hikiAshi, movingLeg: .hidari),
            techniques: [.strike(.tettsuiUchi, .migi, .gedan)],
            teachingPoints: ["Pull the rear foot in, then strike downwards"],
            bunkai: ["Break the grip of an opponent seizing the wrist"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .migi90,
            transition: .init(step: .ayumiAshi, movingLeg: .hidari),
            techniques: [.punch(.oiZuki, .hidari, .chudan)]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .shomen,
            transition: .init(step: .mawariAshi, rotation: .counterClockwise,
                              rotationDegrees: 90, pivotFoot: .migi, movingLeg: .hidari),
            techniques: [.block(.gedanBarai, .hidari, .gedan)],
            teachingPoints: ["Back on the main axis of the embusen"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .shomen,
            transition: .init(step: .ayumiAshi, movingLeg: .migi),
            techniques: [.block(.ageUke, .migi, .jodan)],
            teachingPoints: ["Forearm one fist above the forehead"]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .shomen,
            transition: .init(step: .ayumiAshi, movingLeg: .hidari),
            techniques: [.block(.ageUke, .hidari, .jodan)]
        ))

        kata.append(Movement(
            stance: .zenkutsu,
            facing: .shomen,
            transition: .init(step: .ayumiAshi, movingLeg: .migi),
            techniques: [.block(.ageUke, .migi, .jodan)],
            timing: .explosive,
            breathing: .kime,
            hasKiai: true,
            teachingPoints: ["First kiai of the kata"]
        ))

        return kata
    }

    /// The five Heian kata as an official, non-editable series (movements omitted).
    public static var heianSeries: KataSeries {
        KataSeries(
            title: "Heian",
            subtitle: "Five basic kata of the Shotokan syllabus",
            group: .heian,
            kata: [heianShodan]
                + [.heianNidan, .heianSandan, .heianYondan, .heianGodan].map { Kata(standard: $0) },
            targetRank: .kyu4,
            isEditable: false
        )
    }

    /// A user-defined series, e.g. a personal preparation programme.
    public static func gradingProgramme(for rank: Rank) -> KataSeries {
        let selection = ShotokanKata.allCases.filter { $0.suggestedRank <= rank }
        return KataSeries(
            title: "Preparation \(rank.english)",
            subtitle: "Kata to master for the next grading",
            group: .custom,
            kata: selection.map { Kata(standard: $0) },
            targetRank: rank
        )
    }
}

// MARK: - Usage example

public enum KataKitDemo {
    public static func run() {
        var kata = KataSamples.heianShodan

        // Edit: insert a movement, then renumber automatically.
        kata.insert(
            Movement(
                stance: .kokutsu,
                facing: .shomen,
                techniques: [.block(.shutoUke, .hidari, .chudan)]
            ),
            at: 5
        )

        // Validate before saving.
        for issue in KataValidator.validate(kata) {
            print("[\(issue.severity.rawValue)] \(issue.message)")
        }

        // Export.
        print(kata.markdownSheet())

        // Persist a whole series.
        let series = KataSeries(title: "My dojo", kata: [kata])
        if let data = try? KataStore.data(from: series) {
            print("Encoded \(data.count) bytes of JSON")
        }
    }
}
