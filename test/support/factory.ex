defmodule Rockelivery.Factory do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use RockeliveryWeb.ChannelCase, async: true`, although
  this option is not recommended for other databases.
  """
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "name" => "Leonardo",
      "email" => "leonardo@email.com",
      "cpf" => "12345678910",
      "age" => 24,
      "address" => "Rua das Bananeiras",
      "cep" => "99999999",
      "password" => "12345678"
    }
  end

  def user_factory do
    %User{
      id: "47d5430a-9569-40d7-9a33-222aaedb8e29",
      name: "Leonardo",
      email: "leonardo@email.com",
      cpf: "12345678910",
      age: 24,
      address: "Rua das Bananeiras",
      cep: "99999999",
      password: "12345678"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
