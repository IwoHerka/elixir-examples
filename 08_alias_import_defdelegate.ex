# -- Alias --
# The `alias` directive is used to create shortcuts for module names.
# This is particularly useful for long module names, allowing you to refer to them with a shorter name.

defmodule MyApp do
  alias MyApp.Utilities.Math, as: MathUtils

  def calculate do
    MathUtils.add(1, 2)
  end
end

# Without `as`, the alias defaults to the last part of the module name:
alias MyApp.Utilities.Math

# Now you can use `Math` instead of `MyApp.Utilities.Math`.

# -- Import --
# The `import` directive allows you to bring functions and macros from other modules into the current scope.
# This means you can call them without the module prefix.

defmodule MyApp do
  import Enum, only: [map: 2, reduce: 3]

  def transform_list(list) do
    list
    |> map(&(&1 * 2))
    |> reduce(0, &(&1 + &2))
  end
end

# You can import all functions and macros from a module:
import Enum

# Or specify which functions/macros to import:
import Enum, only: [map: 2, reduce: 3]

# You can also exclude specific functions/macros:
import Enum, except: [map: 2]


# -- defdelegate --
# The `defdelegate` directive is used to forward function calls from one module to another.
# This is useful for creating a public API that delegates to private or internal modules.

defmodule MyApp do
  defdelegate add(a, b), to: MyApp.Utilities.Math
end


# This creates a function `add/2` in `MyApp` that delegates to `MyApp.Utilities.Math.add/2`.

# You can also specify a different function name in the target module:
defdelegate add(a, b), to: MyApp.Utilities.Math, as: :sum

# This delegates `add/2` to `sum/2` in `MyApp.Utilities.Math`.
