//
//  SearchException.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation

/**
 * 検索関連の例外の基底クラス
 */
public enum SearchException: Error {
    /**
     * APIからのレスポンスが失敗した場合の例外
     *
     * @param statusCode HTTPステータスコード
     */
    case apiError(statusCode: Int)
    
    /**
     * 予期せぬエラーの例外
     */
    case unexpectedError(error: Error)
    
    public var localizedDescription: String {
        switch self {
        case .apiError(let statusCode):
            return "検索APIエラー: ステータスコード \(statusCode)"
        case .unexpectedError:
            return "予期せぬエラーが発生しました"
        }
    }
}
