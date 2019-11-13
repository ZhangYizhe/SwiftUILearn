//
//  BlurView.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2019/11/11.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    let blurEffect : UIBlurEffect
    
    let blurView : UIVisualEffectView
    
    init(style: UIBlurEffect.Style) {
        print("Init")
        self.style = style
        self.blurEffect = UIBlurEffect(style: style)
        self.blurView = UIVisualEffectView(effect: blurEffect)
    }
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        print("makeUIView")
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
        uiView.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
        ])
    }
}

extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
