//
//  Grid.swift
//  Memoria
//
//  Created by Pedro Henrique on 15/03/21.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    private var itens: [Item]
    private var viewParaItem: (Item) -> ItemView
    
    init(_ itens: [Item], viewParaItem: @escaping (Item) -> ItemView) {
        self.itens = itens
        self.viewParaItem = viewParaItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(para: GridLayout(itemCount: itens.count, in: geometry.size))
        }
    }
    
    private func body(para layout: GridLayout) -> some View {
        ForEach(itens) { body(para: $0, no: layout) }
    }
    
    private func body(para item: Item, no layout: GridLayout) -> some View {
        Group {
            if let index = itens.firstIndex(matching: item) {
                viewParaItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
            }
        }
    }
}
