defmodule CraftbeerBffWeb.RecipeView do
  use CraftbeerBffWeb, :view

  def render("recipe.json", %{recipes: recipes}) do
    recipes
  end
end
