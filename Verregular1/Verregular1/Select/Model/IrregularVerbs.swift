//
//  IrregularVerbs.swift
//  MVCLesson
//
//  Created by Elizaveta Potapova on 10/29/24.
//

import Foundation

final class IrregularVerbs {
    
    // Singleton
    static var shared = IrregularVerbs()
    
    
    private init() {
        configureVerbs()
    }
    
    // MARK: - Properties
    var selectedVerbs: [Verb] = []
    
    private(set) var verbs: [Verb] = []
    
    // MARK: - Methods
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", parcticiple: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", parcticiple: "drown"),
            Verb(infinitive: "eat", pastSimple: "ate", parcticiple: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", parcticiple: "fallen"),
            Verb(infinitive: "be", pastSimple: "was", parcticiple: "been"),
            Verb(infinitive: "become", pastSimple: "became", parcticiple: "become"),
            Verb(infinitive: "bring", pastSimple: "brought", parcticiple: "brought"),
            Verb(infinitive: "buy", pastSimple: "bought", parcticiple: "bought"),
            Verb(infinitive: "choose", pastSimple: "chose", parcticiple: "chosen"),
            Verb(infinitive: "come", pastSimple: "came", parcticiple: "come"),
            Verb(infinitive: "do", pastSimple: "did", parcticiple: "done"),
            Verb(infinitive: "drind", pastSimple: "drank", parcticiple: "drunk"),
            Verb(infinitive: "drive", pastSimple: "drove", parcticiple: "driven"),
            Verb(infinitive: "find", pastSimple: "found", parcticiple: "found"),
            Verb(infinitive: "fly", pastSimple: "flew", parcticiple: "flown"),
            Verb(infinitive: "forget", pastSimple: "forgot", parcticiple: "forgotten"),
            Verb(infinitive: "get", pastSimple: "got", parcticiple: "got"),
            Verb(infinitive: "let", pastSimple: "let", parcticiple: "let")
        ]
        
        selectedVerbs = verbs
    }
}
