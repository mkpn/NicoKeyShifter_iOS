//
//
//

import SwiftUI
import Factory
import UserNotifications
import AppTrackingTransparency

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchQuery = ""

    var body: some View {
         NavigationView {
             VStack {
                 HStack {
                     Button(action: {
                         viewModel.search(query: searchQuery)
                     }) {
                         Image(systemName: "magnifyingglass")
                     }
                     .padding(.leading, 8)
                     
                     TextField("検索キーワード", text: $searchQuery)
                         .padding(8)
                         .onSubmit {
                             viewModel.search(query: searchQuery)
                         }
                     
                     if !searchQuery.isEmpty {
                         Button(action: {
                             searchQuery = ""
                             viewModel.clearSearch()
                         }) {
                             Image(systemName: "xmark.circle.fill")
                                 .foregroundColor(.gray)
                         }
                         .padding(.trailing, 8)
                     }
                 }
                 .padding(8)
                 .background(Color(.systemGray6))
                 .cornerRadius(10)
                 .padding(.horizontal)
                 
                 if viewModel.uiState.isLoading {
                     ProgressView()
                         .padding()
                 }
                 
                 if viewModel.uiState.isError {
                     Text(viewModel.uiState.errorMessage ?? "エラーが発生しました")
                         .foregroundColor(.red)
                         .padding()
                 }
                 
                 SearchResultsSection(uiState: viewModel.uiState)
                     .padding(.horizontal)
                 
                 Spacer()
             }
             .navigationTitle("動画検索")
             .onChange(of: viewModel.uiState) { newState in
                 print("デバッグ newState: \(newState)")
                 switch newState.modalTarget {
                 case .notification:
                     requestNotificationPermission()
                 case .att:
                     requestATTPermission()
                 case .none:
                     break
                 }
             }
         }
     }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                viewModel.finishNotificationPermissionRequested()
            }
        }
    }

    private func requestATTPermission() {
        print("デバッグ なぜここが勝手に呼ばれるんですか")
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                print("デバッグ なぜここが勝手に呼ばれるんですか2 \(status)")
                viewModel.finishATTPermissionRequested()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
