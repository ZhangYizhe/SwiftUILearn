//
//  ContentView.swift
//  Calculator
//
//  Created by 张艺哲 on 2019/11/4.
//  Copyright © 2019 Elecoxy.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(
                    minWidth: 0,
                    maxWidth:  .infinity,
                    alignment: .trailing)
            CalculatorButtonPad()
                .padding(.bottom)
        }
    .scaleEffect(scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//            ContentView().previewDevice("iPhone SE")
        }
    }
}

