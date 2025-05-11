//
//
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("検索", systemImage: "magnifyingglass")
                }
            
            ContentView()
                .tabItem {
                    Label("アイテム", systemImage: "list.bullet")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
