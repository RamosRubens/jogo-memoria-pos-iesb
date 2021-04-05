//
//  JogoMemoria.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import Foundation

struct JogoMemoria<ConteudoCarta> where ConteudoCarta: Equatable { //Model
    var cartas: [Carta]
    
    var jogoAcabou: Bool {
        cartas.allSatisfy({ $0.estaCombinada })
    }
    
    private var indiceCartaPreviamenteEscolhida: Int? {
        get {
            cartas.indices.filter { cartas[$0].isViradaParaCima }.only
        }
        set {
            for index in cartas.indices {
                cartas[index].isViradaParaCima = index == newValue
            }
        }
    }
    
    init(numeroParesCartas: Int, fabricaConteudoCartas: (Int) -> ConteudoCarta) {
        
        cartas = Array<Carta>()
        for indicePar in 0..<numeroParesCartas {
            let conteudo = fabricaConteudoCartas(indicePar)
            cartas.append(Carta(id: indicePar * 2, conteudo: conteudo))
            cartas.append(Carta(id: indicePar * 2 + 1, conteudo: conteudo))
        }
        cartas.shuffle()
    }
    
    mutating func escolher(carta: Carta) {
        print("Carta escolhida: \(carta)")
        
        if let indiceCartaEscolhida = cartas.firstIndex(matching: carta) {
            if let possivelCombinacao = indiceCartaPreviamenteEscolhida {
                if cartas[indiceCartaEscolhida].conteudo == cartas[possivelCombinacao].conteudo {
                    cartas[indiceCartaEscolhida].estaCombinada = true
                    cartas[possivelCombinacao].estaCombinada = true
                }
                cartas[indiceCartaEscolhida].isViradaParaCima = true
                verificaPontuacaoFinal()
            }else {
                indiceCartaPreviamenteEscolhida = indiceCartaEscolhida
            }
        }
    }
    
    fileprivate func verificaPontuacaoFinal() {
        if cartas.filter({$0.estaCombinada == false}).count > 0 {
            return
        }
        
        var bonus: Double = .zero
        for carta in cartas {
            bonus += carta.bonusRestante
        }
        
        let chave = UserDefaultKeys.melhorBonus.rawValue
        if UserDefaults.standard.double(forKey: chave) < bonus {
            UserDefaults.standard.setValue(bonus, forKey: chave)
        }
        
        UserDefaults.standard.setValue(bonus, forKey: UserDefaultKeys.ultimoBonus.rawValue)
    }
    
    struct Carta: Identifiable {
        var id: Int
        var isViradaParaCima = false {
            didSet {
                if isViradaParaCima {
                    comecarUsarTempoBonus()
                }else {
                    pararUsarTempoBonus()
                }
            }
        }
        var estaCombinada = false {
            didSet {
                pararUsarTempoBonus()
            }
        }
        var conteudo: ConteudoCarta
        
        var tempoBonus: TimeInterval = 6
        
        var ultimaVezVirouParaCima: Date?
        var ultimoTempoQueFicouViradaParaCima: TimeInterval = 0
        
        private var tempoViradaParaCima: TimeInterval {
            if let ulimaVirada = self.ultimaVezVirouParaCima {
                return ultimoTempoQueFicouViradaParaCima + Date().timeIntervalSince(ulimaVirada)
            }else {
                return ultimoTempoQueFicouViradaParaCima
            }
        }
        
        var bonusRestante: Double {
            (tempoBonus > 0 && tempoBonusRestante > 0) ? tempoBonusRestante / tempoBonus : 0
        }
        
        var tempoBonusRestante: TimeInterval {
            max(0, tempoBonus - tempoViradaParaCima)
        }
        
        var estaConsumindoTempoBonus: Bool {
            isViradaParaCima && !estaCombinada && tempoBonusRestante > 0
        }
        
        private mutating func comecarUsarTempoBonus() {
            if estaConsumindoTempoBonus, ultimaVezVirouParaCima == nil {
                ultimaVezVirouParaCima = Date()
            }
         }
        
        private mutating func pararUsarTempoBonus() {
            ultimoTempoQueFicouViradaParaCima = tempoViradaParaCima
            ultimaVezVirouParaCima = nil
        }
    
    }
    
}
