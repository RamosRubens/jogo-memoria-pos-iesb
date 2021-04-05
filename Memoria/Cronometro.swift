//
//  Cronometro.swift
//  Memoria
//
//  Created by Pedro Henrique on 22/03/21.
//

import SwiftUI

struct Cronometro: Shape {
    
    var anguloInicial: Angle
    var anguloFinal: Angle
    var sentidoHorario: Bool = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(anguloInicial.radians, anguloFinal.radians)
        }
        set {
            anguloInicial = Angle(radians: newValue.first)
            anguloFinal = Angle(radians: newValue.second)
        }
    }
    
    // 1/30 de segundo - Modo Economia de Bateria
    // 1/40 de segundo - Modo normal - iPad, iPhone
    // 1/60 de segundo - Modo normal - iPhone Pro
    // 1/120 de segundo - Modo normal - iPad Pro
    func path(in rect: CGRect) -> Path {
        let centro = rect.center
        let circunferencia = min(rect.width, rect.height) / 2
        let pontoPartida = CGPoint(
            x: centro.x + circunferencia * cos(CGFloat(anguloInicial.radians)),
            y: centro.y + circunferencia * sin(CGFloat(anguloInicial.radians))
        )
        
        var caminho = Path()
        caminho.move(to: centro)
        caminho.addLine(to: pontoPartida)
        caminho.addArc(center: centro, radius: circunferencia, startAngle: anguloInicial, endAngle: anguloFinal, clockwise: sentidoHorario)
        caminho.addLine(to: centro)
        return caminho
    }
    
}

fileprivate extension CGRect {
    
    var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }
    
}
