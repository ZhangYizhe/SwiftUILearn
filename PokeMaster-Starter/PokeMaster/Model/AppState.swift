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
}

extension AppState {
    struct Settings {
        enum Sorting: CaseIterable {
            case id,name,color,favorite
        }
        
        enum AccountBehavior: CaseIterable {
            case register,login
        }
        
        @UserDefaultsStorage(key: "showEnglishName")
        var showEnglishName: Bool
        
        var sorting = Sorting.id
        
        @UserDefaultsStorage(key: "showFavoriteOnly")
        var showFavoriteOnly: Bool
        
        var isEmailValid: Bool = false
        
        class AccountChecker {
            @Published var accountBehavior = AccountBehavior.login
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
        }
        
        var checker = AccountChecker()
        
        @FileStorage(directory: .documentDirectory, fileName: "user.json")
        var loginUser: User?
        
        var loginRequesting = false
        var loginError: AppError?
    }
}
