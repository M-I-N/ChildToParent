//
//  ContentView.swift
//  ChildToParent
//
//  Created by Mufakkharul Islam Nayem on 12/19/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var store = SettingsStore()
    @ObservedObject var pickerStore = PickerStore()

    var body: some View {
        VStack {
            Button(action: saveAction){
                Text("Save")
            }.disabled(!store.saveable)
            getSpecificV2()
        }.environmentObject(store)
    }

    func getSpecificV2() -> AnyView {
        // [Determining logic...]
        return AnyView(SpecificSettingsView(pickerStore: pickerStore))
    }

    func saveAction(){
        // More code...
    }
}

struct SpecificSettingsView: View {
    @EnvironmentObject var settingsStore: SettingsStore
    @ObservedObject var pickerStore: PickerStore

    @State var toggled = false
    @State var selectedValue: Int?

    var body: some View {
        Form {
            Toggle(isOn: $toggled) {
                Text("Toggle me")
            }
            CustomPicker(store: pickerStore)
        }.onReceive(pickerStore.objectWillChange){ selected in
            self.settingsStore.saveable = self.someCriteriaProcess()
        }
    }

    func someCriteriaProcess() -> Bool {
        if let selected = selectedValue {
            return (selected == 5)
        } else {
            return toggled
        }
    }
}

struct CustomPicker: View {
    @ObservedObject var store: PickerStore

    var body: some View {
        List {
            Text("None")
                .onTapGesture {
                    self.store.selected = nil
            }.foregroundColor(store.selected == nil ? .blue : .primary)
            Text("One")
                .onTapGesture {
                    self.store.selected = 1
            }.foregroundColor(store.selected == 1 ? .blue : .primary)
            Text("Two")
                .onTapGesture {
                    self.store.selected = 2
            }.foregroundColor(store.selected == 2 ? .blue : .primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
