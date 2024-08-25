//
//  String+Pluralize.swift
//
//
//  Created by Artem Mayer on 05.08.2024.
//

import Foundation

extension String {

    func pluralize() -> String {
        // We check the ending of the word and add the appropriate ending
        if self.hasSuffix("y") {
            // If a word ends in "y" and there is a consonant before it, then change "y" to "ies"
            if let lastChar = self.dropLast().last, !isVowel(lastChar) {

                return "\(String(self.dropLast()))ies"
            }
            // If a word ends in "y" and there is a vowel before it, just add "s"
            return "\(self)s"

        } else if self.isWordForEsPlural {
            // If the word ends with "s", "x", "z", "ch", "sh", add "es"
            return "\(self)es"
        } else {
            // For other cases, just add "s"
            return "\(self)s"
        }
    }

    // Helper function to check if a character is a vowel
    private func isVowel(_ character: Character) -> Bool {
        switch character {
        case "a", "e", "i", "o", "u": return true
        default: return false
        }
    }

    private var isWordForEsPlural: Bool {
        self.hasSuffix("s") ||
            self.hasSuffix("x") ||
            self.hasSuffix("z") ||
            self.hasSuffix("ch") ||
            self.hasSuffix("sh")
    }

}
