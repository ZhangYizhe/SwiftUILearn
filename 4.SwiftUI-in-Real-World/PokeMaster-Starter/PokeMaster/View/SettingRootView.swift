//
//  SettingRootView.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2019/11/12.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView().navigationBarTitle("设置")
        }
    }
}

struct SettingRootView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
