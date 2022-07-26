# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{User, Item, Order, Repo}

user = %User{
  name: "Leonardo",
  address: "Rua dos foii agora, 1234",
  age: 24,
  cep: "12345678",
  cpf: "12345678910",
  email: "leonardo@email.com",
  password: "12345678"
}

%User{id: user_id} = Repo.insert!(user)

item1 = %Item{
  category: :food,
  description: "Banana frita",
  price: Decimal.new("15.50"),
  photo: "priv/photos/drink.jpg"
}

item2 = %Item{
  category: :food,
  description: "Banana cozida",
  price: Decimal.new("10.50"),
  photo: "priv/photos/drink.jpg"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Rua dos bobos, 1234",
  comments: "Sem canela",
  payment_method: :money
}

Repo.insert!(order)
