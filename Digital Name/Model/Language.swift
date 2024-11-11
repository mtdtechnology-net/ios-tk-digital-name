//
//  Language.swift
//  Digital Name
//
//  Created by Marcel on 15.07.2024.
//

enum Language: String, CaseIterable, Identifiable {
    case english = "english"
    case turkish = "turkish"
    case spanish = "spanish"
    case russian = "russian"
    case romanian = "romanian"
    case polish = "polish"
    case italian = "italian"
    case greek = "greek"
    case german = "german"
    case arabic = "arabic"

    var id: String { self.rawValue }
}

extension Language {
    var icon: String {
        switch self {
        case .english: "england"
        case .turkish: "turkey"
        case .spanish: "spain"
        case .russian: "russia"
        case .romanian: "romania"
        case .polish: "poland"
        case .italian: "italy"
        case .greek: "greece"
        case .german: "germany"
        case .arabic: "arabic"
        }
    }

    var description: String {
        switch self {
        case .english: return "english_language".localized
        case .turkish: return "turkish_language".localized
        case .spanish: return "spanish_language".localized
        case .russian: return "russian_language".localized
        case .romanian: return "romanian_language".localized
        case .polish: return "polish_language".localized
        case .italian: return "italian_language".localized
        case .greek: return "greek_language".localized
        case .german: return "german_language".localized
        case .arabic: return "arab_language".localized
        }
    }
}
