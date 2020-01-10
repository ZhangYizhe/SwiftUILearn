//
//  EmailCheckingRequest.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/10.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct EmailCheckingRequest {
    let email: String
    
    var publisher: AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5)
            {
                if self.email.lowercased() == "test@gmail.com" {
                    promise(.success(false))
                } else {
                    promise(.success(true))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
