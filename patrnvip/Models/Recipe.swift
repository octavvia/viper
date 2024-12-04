import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    var title: String
    var ingridients: String
    var instructions: String
    
    init(id: UUID = UUID(), title: String, ingridients: String, instructions: String) {
        self.id = id
        self.title = title
        self.ingridients = ingridients
        self.instructions = instructions
    }
}
