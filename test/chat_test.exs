defmodule ChatTest do
  use ExUnit.Case
  doctest Chat

  require Chat.Server
  require Chat.Supervisor

  # test "supervisor" do
  #   Chat.Supervisor.start_link
  #   Chat.Server.add_message("foo")
  #   Chat.Server.add_message("bar")
  #   assert ["bar", "foo"] == Chat.Server.get_messages
  # end

  test "registry" do
    Chat.Supervisor.start_link
    Chat.Supervisor.start_room("room1")
    Chat.Supervisor.start_room("room2")

    Chat.Server.add_message("room1", "Hello")
    assert Chat.Server.get_messages("room1") ==  ["Hello"]


    Chat.Server.add_message("room2", "!")
    Chat.Server.add_message("room2", "World")
    assert Chat.Server.get_messages("room2") ==  ["World", "!"]

    :gproc.where({:n, :l, {:chat_room, "room1"}}) |> Process.exit(:kill)
    :timer.sleep(1000)
    Chat.Server.add_message("room1", "Hello")

    assert Chat.Server.get_messages("room1") ==  ["Hello"]
  end
end
