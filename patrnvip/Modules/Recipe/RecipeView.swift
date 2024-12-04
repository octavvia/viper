import SwiftUI

class RecipeViewModel: RecipeViewProtocol {
    
    @Published var recipes: [Recipe] = []
    @Published var newRecipeTitle: String = ""
    @Published var newRecipeIngridients: String = ""
    @Published var newRecipeInstructions: String = ""
    
    var presenter: RecipePresenter?
    
    init() {
        self.presenter = RecipePresenter(view: self)
        presenter?.fetchRecipes()
    }
    
    func displayRecipes(_ recipes: [Recipe]) {
        DispatchQueue.main.async {
            self.recipes = recipes
        }
    }
    func addRecipe() {
        guard !newRecipeTitle.isEmpty,
              !newRecipeIngridients.isEmpty,
              !newRecipeInstructions.isEmpty
        else { return }
        presenter?.addRecipe(
            title: newRecipeTitle,
            ingridients: newRecipeIngridients,
            instructions: newRecipeInstructions)
        newRecipeTitle = ""
        newRecipeIngridients = ""
        newRecipeInstructions = ""
    }
    
    func deleteRecipe(id: UUID) {
        presenter?.deleteRecipe(id: id)
    }
    
}
 
struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(viewModel.recipes) { recipe in
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.headline)
                            Text("Ingredients: \(recipe.ingridients)")
                            Text("Instructions: \(recipe.instructions)")
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let recipe = viewModel.recipes[index]
                            viewModel.deleteRecipe(id: recipe.id)
                        
                        }
                    }
                }
                .navigationTitle("Recipes")
                VStack {
                    TextField("Title", text: $viewModel.newRecipeTitle)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    TextField("Ingredients", text: $viewModel.newRecipeIngridients)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    TextField("Instructions", text: $viewModel.newRecipeInstructions)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button(action: viewModel.addRecipe) {
                        Text("Add recipe")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }.padding()
                 }
            }
        }
    }
}

#Preview {
    RecipeRouter.createModule()
}
