//
//  Stores.swift
//  ChildToParent
//
//  Created by Mufakkharul Islam Nayem on 12/19/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Combine

class SettingsStore: ObservableObject {
    @Published var saveable = false
}

class PickerStore: ObservableObject {
    public let objectWillChange = PassthroughSubject<Int?, Never>()
    var selected: Int? {
        willSet {
            objectWillChange.send(newValue)
        }
    }
}
