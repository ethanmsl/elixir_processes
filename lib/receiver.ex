defmodule Receiver do
  
  def revr_local() do
    receive do
      msg -> 
        reversed = msg |> String.reverse
        IO.puts("Rev'd input: #{reversed}")
        revr_local()
    end
  end

  def revr_return() do
    receive do
      {from_pid, msg} -> 
        reversed = msg |> String.reverse
        send(from_pid, reversed)
        revr_return()
    end
  end
end
