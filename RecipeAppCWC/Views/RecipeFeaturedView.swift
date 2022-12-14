//
//  RecipeFeaturedView.swift
//  RecipeAppCWC
//
//  Created by Rohit Singh on 2022-12-13.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    // Reference RecipeModel instance.
    @EnvironmentObject var model: RecipeModel
    // For recipe card button link to recipes.
    @State var isDetailViewShowing = false
    // To track selected tab in TabView.
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        // Put featured recipes in array.
        let featuredRecipes = model.recipes.filter({ $0.featured })
        
        VStack(alignment: .leading, spacing: 0.0) {
            
            Text("Featured Recipes")
                .fontWeight(.bold)
                .padding(.leading, 25.0)
                .font(Font.custom("Avenir Heavy", size: 26.0))
            
            GeometryReader { geo in
                
                TabView(selection: $tabSelectionIndex) {
                    // Loop through each recipe.
                    ForEach(0..<featuredRecipes.count) { index in
                        
                        // Recipe card button.
                        Button {
                            // Show recipe detail view sheet.
                            self.isDetailViewShowing = true
                            
                        } label: {
                            // Featured recipe card.
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 0.0) {
                                    // Featured recipe image.
                                    Image(featuredRecipes[index].image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    
                                    // Featured recipe name.
                                    Text(featuredRecipes[index].name)
                                        .padding(.all, 5.0)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .font(Font.custom("Avenir Heavy", size: 18.0))
                        .tag(index)
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - (1/8 * (geo.size.width)), height: geo.size.height - (1/8 * geo.size.height), alignment: .center)
                        .cornerRadius(10.0)
                        .padding(.bottom, 20.0)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.3), radius: 10, x: -2, y: 2)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 10.0) {
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size: 18.0))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size: 16.0))
                Text("Highlights:")
                    .font(Font.custom("Avenir Heavy", size: 18.0))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading, .bottom], 25.0)
        }
        .sheet(isPresented: $isDetailViewShowing) {
            // Show recipe detail view.
            RecipeDetailView(recipe: featuredRecipes[tabSelectionIndex])
        }
        .padding(.top, 20.0)
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
