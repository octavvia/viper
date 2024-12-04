import Foundation

protocol RecipePresenterProtocol: AnyObject {
    func didFetchRecipes(_ recipes: [Recipe])
    func didAddRecipe()
    func didDeleteRecipe()
}


protocol RecipeViewProtocol: AnyObject, ObservableObject {
    func displayRecipes(_ recipes: [Recipe])
}

class RecipePresenter: RecipePresenterProtocol {
    
    weak var view: (any RecipeViewProtocol)?
    var interactor: RecipeInteractorProtocol?
    
    init(view: any RecipeViewProtocol) {
        self.view = view
    }
    
    func fetchRecipes() {
        interactor?.fetchRecipe()
    }
    
    func addRecipe(title: String, ingridients: String, instructions: String) {
        interactor?.addRecipe(title: title, ingridients: ingridients, instructions: instructions)
    }
    
    func deleteRecipe(id: UUID) {
        interactor?.deleteRecipe(id: id)
    }
    
    func didFetchRecipes(_ recipes: [Recipe]) {
        view?.displayRecipes(recipes)
    }
    
    func didAddRecipe() {
        interactor?.fetchRecipe()
    }
    
    func didDeleteRecipe() {
        interactor?.fetchRecipe()
    }

}
