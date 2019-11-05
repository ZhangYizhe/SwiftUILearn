//
//  HistoryView.swift
//  Calculator
//
//  Created by 张艺哲 on 2019/11/4.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        VStack {
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                HStack {
                    Text("显示").font(.headline)
                    Text("\(model.brain.output)")
                }
                
                HStack(spacing: CGFloat(0)) {
                    ForEach(model.history, id: \.self) { item in
                        Text("\(item.title)")
                    }.padding(.zero)
                }
                
                Slider(
                    value: $model.slidingIndex,
                    in: 0...Float(model.totalCount),
                    step: Float(1)
                )
            }
        }.padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(model: CalculatorModel())
    }
}
