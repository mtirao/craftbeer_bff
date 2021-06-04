defmodule CraftbeerBffWeb.RecipeController do
  use CraftbeerBffWeb, :controller

  require Logger

  def index(conn, _params) do
    url = "http://localhost:3000/craftbeer/recipes"


    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        json = Jason.decode!(body)
        render(conn, "recipe.json", %{recipes: json})

      {:ok, %{status_code: 404}} ->
        send_resp(conn, :not_found, "")

      {:error, %{reason: reason}} ->
        send_resp(conn, :internal_server_error, "")
    end


  end


end
