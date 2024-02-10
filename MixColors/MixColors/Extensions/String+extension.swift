//
//  String+extension.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 10.02.2024.
//

import Foundation


extension String {
    func localized() -> String {
        NSLocalizedString(self,
                          tableName: "Localizable",
                          bundle: .main,
                          value: self,
                          comment: self)
    }
}
