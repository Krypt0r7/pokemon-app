import Foundation

class FavoriteService: ObservableObject {
    static let shared = FavoriteService()
    
    // UserDefaults key for storing favorites
    private let favoritesKey = "pokemon_favorites"
    
    @Published var favourites: [UserDataModel.Favourite] = []

    init() {
        loadFavorites()
    }
    
    // MARK: - Public Methods
    
    func pokemonIsFavourite(_ name: String) -> Bool {
        return favourites.contains(where: { $0.name.lowercased() == name.lowercased() })
    }
    
    func toggleFavourite(_ favourite: UserDataModel.Favourite) {
        if let index = favourites.firstIndex(where: { $0.name.lowercased() == favourite.name.lowercased() }) {
            // Remove from favorites
            favourites.remove(at: index)
        } else {
            // Add to favorites
            favourites.append(favourite)
        }
        saveFavorites()
    }
    
    func addFavorite(_ favourite: UserDataModel.Favourite) {
        // Check if already exists to avoid duplicates
        if !pokemonIsFavourite(favourite.name) {
            favourites.append(favourite)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ name: String) {
        if let index = favourites.firstIndex(where: { $0.name.lowercased() == name.lowercased() }) {
            favourites.remove(at: index)
            saveFavorites()
        }
    }
    
    func clearAllFavorites() {
        favourites.removeAll()
        saveFavorites()
    }
    
    // MARK: - Private Methods
    
    private func saveFavorites() {
        do {
            let data = try JSONEncoder().encode(favourites)
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("✅ Favorites saved successfully. Count: \(favourites.count)")
        } catch {
            print("❌ Error saving favorites: \(error.localizedDescription)")
        }
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            print("ℹ️ No saved favorites found. Starting with empty list.")
            favourites = []
            return
        }
        
        do {
            favourites = try JSONDecoder().decode([UserDataModel.Favourite].self, from: data)
            print("✅ Favorites loaded successfully. Count: \(favourites.count)")
        } catch {
            print("❌ Error loading favorites: \(error.localizedDescription)")
            favourites = []
        }
    }
}

