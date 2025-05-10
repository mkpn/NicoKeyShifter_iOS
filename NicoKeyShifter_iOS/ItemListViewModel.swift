//
//  ItemListViewModel.swift
//  NicoKeyShifter_iOS
//
//  Created by 吉田誠 on 2025/05/11.
//

import Factory
import SwiftUI //[Question] これ依存して大丈夫なのかな？

@MainActor
public class ItemListViewModel: ObservableObject {
    @Injected(\.itemRepository) var itemRepository
    
    public init() {}
    
    public func addItem() {
        Task {
            let newItem = Item(timestamp: Date())
            await itemRepository.add(newItem)
        }
    }
}
