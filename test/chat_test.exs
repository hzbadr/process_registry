defmodule ChatTest do
  use ExUnit.Case
  doctest Chat

  require Chat.Registry
  require Chat.Server
  require Chat.Supervisor

  # test "supervisor" do
  #   Chat.Supervisor.start_link
  #   Chat.Server.add_message("foo")
  #   Chat.Server.add_message("bar")
  #   assert ["bar", "foo"] == Chat.Server.get_messages
  # end

  test "registry" do
    Chat.Registry.start_link
    Chat.Supervisor.start_link
    Chat.Supervisor.start_room("room1")
    Chat.Supervisor.start_room("room2")

    Chat.Server.add_message("room1", "Hello")
    assert Chat.Server.get_messages("room1") ==  ["Hello"]

    Chat.Registry.whereis_name({:chat_room, "room1"}) |> Process.exit(:kill)

    Chat.Server.add_message("room2", "!")
    Chat.Server.add_message("room2", "World")
    assert Chat.Server.get_messages("room2") ==  ["World", "!"]

    Chat.Registry.unregister_name({:chat_room, "room2"})
    assert Chat.Registry.whereis_name("room2") == :undefined

    IO.inspect Chat.Registry.get_rooms

    assert Chat.Registry.whereis_name({:chat_room, "room1"})

    Chat.Server.add_message("room1", "Hello")
    assert Chat.Server.get_messages("room1") ==  ["Hello"]
  end
end
