//
//  JogoMemoriaEmoji.swift
//  Memoria
//
//  Created by Pedro Henrique on 15/03/21.
//

import Foundation

class JogoMemoriaEmoji: ObservableObject { //ViewModel
    
    @Published
    var model: JogoMemoria<String>
    var tema: Tema
    
    var jogoAcabou: Bool {
        model.jogoAcabou
    }
    
    init(tema: Tema) {
        self.tema = tema
        model = JogoMemoriaEmoji.criarJogoMemoria(tema: tema)
    }
    
    static func criarJogoMemoria(tema: Tema) -> JogoMemoria<String> {
        var emojis = tema.emojis.shuffled()
        emojis = emojis.dropLast(emojis.count - Int.random(in: 2...5))
        
        return JogoMemoria<String>(numeroParesCartas: emojis.count) { emojis[$0] }
    }
    
    // MARK: - Acesso à Model
    
    var cartas: Array<JogoMemoria<String>.Carta> {
        model.cartas
    }
    
    var numeroPares: Int {
        Int(model.cartas.count / 2)
    }
    
    // MARK: - Processamento de Intenções
    
    func escolher(carta: JogoMemoria<String>.Carta) {
        model.escolher(carta: carta)
    }
    
    func novoJogo() {
        model = JogoMemoriaEmoji.criarJogoMemoria(tema: self.tema)
    }
}
