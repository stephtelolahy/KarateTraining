//
//  Technique+Matches.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 23/09/2026.
//
import Foundation

extension String {
    /// Forme normalisée pour la recherche : sans casse, accents ni tirets.
    var searchNormalized: String {
        folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .replacingOccurrences(of: "-", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Vrai si le texte contient `query` (requête vide : toujours vrai).
    func matchesSearch(_ query: String) -> Bool {
        let q = query.searchNormalized
        return q.isEmpty || searchNormalized.contains(q)
    }
}

extension Technique {
    /// Recherche insensible à la casse, aux accents et aux tirets.
    func matches(_ query: String) -> Bool {
        [romaji, french].contains { $0.matchesSearch(query) }
    }
}

extension Exercise {
    /// Recherche sur le titre affiché (même normalisation que les techniques).
    func matches(_ query: String) -> Bool {
        displayTitle.matchesSearch(query)
    }
}
