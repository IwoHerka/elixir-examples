# -- Processes in Elixir --
# Elixir is built on top of the Erlang VM, which is designed for building
# concurrent, distributed, and fault-tolerant systems. Processes in Elixir are
# lightweight and isolated, allowing you to run many of them concurrently.

# Elixir's processes should not be confused with operating system processes.
# Processes in Elixir are extremely lightweight in terms of memory and CPU (even
# compared to threads as used in many other programming languages). Because of
# this, it is not uncommon to have tens or even hundreds of thousands of processes
# running simultaneously.


# -- Spawning --
# You can create a new process using the `spawn` function. It takes a function
# as an argument and runs it in a new process.

spawn(fn -> IO.puts("Hello from a new process!") end)
# => #PID<0.123.0>
# Hello from a new process!

# spawn/1 takes a function which it will execute in a new process.
# spawn/1 returns a PID (process identifier) which is a unique identifier for
# the newly created process. The spawned process will execute the given function
# and exit after the function is done:

pid = spawn(fn -> 1 + 2 end)
# => #PID<0.123.0>

Process.alive?(pid)
# => false


# -- PIDs --
# Each process has a unique identifier called a PID. You can obtain the PID of
# the current process using `self/0`.

self()
# => #PID<0.123.0>

Process.alive?(self())
# => true


# -- Sending and receiving messages --
# Processes communicate by sending and receiving messages. You can send a
# message to a process using the `send` function and receive messages using the
# `receive` block.

send(self(), {:hello, "world"})
# => {:hello, "world"}

receive do
  {:hello, msg} -> msg
  {:world, _msg} -> "won't match"
end
# => "world"


# When a message is sent to a process, the message is stored in the process
# mailbox. The receive/1 block goes through the current process mailbox searching
# for a message that matches any of the given patterns. receive/1 supports guards
# and many clauses, such as case/2.

# The process that sends the message does not block on send/2, it puts the message
# in the recipient's mailbox and continues. In particular, a process can send
# messages to itself.

# If there is no message in the mailbox matching any of the patterns, the current
# process will wait until a matching message arrives. A timeout can also be
# specified:

receive do
  {:hello, msg}  -> msg
after
  1_000 -> "nothing after 1s"
end
# => "nothing after 1s"

# Putting it all together:
parent = self()
# => #PID<0.41.0>

spawn(fn -> send(parent, {:hello, self()}) end)
# => #PID<0.48.0>

receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end
# => "Got hello from #PID<0.48.0>"


# In order to flush the mailbox of a process, you can use `flush/0`:

send(self(), :message)
# => :message

flush()
# => {:message, nil}

# It prints and removes the message from the mailbox.


# -- Linking --
# The majority of times we spawn processes in Elixir, we spawn them as linked
# processes. Before we show an example with spawn_link/1, let's see what happens
# when a process started with spawn/1 fails:

spawn(fn -> raise "Oops!" end)
# => #PID<0.123.0>
# [error] Process #PID<0.123.0> raised an exception
# ** (RuntimeError) Oops!

self()
# => #PID<0.41.0>

spawn_link(fn -> raise "Oops!" end)
# => #PID<0.124.0>
# ** (EXIT from #PID<0.41.0>) evaluator process exited with reason: an exception was raised:
#     ** (RuntimeError) oops
#         (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6

# Links can also be added by calling Process.link/1:

pid = spawn(fn ->
  Process.sleep(5000)
  raise "Oops!"
end)
# => #PID<0.125.0>

Process.link(pid)
# => true


# -- Monitoring --
# Monitoring is similar to linking, but it allows you to receive a message when
# a process exits without being affected by the exit.

pid = spawn(fn -> :timer.sleep(1000) end)
# => #PID<0.126.0>

ref =Process.monitor(pid)
# => #Reference<0.0.0.126>

receive do
  {:DOWN, ref, :process, _pid, reason} -> IO.puts("Process down with reason: #{reason}")
end
# => Process down with reason: :normal


# -- Tasks --
# The `Task` module provides convenience functions for spawning and managing
# short-lived task-oriented processes.

task = Task.async(fn -> 1 + 1 end)
# => #PID<0.127.0>

result = Task.await(task)
# => 2
