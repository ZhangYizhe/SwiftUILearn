//
//  PokemonList.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2019/11/8.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    @State var expandingIndex: Int?
    
    @State var searchContent : String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                SearchControl
                
                ForEach(PokemonViewModel.all) { pokemon in
                    PokemonInfoRow(model: pokemon, expanded: self.expandingIndex == pokemon.id)
                        .onTapGesture {
                            if self.expandingIndex == pokemon.id {
                                self.expandingIndex = nil
                            } else {
                                self.expandingIndex = pokemon.id
                            }
                    }
                }
            }.navigationBarTitle("宝可梦列表")
        }
        
//        .overlay(
//            VStack {
//                Spacer()
//                PokemonInfoPanel(model: .sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}

extension PokemonList {
    var SearchControl: some View {
        ZStack {
            TextField("搜索宝可梦", text: $searchContent)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .font(.system(size: 14))
            
            RoundedRectangle(cornerRadius: 8).stroke(Color.init(hex: 000000, alpha: 0.2), style: StrokeStyle(lineWidth: 0.5))
        }
        .padding(.horizontal)

    }
}
