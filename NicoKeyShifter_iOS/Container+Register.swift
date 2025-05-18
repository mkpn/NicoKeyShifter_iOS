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
        
        Container.shared.searchVideoUseCase.register { SearchVideoUseCaseImpl(searchRepository: self.searchRepository()) }
        
        Container.shared.notificationPermissionDao.register { NotificationPermissionDaoImpl() }
        Container.shared.notificationPermissionRepository.register { NotificationPermissionRepositoryImpl(notificationPermissionDao: self.notificationPermissionDao()) }
        Container.shared.checkNotificationPermissionUseCase.register { CheckNotificationPermissionUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository()) }
        Container.shared.checkNotificationPermissionRequestedUseCase.register { CheckNotificationPermissionRequestedUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository()) }
        Container.shared.updateNotificationPermissionRequestedUseCase.register { UpdateNotificationPermissionRequestedUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository()) }
    }
}
