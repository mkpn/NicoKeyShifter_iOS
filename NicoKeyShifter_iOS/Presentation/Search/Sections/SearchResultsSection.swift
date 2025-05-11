//
//
//

import SwiftUI

struct SearchResultsSection: View {
    let uiState: SearchVideoUiState
    
    var body: some View {
        Group {
            if uiState.isInitialState {
                VStack {
                    Spacer()
                    Text("キーワードを入力して検索してください")
                        .padding(.top, 32)
                    Spacer()
                }
            }
            else if uiState.isEmpty {
                VStack {
                    Spacer()
                    Text("「\(uiState.query)」の検索結果が見つかりませんでした")
                        .padding(.top, 32)
                    Spacer()
                }
            }
            else if uiState.isSuccess && !uiState.videos.isEmpty {
                VStack(alignment: .leading) {
                    Text("「\(uiState.query)」の検索結果: \(uiState.videos.count)件")
                        .font(.headline)
                        .padding(.vertical, 8)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(uiState.videos, id: \.id) { video in
                                VideoItemRowComponent(video: video)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SearchResultsSection_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsSection(uiState: SearchVideoUiState.ofDefault())
    }
}
