//
//  TemaView.swift
//  Memoria
//
//  Created by Pedro Henrique on 29/03/21.
//

import SwiftUI

struct TemaView: View {
    var viewModel = TemaViewModel()
    
    @State
    var melhorPontuacao: Double = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                apresentaTemas()
                Spacer()
                if melhorPontuacao > Double.zero {
                    Text("Melhor pontuação: " + String(format: "%.2f", melhorPontuacao))
                }
            }
            .navigationTitle("Jogo da Memória")
            .padding()
            .onAppear (perform: {
                melhorPontuacao = recuperaMaiorPontuacao()
            })
        }
    }
    
    @ViewBuilder
    func apresentaTemas() -> some View {
        NavigationLink(destination: JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji(tema: viewModel.temas[0]))) {
            Text(viewModel.temas[0].nome)
        }
        NavigationLink(destination: JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji(tema: viewModel.temas[1]))) {
            Text(viewModel.temas[1].nome)
        }
        NavigationLink(destination: JogoMemoriaEmojiView(viewModel: JogoMemoriaEmoji(tema: viewModel.temas[2]))) {
            Text(viewModel.temas[2].nome)
        }
    }
    
    func recuperaMaiorPontuacao() -> Double {
        UserDefaults.standard.double(forKey: UserDefaultKeys.melhorBonus.rawValue)
    }
}

struct TemaView_Previews: PreviewProvider {
    static var previews: some View {
        TemaView()
    }
}
