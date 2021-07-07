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

  def create(conn, %{"recipe_id" => recipe_id}) do
    IO.puts("Recipe id #{recipe_id}")

    url = "http://localhost:3000/craftbeer/recipe/cooking"


    body = Jason.encode!(%{
      recipe: String.to_integer(recipe_id),
      state: "new",
    })

    headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, body, headers, []) do
      {:ok, %{status_code: 201, body: body}} ->
        clean_up(recipe_id)
        render(conn, "recipe_cooking.json", %{recipes: body})

      {:ok, %{status_code: 404}} ->
        send_resp(conn, :not_found, "")

      {:ok, %{status_code: 400}} ->
        send_resp(conn, :bad_request, "")

      {:error, %{reason: reason}} ->
        send_resp(conn, :internal_server_error, reason)
    end

  end

  defp add_flag(recipe, value) do

    if Map.get(recipe, "id") == value do
      Map.put(recipe, "status", "processing")
    else
      Map.put(recipe, "status", "ready")
    end
  end

  defp clean_up(recipe_id) do
    url = "http://localhost:3000//craftbeer/stages/cooking/recipe/#{recipe_id}"



    case HTTPoison.delete(url) do
      {:ok, %{status_code: 204}} -> :ok

      {:ok, %{status_code: 404}} -> :not_found

      {:ok, %{status_code: 400}} -> :bad_request

      _ -> :internal_server_error
    end
  end

end
