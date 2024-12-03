# -- Fire & forget concurrency --
# The fire-and-forget concurrency pattern is a simple way to handle tasks that
# are not critical to the main flow of execution. These tasks can be spawned
# independently and their results are not awaited.

# We can offload simple work to other processes:

do_work = fn ->
  Process.sleep(2000)
  IO.puts("I'm finished")
end
# => fn

spawn(do_work)
# => #PID<0.128.0>

1..100 |> Enum.map(fn _ -> spawn(do_work) end)
# => [#PID<0.129.0>, #PID<0.130.0>, #PID<0.131.0>, ...]

# I'm finished
# I'm finished
# I'm finished
# ...

# We can also send messages back to main process:

Kernel.send(self(), {:some_some})
# => {:some_some}

receive do
  m -> m
end
# => {:some_some}


caller = self()
# => #PID<0.41.0>


1..100
|> Enum.map(fn _ ->
  spawn(fn ->
    do_work.()
    send(caller, :im_done)
  end)
end)
# => [#PID<0.132.0>, #PID<0.133.0>, #PID<0.134.0>, ...]

1..100
|> Enum.map(fn _ ->
  receive do
    m -> m
  end
end)
# => [:im_done, :im_done, :im_done, ...]

# We can also use the Task module to run tasks asynchronously:

t = Task.async(do_work)
# => #PID<0.135.0>

Task.await(t)
# => "I'm finished"


# -- Stateful server --
# Goal: Create a process which:
# - is able to accept initial arguments and access them when handling messages
# - is able to keep internal state and update it from one message to another
