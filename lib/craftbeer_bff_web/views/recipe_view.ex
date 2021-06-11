defmodule CraftbeerBffWeb.RecipeView do
  use CraftbeerBffWeb, :view

  def render("recipe.json", %{recipes: recipes}) do
    recipes
  end


  def render("recipe_cooking.json", %{recipes: recipes}) do
    recipes
  end
end
