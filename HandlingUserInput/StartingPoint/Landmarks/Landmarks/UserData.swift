//
//  UserData.swift
//  Landmarks
//
//  Created by 张艺哲 on 2019/9/24.
//  Copyright © 2019 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
