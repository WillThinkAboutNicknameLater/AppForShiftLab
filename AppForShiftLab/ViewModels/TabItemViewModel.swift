//
//  TabItemViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 07.10.2021.
//

import Foundation

struct TabItemViewModel: Hashable {
    var imageName: String
    var title: String
    var type: TabItemType
    
    enum TabItemType {
        case home
        case profle
    }
}
