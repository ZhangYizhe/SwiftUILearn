//
//  AppState.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/8.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

struct AppState {
    var settings = Settings()
    
    var pokemonList = PokemonList()
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id,name,color,favorite
        }
        
        enum AccountBehavior: CaseIterable {
            case register,login
        }
        
        enum PasswordValidStatus: CaseIterable {
            case empty,legitimate,illegal
        }
        
        @UserDefaultsStorage(key: "showEnglishName")
        var showEnglishName: Bool
        
        var sorting = Sorting.id
        
        @UserDefaultsStorage(key: "showFavoriteOnly")
        var showFavoriteOnly: Bool
        
        var isEmailValid: Bool = false
        
        var passwordValidStatus = PasswordValidStatus.empty
        
        var canRegisterValid: Bool = false
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.register
            @Published var email = ""
            @Published var password = ""
            @Published var verifyPassword = ""
            
            var isEmailValid: AnyPublisher<Bool, Never> {
                let remoteVerify = $email
                    .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    .removeDuplicates()
                    .flatMap { email -> AnyPublisher<Bool, Never> in
                        let vaildEmail = email.isValidEmailAddress
                        let canSkip = self.accountBehavior == .login
                        
                        switch (vaildEmail, canSkip) {
                        case (false, _):
                            return Just(false).eraseToAnyPublisher()
                        case (true, false):
                            return EmailCheckingRequest(email: email)
                                .publisher
                                .eraseToAnyPublisher()
                        case (true, true):
                            return Just(true).eraseToAnyPublisher()
                        }
                }
                
                let emailLocalValid = $email.map {
                    $0.isValidEmailAddress
                }
                
                let canSkipRemoteVerify = $accountBehavior.map {
                    $0 == .login
                }
                
                return Publishers.CombineLatest3(emailLocalValid, canSkipRemoteVerify, remoteVerify)
                    .map {$0 && ($1 || $2)}
                    .eraseToAnyPublisher()
                
            }
            
            var isPasswordValid: AnyPublisher<PasswordValidStatus, Never> {
                let password = $password
                let verifyPassword = $verifyPassword
                
                return Publishers.CombineLatest(password, verifyPassword)
                    .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
                    .flatMap { (password, verifyPassword) -> AnyPublisher<PasswordValidStatus, Never> in
                        if password == "" {
                            return Just(.empty).eraseToAnyPublisher()
                        } else {
                            if verifyPassword == "" {
                                return Just(.empty).eraseToAnyPublisher()
                            } else {
                                if password == verifyPassword {
                                    return Just(.legitimate).eraseToAnyPublisher()
                                } else {
                                    return Just(.illegal).eraseToAnyPublisher()
                                }
                            }
                        }
                }.eraseToAnyPublisher()
            }
            
            var canRegisterValid: AnyPublisher<Bool, Never> {
                Publishers.CombineLatest(isEmailValid, isPasswordValid)
                    .map { $0 && $1 == .legitimate}
                    .eraseToAnyPublisher()
            }
        }
        
        var checker = AccountChecker()
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        var loginRequesting = false
        var loginError: AppError?
    }
    
}

extension AppState {
    struct PokemonList {
        
        @FileStorage(directory: .cachesDirectory, fileName: "pokemons.json")
        var pokemons: [Int: PokemonViewModel]?
        var loadingPokemons = false
        
        var allPokemonsByID: [PokemonViewModel] {
            guard let pokemons = pokemons?.values else {
                return []
            }
            return pokemons.sorted {$0.id < $1.id}
        }
    }
}
