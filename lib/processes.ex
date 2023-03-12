defmodule Processes do
  @moduledoc """
  just some play code to experiment with processes
  (re: chapter 8 of the Elixir for Programmers 2 Coding Gnome course)
  """

  @doc """
  test to make sure module is working
  """
  def test_func() do
    IO.puts "Hi there, I'm working!"
  end

####################

  @doc """
  receive messages and don't shut down
  from `iex` call with:
      `pid = spawn Processes, :receive_messages, []`
  (simply calling it causes iex to seem to hang)
  (assignign output tpu "pid" is for convenience, to 
  make sending to it later easier)
  """
  def receive_messages() do
    receive do
      {:ok, msg} -> IO.puts "Success, received: #{msg}"
      {:error, msg} -> IO.puts "Uh-oh, received: #{msg}"
    end
    receive_messages()
  end

  @doc """
  receive messages and don't shut down
  from `iex` call with:
      `pid = spawn Processes, :receive_messages, []`
  (simply calling it causes iex to seem to hang)
  (assignign output tpu "pid" is for convenience, to 
  make sending to it later easier)
  """
  def receive_messages_and_input(func_input) do
    receive do
      msg -> IO.puts "#{func_input}: #{msg}"
    end
    receive_messages()
  end

####################

  @doc"""
  send message to pid
  takes boolean-ish whcih is translated to :ok/error
  NOTE: use iex> `pid = v(?)` to get pid identifier to route give to this function 

  Note: build in `send/2`
  """
  def send_b(pid, to_send, _is_okay = true) do
    send pid ,{:ok, to_send}
  end

  def send_b(pid, to_send, _is_okay) do
    send pid, {:error, to_send}
  end

####################

  def counting_messages() do
    counting_messages(0)
  end

  def counting_messages(n) do
    receive do
      :quit -> 
        IO.puts "(#{n}): Quitting"
      {:add, increment} -> 
        IO.puts "(#{n})~~>(#{n+increment})"
         counting_messages(n+increment)
      msg -> 
        IO.puts "(#{n}): #{msg}" 
        counting_messages(n+1)
    end
  end

end
