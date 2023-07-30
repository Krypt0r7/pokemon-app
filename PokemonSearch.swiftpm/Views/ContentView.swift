import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView{
                NavigationLink(destination: SearchView()){
                    Text("Search")
                }
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
            NavigationView{
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(0)
            NavigationView {
                PokemonTypeListView()
            }
            .tabItem {
                Image(systemName: "square.grid.3x3.fill")
                Text("Types")
            }
            .tag(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

