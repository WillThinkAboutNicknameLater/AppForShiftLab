//
//  TabContainerViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 07.10.2021.
//

import Foundation

final class TabContainerViewModel: ObservableObject {
    @Published var selectedTab: TabItemViewModel.TabItemType = .home
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "house.circle", title: "Home", type: .home),
        TabItemViewModel(imageName: "person.crop.circle", title: "Profile", type: .profle)
    ]
}
