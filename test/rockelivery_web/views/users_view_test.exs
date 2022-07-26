defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "xpto1234"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "xpto1234",
             user: %Rockelivery.User{
               address: "Rua das Bananeiras",
               age: 24,
               cep: "99999999",
               cpf: "12345678910",
               email: "leonardo@email.com",
               id: "47d5430a-9569-40d7-9a33-222aaedb8e29",
               inserted_at: nil,
               name: "Leonardo",
               password: "12345678",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
