defmodule CraftbeerBffWeb.RecipeController do
  use CraftbeerBffWeb, :controller

  require Logger

  def index(conn, _params) do
    url = "http://localhost:3000/craftbeer/recipes"


    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        json = Jason.decode!(body)
        json_modified = Enum.map(json, &add_flag(&1, 5))
        render(conn, "recipe.json", %{recipes: json_modified})

      {:ok, %{status_code: 404}} ->
        send_resp(conn, :not_found, "")

      {:error, %{reason: reason}} ->
        send_resp(conn, :internal_server_error, reason)
    end
  end

  defp add_flag(recipe, value) do

    if Map.get(recipe, "id") == value do
      Map.put(recipe, "status", "processing")
    else
      recipe
    end



  end


end
