//
//  Verb.swift
//  MVCLesson
//
//  Created by Elizaveta Potapova on 10/29/24.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let parcticiple: String
    var translation: String {
        NSLocalizedString(self.infinitive, comment: "")
    }
}
