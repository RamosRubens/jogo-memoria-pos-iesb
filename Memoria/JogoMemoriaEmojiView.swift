//
//  JogoMemoriaEmojiView.swift
//  Memoria
//
//  Created by Pedro Henrique on 08/03/21.
//

import SwiftUI

struct JogoMemoriaEmojiView: View { // View
    
    @ObservedObject
    var viewModel: JogoMemoriaEmoji
    
    var body: some View {
        VStack {
            if viewModel.jogoAcabou {
                gameOver()
            } else {
                Grid(viewModel.cartas) { carta in
                    CardView(carta: carta)
                        .onTapGesture {
                            withAnimation(.linear) {
                                viewModel.escolher(carta: carta)
                            }
                        }
                        .padding(4)
                }
            }
            
            Button("Novo Jogo") {
                withAnimation(.easeInOut) {
                    viewModel.novoJogo()
                }
            }
        }
        
        .padding()
        .foregroundColor(viewModel.tema.cor)
    }
    
    @ViewBuilder
    func gameOver() -> some View {
        let ultimaPontuacao = getUltimaPontuacao()
        let melhorPontuacao = getMelhorPontuacao()
        
        Spacer()
        if ultimaPontuacao == melhorPontuacao {
            Text("Novo recorde: " + String(format: "%.2f", melhorPontuacao))
        } else {
            Text("Ultima pontuação: " + String(format: "%.2f", ultimaPontuacao))
        }
        Spacer()
    }
    
    func getUltimaPontuacao() -> Double {
        UserDefaults.standard.double(forKey: UserDefaultKeys.ultimoBonus.rawValue)
    }
    
    func getMelhorPontuacao() -> Double {
        UserDefaults.standard.double(forKey: UserDefaultKeys.melhorBonus.rawValue)
    }
    
}


struct CardView: View {
    var carta: JogoMemoria<String>.Carta
    
    @State
    private var tempoRestanteBonus: Double = 0
    
    private func comecarAnimCronometro() {
        tempoRestanteBonus = carta.bonusRestante
        withAnimation(.linear(duration: carta.tempoBonusRestante)) {
            tempoRestanteBonus = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if carta.isViradaParaCima || !carta.estaCombinada {
                ZStack {
                    Group {
                        if carta.estaConsumindoTempoBonus {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-tempoRestanteBonus * 360 - 90),
                                       sentidoHorario: true)
                            .onAppear {
                                comecarAnimCronometro()
                            }
                        }else {
                            Cronometro(anguloInicial: Angle.degrees(0-90),
                                       anguloFinal: Angle.degrees(-carta.bonusRestante * 360 - 90),
                                       sentidoHorario: true)
                        }
                    }
                    .opacity(0.5)
                    .padding(4)
                    
                    Text(carta.conteudo)
                        .font(Font.system(size: tamanhoFonte(para: geometry.size)))
                        .rotationEffect(Angle.degrees(carta.estaCombinada ? 360 : 0))
                        .animation(carta.estaCombinada ? Animation.linear(duration: 3).repeatForever(autoreverses: false) : .default)
                }
                .fazerCarta(viradaParaCima: carta.isViradaParaCima)
                .transition(.scale)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji(tema: Tema(cor: Color.clear, emojis: [], nome: "")))
    }
}
