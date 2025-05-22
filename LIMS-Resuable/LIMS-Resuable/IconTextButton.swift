//
//  IconTextButton.swift
//  LIMS-Resuable
//
//  Created by Chaitanya Makkapati on 4/10/25.
//
import SwiftUI

struct IconTextButton: View {
    // Configuration Properties
    let systemImage: String
    let text: String
    let component: IconTextButtonType
    var menuItems: [String] = []
    var normalBackground: Color = Color.gray.opacity(0.2)
    var activeBackground: Color = AppColors.primaryColor
    var action: (() -> Void)? = nil

    //  State
    @State private var isActive = false
    @State private var selectedItems: Set<String> = []

    // Initializer
    init(systemImage: String,
         text: String,
         component: IconTextButtonType,
         menuItems: [String] = []) {
        self.systemImage = systemImage
        self.text = text
        self.component = component
        self.menuItems = menuItems
        
        // If the component is a menu, all items are selected by default.
        if case .menu = component {
            _selectedItems = State(initialValue: Set(menuItems))
            _isActive = State(initialValue: true)
        }
    }
    
    //  Computed Properties
    private var currentBackground: Color {
        switch component {
        case .button:
            return isActive ? activeBackground : normalBackground
        case .menu:
            return activeBackground
       
        }
    }
    
    /// For menus, if exactly one item is selected, show that item; otherwise, show the default text.
    private var menuDisplayText: String {
        selectedItems.count == 1 ? selectedItems.first! : text
    }
    
    //  Body
    var body: some View {
        Group {
            switch component {
            case .button:
                Button {
                    isActive.toggle()
                    action?()
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: systemImage).imageScale(.medium)
                        Text(text).font(.body)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(currentBackground)
                    .cornerRadius(8)
                }
                
            case .menu:
                Menu {
                    ForEach(menuItems, id: \.self) { item in
                        MenuItemButton(title: item,
                                       isSelected: selectedItems.contains(item)) {
                            if selectedItems.contains(item) {
                                selectedItems.remove(item)
                            } else {
                                selectedItems.insert(item)
                            }
                            action?()
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: systemImage).imageScale(.medium)
                        Text(menuDisplayText).font(.body)
                        Image(systemName: "chevron.down").imageScale(.small)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(currentBackground)
                    .cornerRadius(8)
                }
                
           
            }
        }
    }
}


struct IconTextButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            IconTextButton(
                systemImage: "building.columns",
                text: "Location",
                component: .menu,
                menuItems: ["Versa", "Non-Versa"]
            )
            IconTextButton(
                systemImage: "mappin",
                text: "County",
                component: .menu,
                menuItems: ["Albany", "Erie", "Bronx", "Cayuga"]
            )
            IconTextButton(
                systemImage: "arrow.triangle.2.circlepath",
                text: "Sync",
                component: .button
            )
            IconTextButton(
                systemImage: "plus.square",
                text: "New Non-Versa Establishment",
                component: .button
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

