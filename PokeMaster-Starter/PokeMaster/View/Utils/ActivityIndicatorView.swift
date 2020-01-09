//
//  ActivityIndicatorView.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIView {
        let view = UIView()
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .gray
        view.addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        
    }
    
    
    
}
