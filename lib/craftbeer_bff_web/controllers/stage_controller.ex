defmodule CraftbeerBffWeb.StageController do
  use CraftbeerBffWeb, :controller

  require Logger

  def index(conn, %{"recipe_id" => recipe_id}) do
    url = "http://localhost:3000/craftbeer/recipe/#{recipe_id}/stages"


    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        json = Jason.decode!(body)

        render(conn, "stage.json", %{stages: json})

      {:ok, %{status_code: 404}} ->
        send_resp(conn, :not_found, "")

      {:error, %{reason: reason}} ->
        send_resp(conn, :internal_server_error, reason)
    end
  end


  def create(conn, %{"recipe_id" => recipe_id, "stage_id" => stage_id}) do

    url = "http://localhost:3000/craftbeer/recipe/cooking"

    body = Jason.encode!(%{
      recipe: String.to_integer(recipe_id),
      stage_id: String.to_integer(stage_id),
      type: 1,
      start_time: "2021-16-10 16:00:00",
      end_time: "2021-16-10 16:00:00",
      state: "start",
    })

    headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, body, headers, []) do
      {:ok, %{status_code: 201, body: body}} ->
        render(conn, "stage_cooking.json.json", %{recipes: body})

      {:ok, %{status_code: 404}} ->
        send_resp(conn, :not_found, "")

      {:ok, %{status_code: 400}} ->
        send_resp(conn, :bad_request, "")

      {:error, %{reason: reason}} ->
        send_resp(conn, :internal_server_error, reason)
    end


  end
end
