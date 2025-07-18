import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    @ObservedObject private var favoriteService = FavoriteService.shared
    private var favourites: [UserDataModel.Favourite] { favoriteService.favourites }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PokemonBrowseView()
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
            .tag(1)
            NavigationView{
                FavouritesView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favourites")
            }
            .tag(2)
            NavigationView {
                PokemonTypeListView()
            }
            .tabItem {
                Image(systemName: "square.grid.3x3.fill")
                Text("Types")
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

