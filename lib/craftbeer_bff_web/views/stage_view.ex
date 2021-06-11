defmodule CraftbeerBffWeb.StageView do
  use CraftbeerBffWeb, :view

  def render("stage.json", %{stages: stages}) do
    stages
  end


  def render("stage_cooking.json", %{stages: stages}) do
    stages
  end
end
