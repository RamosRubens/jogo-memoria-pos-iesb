//
//  CartaModifier.swift
//  Memoria
//
//  Created by Pedro Henrique on 22/03/21.
//

import SwiftUI


struct CartaModifier: ViewModifier {
    
    private var rotacao: Double
    
    init(viradaParaCima: Bool) {
        rotacao = viradaParaCima ? 0 : 180
    }
    
    var viradaParaCima: Bool {
        rotacao < 90
    }
    
    // MARK: - Constantes de Desenho
    private let cornerRadius: CGFloat = 12
    private let espessuraDaLinha: CGFloat = 4
    
    @ViewBuilder
    func body(content: Content) -> some View {
        ZStack {
            cartaViradaParaCima(content: content)
                .opacity(viradaParaCima ? 1 : 0)
            
            cartaViradaParaBaixo()
                .opacity(viradaParaCima ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotacao), axis: (0, 1, 0))
    }
    
    @ViewBuilder
    func cartaViradaParaCima(content: Content) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: espessuraDaLinha)
        content
    }
    
    func cartaViradaParaBaixo() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius).fill()
    }
    
}

extension View {
    
    func fazerCarta(viradaParaCima: Bool) -> some View {
        self.modifier(CartaModifier(viradaParaCima: viradaParaCima))
    }
    
}
