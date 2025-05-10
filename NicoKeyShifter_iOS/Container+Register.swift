//
//  Container+Register.swift
//  NicoKeyShifter_iOS
//
//  Created by 吉田誠 on 2025/05/11.
//

import Factory

extension Container: @retroactive AutoRegistering {
    public func autoRegister() {
        // [Question] これってちゃんと意味がある登録処理なのかな... repositoryだけで良かったりしないだろうか
        Container.shared.itemDataSource.register { ItemDataSourceImpl() }
        Container.shared.itemRepository.register { ItemRepositoryImpl() }
    }
}
