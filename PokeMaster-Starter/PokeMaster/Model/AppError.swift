//
//  AppError.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/8.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable {
    var id: String{ localizedDescription }
    
    case passwordWrong
}

extension AppError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .passwordWrong:
            return "密码错误"
        }
    }
}
