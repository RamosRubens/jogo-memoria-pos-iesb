//
//  TemaViewModel.swift
//  Memoria
//
//  Created by Euler Carvalho on 29/03/21.
//

import SwiftUI

struct Tema {
    let cor: Color
    let emojis: [String]
    let nome: String
}

class TemaViewModel {
    var temas: [Tema] {
        var temas: [Tema] = []
        temas.append(Tema(cor: Color.red, emojis: ["🍇", "🥑", "🌶", "🌽", "🥐", "🍉"], nome: "Comidas"))
        temas.append(Tema(cor: Color.black, emojis: ["🤞", "💪", "👂" ,"👃", "👀", "👄"], nome: "Partes do corpo"))
        temas.append(Tema(cor: Color.blue, emojis: ["🇦🇽", "🇦🇿", "🇨🇰", "🇨🇷", "🇧🇲", "🇨🇿"], nome: "Bandeiras"))
        return temas
    }
}
