let trainingContent = TrainingContent(
    version: 1,
    programs: [
        TrainingProgram(
            id: "level-1-main",
            title: "Level 1",
            summary: "Les techniques de base exécutées sur place : poing, blocages et coup de pied de face.",
            exercises: [
                Exercise(id: "l1-01", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .attack, techniques: [.chokuZuki])]),
                Exercise(id: "l1-02", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, techniques: [.jodanAgeUke])]),
                Exercise(id: "l1-03", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, techniques: [.sotoUdeUke])]),
                Exercise(id: "l1-04", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, techniques: [.uchiUdeUke])]),
                Exercise(id: "l1-05", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .defense, techniques: [.shutoUke])]),
                Exercise(id: "l1-06", type: .technique, direction: .onSpot, repetitions: 10,
                         steps: [Step(role: .attack, techniques: [.maeGeri])])
            ]
        ),
        TrainingProgram(
            id: "level-2-main",
            title: "Level 2",
            summary: "Positions et techniques de base combinées à un déplacement.",
            exercises: [
                Exercise(id: "l2-01", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.zenkutsuDachi])]),
                Exercise(id: "l2-02", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.kokutsuDachi])]),
                Exercise(id: "l2-03", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.oiZuki], stance: .zenkutsuDachi)]),
                Exercise(id: "l2-04", type: .technique, direction: .onSpot, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.gyakuZuki], stance: .zenkutsuDachi)]),
                Exercise(id: "l2-05", type: .combo, direction: .onSpot, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .jodan, stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.gyakuZuki], target: .chudan)
                         ]),
                Exercise(id: "l2-06", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, techniques: [.jodanAgeUke], stance: .zenkutsuDachi)]),
                Exercise(id: "l2-07", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, techniques: [.sotoUdeUke], stance: .zenkutsuDachi)]),
                Exercise(id: "l2-08", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, techniques: [.uchiUdeUke], stance: .zenkutsuDachi)]),
                Exercise(id: "l2-09", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .defense, techniques: [.shutoUke], stance: .kokutsuDachi)]),
                Exercise(id: "l2-10", type: .technique, direction: .onSpot, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.maeGeri], stance: .zenkutsuDachi)])
            ]
        ),
        TrainingProgram(
            id: "level-3-main",
            title: "Level 3",
            summary: "Aller-retour, position du cavalier, premier kata et premiers ippon kumite.",
            exercises: [
                Exercise(id: "l3-01", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.zenkutsuDachi])]),
                Exercise(id: "l3-02", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.kokutsuDachi])]),
                Exercise(id: "l3-03", type: .combo, direction: .forwardAndBack, repetitions: 5,
                         steps: [
                            Step(role: .defense, techniques: [.gedanBarai], stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.oiZuki], stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l3-04", type: .combo, direction: .forwardAndBack, repetitions: 5,
                         steps: [
                            Step(role: .defense, techniques: [.gedanBarai], stance: .zenkutsuDachi),
                            Step(role: .defense, techniques: [.jodanAgeUke], stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l3-05", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .defense, techniques: [.shutoUke], stance: .kokutsuDachi)]),
                Exercise(id: "l3-06", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.maeGeri], stance: .zenkutsuDachi)]),
                Exercise(id: "l3-07", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.kibaDachi])]),
                Exercise(id: "l3-08", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.yokoGeriKekomi], stance: .kibaDachi)]),
                Exercise(id: "l3-09", type: .technique, direction: .forwardAndBack, repetitions: 5,
                         steps: [Step(role: .attack, techniques: [.yokoGeriKeage], stance: .kibaDachi)]),
                Exercise.heianShodan,
                Exercise(id: "l3-11", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .jodan),
                            Step(role: .defense, techniques: [.jodanAgeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l3-12", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .chudan),
                            Step(role: .defense, techniques: [.sotoUdeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l3-13", type: .kumite, direction: .forward, repetitions: 5,
                         steps: [
                            Step(role: .attack, techniques: [.maeGeri], target: .chudan),
                            Step(role: .defense, techniques: [.gedanBarai]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
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
                            Step(role: .defense, techniques: [.jodanAgeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l4-02", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, techniques: [.sotoUdeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l4-03", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, techniques: [.uchiUdeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l4-04", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, techniques: [.gedanBarai], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l4-05", type: .combo, direction: .forwardAndBack, repetitions: 1,
                         steps: [
                            Step(role: .defense, techniques: [.shutoUke], stance: .kokutsuDachi),
                            Step(role: .counterAttack, techniques: [.nukite], stance: .zenkutsuDachi)
                         ]),
                Exercise(id: "l4-06", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .jodan, stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.gyakuZuki]),
                            Step(role: .attack, techniques: [.oiZuki], target: .chudan)
                         ]),
                Exercise.heianNidan,
                Exercise.heianSandan,
            ]
        ),
        TrainingProgram(
            id: "level-5-main",
            title: "Level 5",
            summary: "Coups de pied combinés, katas avancés et ippon kumite variés.",
            exercises: [
                Exercise(id: "l5-01", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.mawashiGeri], target: .jodan, stance: .zenkutsuDachi)]),
                Exercise(id: "l5-02", type: .technique, direction: .forward, repetitions: 1,
                         steps: [Step(role: .attack, techniques: [.yokoGeriKekomi], target: .jodan, stance: .zenkutsuDachi)]),
                Exercise(id: "l5-03", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.maeGeri], stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.oiZuki])
                         ]),
                Exercise(id: "l5-04", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.mawashiGeri], stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-05", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.yokoGeriKekomi], stance: .zenkutsuDachi),
                            Step(role: .attack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-06", type: .combo, direction: .onSpot, repetitions: 1,
                         steps: [
                            Step(role: .defense, techniques: [.sotoUdeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.yokoEmpiUchi], stance: .kibaDachi)
                         ]),
                Exercise(id: "l5-07", type: .combo, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.maeGeri], target: .chudan),
                            Step(role: .attack, techniques: [.maeGeri], target: .jodan, stance: .zenkutsuDachi)
                         ]),
                Exercise.heianYondan,
                Exercise.heianGodan,
                Exercise.tekkiShodan,
                Exercise(id: "l5-11", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .jodan),
                            Step(role: .defense, techniques: [.jodanAgeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-12", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .chudan),
                            Step(role: .defense, techniques: [.sotoUdeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-13", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.maeGeri], target: .chudan),
                            Step(role: .defense, techniques: [.gedanBarai]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-14", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.mawashiGeri], target: .chudan),
                            Step(role: .defense, techniques: [.sotoUdeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki])
                         ]),
                Exercise(id: "l5-15", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.maeGeri], target: .jodan),
                            Step(role: .defense, techniques: [.uchiUdeUke]),
                            Step(role: .counterAttack, techniques: [.gyakuZuki], target: .jodan)
                         ]),
                Exercise(id: "l5-16", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .jodan),
                            Step(role: .defense, techniques: [.jodanAgeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.maeGeri], target: .chudan)
                         ]),
                Exercise(id: "l5-17", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .chudan),
                            Step(role: .defense, techniques: [.sotoUdeUke], stance: .zenkutsuDachi),
                            Step(role: .counterAttack, techniques: [.yokoEmpiUchi], stance: .kibaDachi)
                         ]),
                Exercise(id: "l5-18", type: .kumite, direction: .forward, repetitions: 1,
                         steps: [
                            Step(role: .attack, techniques: [.oiZuki], target: .chudan),
                            Step(role: .defense, techniques: [.shutoUke], stance: .kokutsuDachi),
                            Step(role: .counterAttack, techniques: [.nukite], stance: .zenkutsuDachi)
                         ])
            ]
        )
    ]
)

