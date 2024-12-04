import Foundation

protocol RecipeInteractorProtocol: AnyObject {
    func  fetchRecipe()
    
    func addRecipe(title: String, ingridients: String, instructions: String)
    func deleteRecipe(id: UUID)
}



class RecipeInteractor: RecipeInteractorProtocol {
    private var recipes: [Recipe] = []
    
    weak var presenter: RecipePresenterProtocol?
    
    func fetchRecipe() {
        presenter?.didFetchRecipes(recipes)
    }
    
    func addRecipe(title: String, ingridients: String, instructions: String) {
        let newRecipe = Recipe(title: title, ingridients: ingridients, instructions: instructions)
        recipes.append(newRecipe)
        presenter?.didAddRecipe()
    }
    
    func deleteRecipe(id: UUID) {
        recipes.removeAll() { $0.id == id }
        presenter?.didDeleteRecipe()
    }
}
