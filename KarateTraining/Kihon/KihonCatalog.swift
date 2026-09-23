import Foundation

/// Base de données du kihon, définie en code Swift.
///
/// Le `switch` de `TechniqueID.definition` est exhaustif : ajouter un cas à
/// `TechniqueID` sans le décrire ici ne compile pas.
enum KihonCatalog {
    static let all: [Technique] = TechniqueID.allCases.map(\.definition)

    static func techniques(in category: TechniqueCategory) -> [Technique] {
        all.filter { $0.category == category }
    }
}

extension TechniqueID {
    var definition: Technique {
        switch self {

            // MARK: Tsuki
        case .chokuZuki:
            Technique(
                id: self,
                romaji: "Choku-zuki",
                english: "Straight Punch",
                french: "Coup de poing direct",
                category: .tsuki,
                description: "Coup de poing direct exécuté en ligne droite depuis la hanche, sur place. Le poing tourne pendant le trajet et la puissance est concentrée à l'impact (kime)."
            )
        case .oiZuki:
            Technique(
                id: self,
                romaji: "Oi-zuki",
                english: "Lunge Punch",
                french: "Coup de poing en avançant",
                category: .tsuki,
                description: "Coup de poing exécuté en avançant d'un pas : le bras du même côté que la jambe avant frappe. L'élan du déplacement s'ajoute à la puissance du coup. Peut viser le visage (jodan) ou le ventre (chudan)."
            )
        case .gyakuZuki:
            Technique(
                id: self,
                romaji: "Gyaku-zuki",
                english: "Reverse Punch",
                french: "Coup de poing inversé",
                category: .tsuki,
                description: "Coup de poing du bras opposé à la jambe avant, exécuté sur place. La rotation des hanches génère l'essentiel de la puissance pendant que l'autre poing revient à la hanche (hikite)."
            )

            // MARK: Uchi
        case .nukite:
            Technique(
                id: self,
                romaji: "Nukite",
                english: "Spear Hand Strike",
                french: "Frappe en pointe de doigts",
                category: .uchi,
                description: "Frappe avec le bout des doigts tendus et joints (main en lance), visant des zones sensibles comme le plexus solaire ou la gorge. Souvent enchaînée après un blocage."
            )
        case .yokoEmpiUchi:
            Technique(
                id: self,
                romaji: "Yoko-empi-uchi",
                english: "Side Elbow Strike",
                french: "Frappe de coude latérale",
                category: .uchi,
                description: "Frappe de coude vers le côté, utilisée à très courte distance, typiquement depuis kiba-dachi."
            )

            // MARK: Geri
        case .maeGeri:
            Technique(
                id: self,
                romaji: "Mae-geri",
                english: "Front Kick",
                french: "Coup de pied de face",
                category: .geri,
                description: "Le genou est levé puis la jambe est projetée vers l'avant ; la frappe se fait avec la plante des orteils relevés (koshi). Existe en version fouettée (keage) et pénétrante (kekomi)."
            )
        case .mawashiGeri:
            Technique(
                id: self,
                romaji: "Mawashi-geri",
                english: "Roundhouse Kick",
                french: "Coup de pied circulaire",
                category: .geri,
                description: "Coup de pied décrivant un arc, frappé avec le dessus du pied (haisoku) ou le koshi au niveau chudan ou jodan. La rotation des hanches et du pied d'appui donne la puissance."
            )
        case .yokoGeriKeikomi:
            Technique(
                id: self,
                romaji: "Yoko-geri-keikomi",
                english: "Side Thrust Kick",
                french: "Coup de pied latéral en poussée",
                category: .geri,
                description: "Coup de pied latéral pénétrant, frappé avec le tranchant du pied (sokuto), la hanche accompagnant la poussée. Souvent écrit « kekomi »."
            )
        case .yokoGeriKeage:
            Technique(
                id: self,
                romaji: "Yoko-geri-keage",
                english: "Side Snap Kick",
                french: "Coup de pied latéral fouetté",
                category: .geri,
                description: "Coup de pied latéral fouetté vers le haut, frappé avec le tranchant du pied (sokuto). L'impact est bref, la jambe revient aussitôt."
            )

            // MARK: Uke
        case .ageUke:
            Technique(
                id: self,
                romaji: "Age-uke",
                english: "Rising Block",
                french: "Blocage montant",
                category: .uke,
                description: "L'avant-bras monte devant le visage pour dévier une attaque jodan vers le haut. Il s'arrête au-dessus du front, à environ un poing de distance."
            )
        case .sotoUke:
            Technique(
                id: self,
                romaji: "Soto-uke",
                english: "Outside Forearm Block",
                french: "Blocage de l'extérieur vers l'intérieur",
                category: .uke,
                description: "Blocage de l'avant-bras exécuté de l'extérieur vers l'intérieur du corps, contre une attaque chudan."
            )
        case .uchiUke:
            Technique(
                id: self,
                romaji: "Uchi-uke",
                english: "Inside Forearm Block",
                french: "Blocage de l'intérieur vers l'extérieur",
                category: .uke,
                description: "Blocage de l'avant-bras exécuté de l'intérieur vers l'extérieur du corps, contre une attaque chudan. Le coude reste proche du corps au départ du mouvement."
            )
        case .shutoUke:
            Technique(
                id: self,
                romaji: "Shuto-uke",
                english: "Knife-hand Block",
                french: "Blocage en tranchant de la main",
                category: .uke,
                description: "Blocage main ouverte avec le tranchant de la main (shuto), typiquement exécuté en kokutsu-dachi. Une main bloque pendant que l'autre protège le plexus."
            )
        case .gedanBarai:
            Technique(
                id: self,
                romaji: "Gedan-barai",
                english: "Downward Block",
                french: "Balayage bas",
                category: .uke,
                description: "Le bras balaie l'attaque vers le bas et l'extérieur. Utilisé notamment contre un coup de pied de face (mae-geri) ou une attaque au niveau gedan."
            )

            // MARK: Dachi
        case .zenkutsuDachi:
            Technique(
                id: self,
                romaji: "Zenkutsu-dachi",
                english: "Front Stance",
                french: "Position avant",
                category: .dachi,
                description: "Position de base offensive : jambe avant fléchie, jambe arrière tendue, la majorité du poids sur l'avant. Buste droit, hanches stables."
            )
        case .kokutsuDachi:
            Technique(
                id: self,
                romaji: "Kokutsu-dachi",
                english: "Back Stance",
                french: "Position arrière",
                category: .dachi,
                description: "Position défensive : environ 70 % du poids sur la jambe arrière fléchie, jambe avant presque tendue, hanches et buste de demi-profil (hanmi)."
            )
        case .kibaDachi:
            Technique(
                id: self,
                romaji: "Kiba-dachi",
                english: "Horse Stance",
                french: "Position du cavalier",
                category: .dachi,
                description: "Pieds parallèles et largement écartés, genoux fléchis et poussés vers l'extérieur, poids réparti également, dos droit."
            )

            // MARK: Ido
        case .ayumiAshi:
            Technique(
                id: self,
                romaji: "Ayumi-ashi",
                english: "Walking Step",
                french: "Pas de marche",
                category: .ido,
                description: "Déplacement naturel en alternant les pieds, comme en marchant, en gardant les hanches stables d'une position à l'autre."
            )
        case .suriAshi:
            Technique(
                id: self,
                romaji: "Suri-ashi",
                english: "Sliding Step",
                french: "Pas glissé",
                category: .ido,
                description: "Le pied glisse au ras du sol sans se lever, ce qui garde les hanches à hauteur constante."
            )
        case .tsugiAshi:
            Technique(
                id: self,
                romaji: "Tsugi-ashi",
                english: "Following Step",
                french: "Pas suivi",
                category: .ido,
                description: "Le pied arrière rejoint le pied avant, puis le pied avant repart : permet de couvrir rapidement de la distance."
            )
        case .taiSabaki:
            Technique(
                id: self,
                romaji: "Tai-sabaki",
                english: "Body Shifting",
                french: "Esquive du corps",
                category: .ido,
                description: "Déplacement du corps hors de la ligne d'attaque, souvent avec un pivot. Utilisé en kumite pour esquiver avant de contre-attaquer."
            )
        }
    }
}
