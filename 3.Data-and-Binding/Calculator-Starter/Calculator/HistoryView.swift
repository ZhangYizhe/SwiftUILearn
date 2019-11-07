//
//  HistoryView.swift
//  Calculator
//
//  Created by 张艺哲 on 2019/11/4.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @Binding var editingHistory : Bool
    
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        NavigationView {
            VStack {
                if model.totalCount == 0 {
                    Text("没有履历")
                } else {
                    HStack {
                        Text("显示").font(.headline)
                        Text("\(model.brain.output)")
                    }
                    
                    Text(model.historyDetail)
                    
                    Slider(
                        value: $model.slidingIndex,
                        in: 0...Float(model.totalCount),
                        step: Float(1)
                    )
                }
            }.padding()
            
            .navigationBarItems(
                leading: Button(action: {
                    self.editingHistory = false
                }, label: {
                    Text("关闭")
                })
            )
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    @State static var editingHistory = true
    
    static var previews: some View {
        HistoryView(editingHistory: $editingHistory, model: CalculatorModel())
    }
}
