defmodule SvgEventsOnIosWeb.SvgLiveTest do
  use SvgEventsOnIosWeb.ConnCase

  import Phoenix.LiveViewTest

  alias SvgEventsOnIos.Demo

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:svg) do
    {:ok, svg} = Demo.create_svg(@create_attrs)
    svg
  end

  defp create_svg(_) do
    svg = fixture(:svg)
    %{svg: svg}
  end

  describe "Index" do
    setup [:create_svg]

    test "lists all svgs", %{conn: conn, svg: svg} do
      {:ok, _index_live, html} = live(conn, Routes.svg_index_path(conn, :index))

      assert html =~ "Listing Svgs"
    end

    test "saves new svg", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.svg_index_path(conn, :index))

      assert index_live |> element("a", "New Svg") |> render_click() =~
               "New Svg"

      assert_patch(index_live, Routes.svg_index_path(conn, :new))

      assert index_live
             |> form("#svg-form", svg: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#svg-form", svg: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.svg_index_path(conn, :index))

      assert html =~ "Svg created successfully"
    end

    test "updates svg in listing", %{conn: conn, svg: svg} do
      {:ok, index_live, _html} = live(conn, Routes.svg_index_path(conn, :index))

      assert index_live |> element("#svg-#{svg.id} a", "Edit") |> render_click() =~
               "Edit Svg"

      assert_patch(index_live, Routes.svg_index_path(conn, :edit, svg))

      assert index_live
             |> form("#svg-form", svg: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#svg-form", svg: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.svg_index_path(conn, :index))

      assert html =~ "Svg updated successfully"
    end

    test "deletes svg in listing", %{conn: conn, svg: svg} do
      {:ok, index_live, _html} = live(conn, Routes.svg_index_path(conn, :index))

      assert index_live |> element("#svg-#{svg.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#svg-#{svg.id}")
    end
  end

  describe "Show" do
    setup [:create_svg]

    test "displays svg", %{conn: conn, svg: svg} do
      {:ok, _show_live, html} = live(conn, Routes.svg_show_path(conn, :show, svg))

      assert html =~ "Show Svg"
    end

    test "updates svg within modal", %{conn: conn, svg: svg} do
      {:ok, show_live, _html} = live(conn, Routes.svg_show_path(conn, :show, svg))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Svg"

      assert_patch(show_live, Routes.svg_show_path(conn, :edit, svg))

      assert show_live
             |> form("#svg-form", svg: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#svg-form", svg: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.svg_show_path(conn, :show, svg))

      assert html =~ "Svg updated successfully"
    end
  end
end
