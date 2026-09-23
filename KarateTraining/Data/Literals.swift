//
//  Literals.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 24/09/2026.
//


import Foundation

// MARK: - Memberwise init for Exercise
//
// `Exercise` defines a custom `init(from:)` for Decodable conformance,
// which suppresses the compiler-synthesized memberwise initializer.
// This adds one back so `Exercise` values can be built as struct literals
// below. (`Step` needs no such extension — it has no custom initializer,
// so its memberwise init already exists.)
extension Exercise {
    init(
        id: String,
        type: ExerciseType,
        title: String? = nil,
        direction: Direction = .onSpot,
        repetitions: Int = 1,
        steps: [Step] = [],
        kata: KataID? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.direction = direction
        self.repetitions = repetitions
        self.steps = steps
        self.kata = kata
        self.notes = notes
    }
}

// MARK: - Training content (converted from training.json)
//
// Note: a few exercises in the source JSON (e.g. l4-01…l4-04) carry a
// top-level "stance" key alongside their steps. `Exercise`'s `init(from:)`
// never decodes that key, so it's dropped there too — omitted below to
// match actual decoded behavior.

let trainingContent = TrainingContent(
    version: 1,
    programs: [
        TrainingProgram(
            id: "level-1-main",
            title: "Level 1",
            summary: "Les techniques de base exécutées sur place : poing, blocages et coup de pied de face.",
            exercises: [
                Exercise(id: "l1-01", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .attack, technique: .chokuZuki)]),
                Exercise(id: "l1-02", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, technique: .jodanAgeUke)]),
                Exercise(id: "l1-03", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, technique: .sotoUdeUke)]),
                Exercise(id: "l1-04", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, technique: .uchiUdeUke)]),
                Exercise(id: "l1-05", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, technique: .shutoUke)]),
                Exercise(id: "l1-06", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .attack, technique: .maeGeri)])
            ]
        ),
        TrainingProgram(
            id: "level-2-main",
            title: "Level 2",
            summary: "Positions et techniques de base combinées à un déplacement.",
            exercises: [
                Exercise(id: "l2-01", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, technique: .zenkutsuDachi)]),
                Exercise(id: "l2-02", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, technique: .kokutsuDachi)]),
                Exercise(id: "l2-03", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, technique: .oiZuki, stance: .zenkutsuDachi)]),
                Exercise(id: "l2-04", type: .technique, direction: .onSpot, repetitions: 1,
                         steps: [Step(role: .attack, technique: .gyakuZuki, stance: .zenkutsuDachi)]),
                Exercise(id: "l2-05", type: .combo, direction: .onSpot, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .jodan, stance: .zenkutsuDachi),
                            Step(role: .attack, technique: .gyakuZuki, target: .chudan)
                         ]),
                Exercise(id: "l2-06", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, technique: .jodanAgeUke, stance: .zenkutsuDachi)]),
                Exercise(id: "l2-07", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, technique: .sotoUdeUke, stance: .zenkutsuDachi)]),
                Exercise(id: "l2-08", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, technique: .uchiUdeUke, stance: .zenkutsuDachi)]),
                Exercise(id: "l2-09", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, technique: .shutoUke, stance: .kokutsuDachi)]),
                Exercise(id: "l2-10", type: .technique, direction: .onSpot, repetitions: 1,
                         steps: [Step(role: .attack, technique: .maeGeri, stance: .zenkutsuDachi)])
            ]
        ),
        TrainingProgram(
            id: "level-3-main",
            title: "Level 3",
            summary: "Aller-retour, position du cavalier, premier kata et premiers ippon kumite.",
            exercises: [
                Exercise(id: "l3-01", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .zenkutsuDachi)]),
                Exercise(id: "l3-02", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .kokutsuDachi)]),
                Exercise(id: "l3-03", type: .combo, direction: .forwardAndBack, repetitions: 5,
                         steps: [
                            Step(role: .defense, technique: .gedanBarai, stance: .zenkutsuDachi),
                            Step(role: .attack, technique: .oiZuki, stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l3-04", type: .combo, direction: .forwardAndBack, repetitions: 5,
                         steps: [
                            Step(role: .defense, technique: .gedanBarai, stance: .zenkutsuDachi),
                            Step(role: .defense, technique: .jodanAgeUke, stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l3-05", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .defense, technique: .shutoUke, stance: .kokutsuDachi)]),
                Exercise(id: "l3-06", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .maeGeri, stance: .zenkutsuDachi)]),
                Exercise(id: "l3-07", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .kibaDachi)]),
                Exercise(id: "l3-08", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .yokoGeriKekomi, stance: .kibaDachi)]),
                Exercise(id: "l3-09", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, technique: .yokoGeriKeage, stance: .kibaDachi)]),
                Exercise(id: "l3-10", type: .kata, kata: .heianShodan),
                Exercise(id: "l3-11", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .jodan),
                            Step(role: .defense, technique: .jodanAgeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l3-12", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .chudan),
                            Step(role: .defense, technique: .sotoUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l3-13", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, technique: .maeGeri, target: .chudan),
                            Step(role: .defense, technique: .gedanBarai),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ])
            ]
        ),
        TrainingProgram(
            id: "level-4-main",
            title: "Level 4",
            summary: "Enchaînements blocage / contre-attaque, et katas Heian.",
            exercises: [
                Exercise(id: "l4-01", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .jodanAgeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l4-02", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .sotoUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l4-03", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .uchiUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l4-04", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .gedanBarai),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l4-05", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .shutoUke, stance: .kokutsuDachi),
                            Step(role: .counterAttack, technique: .nukite, stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l4-06", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .jodan),
                            Step(role: .attack, technique: .gyakuZuki),
                            Step(role: .attack, technique: .oiZuki, target: .chudan)
                         ]),
                Exercise(id: "l4-07", type: .kata, kata: .heianNidan),
                Exercise(id: "l4-08", type: .kata, kata: .heianSandan)
            ]
        ),
        TrainingProgram(
            id: "level-5-main",
            title: "Level 5",
            summary: "Coups de pied combinés, katas avancés et ippon kumite variés.",
            exercises: [
                Exercise(id: "l5-01", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, technique: .mawashiGeri, target: .jodan, stance: .zenkutsuDachi)]),
                Exercise(id: "l5-02", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, technique: .yokoGeriKekomi, target: .jodan, stance: .zenkutsuDachi)]),
                Exercise(id: "l5-03", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .maeGeri),
                            Step(role: .attack, technique: .oiZuki)
                         ]),
                Exercise(id: "l5-04", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .mawashiGeri, stance: .zenkutsuDachi),
                            Step(role: .attack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-05", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .yokoGeriKekomi, stance: .zenkutsuDachi),
                            Step(role: .attack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-06", type: .combo, direction: .onSpot, repetitions: 1,
                         steps: [
                            Step(role: .defense, technique: .sotoUdeUke, stance: .zenkutsuDachi),
                            Step(role: .counterAttack, technique: .yokoEmpiUchi, stance: .kibaDachi)
                         ]),
                Exercise(id: "l5-07", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .maeGeri, target: .chudan),
                            Step(role: .attack, technique: .maeGeri, target: .jodan, stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l5-08", type: .kata, kata: .heianYondan),
                Exercise(id: "l5-09", type: .kata, kata: .heianGodan),
                Exercise(id: "l5-10", type: .kata, kata: .tekkiShodan),
                Exercise(id: "l5-11", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .jodan),
                            Step(role: .defense, technique: .jodanAgeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-12", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .chudan),
                            Step(role: .defense, technique: .sotoUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-13", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .maeGeri, target: .chudan),
                            Step(role: .defense, technique: .gedanBarai),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-14", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .mawashiGeri, target: .chudan),
                            Step(role: .defense, technique: .sotoUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki)
                         ]),
                Exercise(id: "l5-15", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .maeGeri, target: .jodan),
                            Step(role: .defense, technique: .uchiUdeUke),
                            Step(role: .counterAttack, technique: .gyakuZuki, target: .jodan)
                         ]),
                Exercise(id: "l5-16", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .jodan),
                            Step(role: .defense, technique: .jodanAgeUke),
                            Step(role: .counterAttack, technique: .maeGeri, target: .chudan)
                         ]),
                Exercise(id: "l5-17", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .chudan),
                            Step(role: .defense, technique: .sotoUdeUke, stance: .zenkutsuDachi),
                            Step(role: .counterAttack, technique: .yokoEmpiUchi, stance: .kibaDachi)
                         ]),
                Exercise(id: "l5-18", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, technique: .oiZuki, target: .chudan),
                            Step(role: .defense, technique: .shutoUke, stance: .kokutsuDachi),
                            Step(role: .counterAttack, technique: .nukite, stance: .zenkutsuDachi)
                         ])
            ]
        )
    ]
)
