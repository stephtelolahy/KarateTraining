//
//  Technique+Matches.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 23/09/2026.
//
import Foundation

extension Technique {
    /// Recherche insensible à la casse, aux accents et aux tirets.
    func matches(_ query: String) -> Bool {
        let q = Self.normalize(query)
        guard !q.isEmpty else { return true }
        return [romaji, french].contains { Self.normalize($0).contains(q) }
    }

    private static func normalize(_ text: String) -> String {
        text.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
            .replacingOccurrences(of: "-", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
