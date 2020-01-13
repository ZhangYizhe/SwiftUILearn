//
//  AppCommand.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

protocol AppCommand {
    func execute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoginRequest(
            email: email,
            password: password)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete {
                    store.dispatch(.accountBehaviorDone(result: .failure(error)))
                }
                token.unseal()
            }) { user in
                store.dispatch(.accountBehaviorDone(result: .success(user)))
        }.seal(in: token)
    }
}

struct WriteUserAppCommand: AppCommand {
    let user: User
    
    func execute(in store: Store) {
        try? FileHelper.writeJSON(user, to: .documentDirectory, fileName: "user.json")
    }
}

struct LoadPokemonsCommand: AppCommand {
    func execute(in store: Store) {
        let token = SubscriptionToken()
        LoadPokemonRequest.all
            .sink(
                receiveCompletion: { complete in
                    if case .failure(let error) = complete {
                        store.dispatch(
                            .loadPokemonsDone(result: .failure(error))
                        )
                    }
                    token.unseal()
            }) { value in
                store.dispatch(
                    .loadPokemonsDone(result: .success(value))
                )
        }.seal(in: token)
    }
}
