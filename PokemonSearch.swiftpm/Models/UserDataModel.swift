

import Foundation

struct UserDataModel: Codable {
    struct Favourite: Codable, Equatable {
        var name: String
        var image: String
        
        init(_ name: String, _ image: String) {
            self.name = name
            self.image = image
        }
    }
    
    var favourites: Array<Favourite>
    
    init(_ favourites: Array<Favourite>) {
        self.favourites = favourites
    }
}
