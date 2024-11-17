# -- IO Module --
# The IO module provides functions for standard input and output operations.

# Printing to the console:
IO.puts("Hello, World!")  # Prints a string followed by a newline
IO.write("Hello, ")        # Prints a string without a newline
IO.write("World!")         # Continues on the same line

# Reading from standard input:
name = IO.gets("What is your name? ")  # Prompts the user for input
IO.puts("Hello, #{String.trim(name)}!")  # Greets the user


# -- Working with files --
# Elixir provides functions for reading from and writing to files using the File
# module.

# Writing to a file:
File.write("example.txt", "Hello, File!")  # Creates or overwrites the file with the given content

# Appending to a file:
File.write("example.txt", "\nAppending this line.", [:append])  # Appends content to the file

# Reading from a file:
{:ok, content} = File.read("example.txt")  # Reads the content of the file
IO.puts("File content:\n#{content}")  # Prints the content

# Reading a file line by line:
"example.txt"
|> File.stream!()  # Creates a stream to read the file line by line
|> Enum.each(&IO.puts/1)  # Prints each line

# -- File information --
# You can also retrieve information about files using the File module.

# Getting file information:
{:ok, info} = File.stat("example.txt")  # Retrieves file statistics
IO.inspect(info)  # Prints file information

# Checking if a file exists:
if File.exists?("example.txt") do
  IO.puts("The file exists.")
else
  IO.puts("The file does not exist.")
end


# -- Deleting a file --
# You can delete a file using the File module.

# Deleting a file:
File.rm("example.txt")  # Deletes the specified file


# -- Working with directories --
# Elixir also provides functions for working with directories.

# Creating a directory:
File.mkdir("new_directory")  # Creates a new directory

# Listing files in a directory:
File.ls("new_directory")  # Lists files in the specified directory

# Removing a directory:
File.rmdir("new_directory")  # Removes the specified directory (must be empty)
