//
//  NewCalculatorButton.swift
//  Calculator
//
//  Created by 张艺哲 on 2019/11/4.
//  Copyright © 2019 Elecoxy.com. All rights reserved.
//

import SwiftUI

struct NewCalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(Color(backgroundColorName))
                .frame(width: size.width, height: size.height)
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
        }
    }
}

struct NewCalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        NewCalculatorButton(title: "1", size: CGSize(width: 88 * 2 + 8, height: 88), backgroundColorName: "operatorBackground") {
            
        }
    }
}