// MARK: - Kata

private extension Exercise {

    // MARK: - Heian Shodan

    static var heianShodan: Self {
        .init(
            id: "heianShodan",
            type: .kata,
            title: "Heian Shodan",
            direction: .forwardAndBack,
            repetitions: 1,
            notes: "Paix et tranquillité — 1er niveau. 21 mouvements, kiai aux mouvements 9 et 17.",
            steps: [
                // 1–5
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.tettsuiUchi], target: .chudan, stance: .renojiDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),

                // 6–9
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.jodanAgeUke], target: .jodan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.jodanAgeUke], target: .jodan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.jodanAgeUke], target: .jodan, stance: .zenkutsuDachi),

                // 10–14
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),

                // 15–17
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.oiZuki], target: .chudan, stance: .zenkutsuDachi),

                // 18–21
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi)
            ]
        )
    }

    // MARK: - Heian Nidan

    static var heianNidan: Self {
        .init(
            id: "heianNidan",
            type: .kata,
            title: "Heian Nidan",
            direction: .forwardAndBack,
            repetitions: 1,
            notes: "Paix et tranquillité — 2e niveau. 26 mouvements, kiai aux mouvements 11 et 26.",
            steps: [
                // 1–3
                Step(role: .defense, techniques: [.haiwanUke], target: .jodan, stance: .kokutsuDachi),
                Step(role: .attack, techniques: [.uraZuki, .nagashiUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .attack, techniques: [.yokoZuki], target: .chudan, stance: .kokutsuDachi),

                // 4–6
                Step(role: .defense, techniques: [.haiwanUke], target: .jodan, stance: .kokutsuDachi),
                Step(role: .attack, techniques: [.uraZuki, .nagashiUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .attack, techniques: [.yokoZuki], target: .chudan, stance: .kokutsuDachi),

                // 7
                Step(role: .attack, techniques: [.yokoGeriKeage, .urakenUchi], target: .jodan, stance: .kokutsuDachi),

                // 8–11 (kiai au mouvement 11)
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .attack, techniques: [.nukite, .osaeUke], target: .chudan, stance: .zenkutsuDachi),

                // 12–15
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),
                Step(role: .defense, techniques: [.shutoUke], target: .chudan, stance: .kokutsuDachi),

                // 16–18
                Step(role: .defense, techniques: [.uchiUdeUke], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.maeGeri], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .counterAttack, techniques: [.gyakuZuki], target: .chudan, stance: .zenkutsuDachi),

                // 19–21
                Step(role: .defense, techniques: [.uchiUdeUke], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .attack, techniques: [.maeGeri], target: .chudan, stance: .zenkutsuDachi),
                Step(role: .counterAttack, techniques: [.gyakuZuki], target: .chudan, stance: .zenkutsuDachi),

                // 22
                Step(role: .defense, techniques: [.moroteUchiUke], target: .chudan, stance: .zenkutsuDachi),

                // 23–26 (kiai au mouvement 26)
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.shutoAgeUke, .jodanAgeUke], target: .jodan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.gedanBarai], target: .gedan, stance: .zenkutsuDachi),
                Step(role: .defense, techniques: [.shutoAgeUke, .jodanAgeUke], target: .jodan, stance: .zenkutsuDachi)
            ]
        )
    }

    // MARK: - Heian Sandan

    static var heianSandan: Self {
        .init(
            id: "heianSandan",
            type: .kata,
            title: "Heian Sandan",
            notes: "Paix et tranquillité — 3e niveau",
        )
    }

    // MARK: - Heian Yondan

    static var heianYondan: Self {
        .init(
            id: "heianYondan",
            type: .kata,
            title: "Heian Yondan",
            notes: "Paix et tranquillité — 4e niveau",
        )
    }

    // MARK: - Heian Godan

    static var heianGodan: Self {
        .init(
            id: "heianGodan",
            type: .kata,
            title: "Heian Godan",
            notes: "Paix et tranquillité — 5e niveau",
        )
    }

    // MARK: - Tekki Shodan

    static var tekkiShodan: Self {
        .init(
            id: "tekkiShodan",
            type: .kata,
            title: "Tekki Shodan",
            notes: "Cavalier de fer — 1er niveau",
        )
    }
}
