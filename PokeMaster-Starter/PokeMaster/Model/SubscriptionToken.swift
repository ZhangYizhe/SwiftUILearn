//
//  SubscriptionToken.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

class SubscriptionToken {
    var cancellable: AnyCancellable?
    
    func unseal()  {cancellable = nil}
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}
