//
//  StringExtension.swift
//  Digital Name
//
//  Created by Marcel on 15.07.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
