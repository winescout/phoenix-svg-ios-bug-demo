defmodule SvgEventsOnIosWeb.SvgLive.FormComponent do
  use SvgEventsOnIosWeb, :live_component

  alias SvgEventsOnIos.Demo

  @impl true
  def update(%{svg: svg} = assigns, socket) do
    changeset = Demo.change_svg(svg)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"svg" => svg_params}, socket) do
    changeset =
      socket.assigns.svg
      |> Demo.change_svg(svg_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"svg" => svg_params}, socket) do
    save_svg(socket, socket.assigns.action, svg_params)
  end

  defp save_svg(socket, :edit, svg_params) do
    case Demo.update_svg(socket.assigns.svg, svg_params) do
      {:ok, _svg} ->
        {:noreply,
         socket
         |> put_flash(:info, "Svg updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_svg(socket, :new, svg_params) do
    case Demo.create_svg(svg_params) do
      {:ok, _svg} ->
        {:noreply,
         socket
         |> put_flash(:info, "Svg created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
