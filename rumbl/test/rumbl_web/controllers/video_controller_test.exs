defmodule RumblWeb.VideoControllerTest do
  use RumblWeb.ConnCase, async: true

  test "requires user auth in all actions", %{conn: conn} do
    Enum.each(
      [
        get(conn, Routes.video_path(conn, :new)),
        get(conn, Routes.video_path(conn, :index)),
        get(conn, Routes.video_path(conn, :show, "123")),
        get(conn, Routes.video_path(conn, :edit, "123")),
        get(conn, Routes.video_path(conn, :update, "123", %{})),
        get(conn, Routes.video_path(conn, :create, %{})),
        get(conn, Routes.video_path(conn, :delete, "123"))
      ],
      fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end
    )
  end
end
