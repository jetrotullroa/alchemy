defmodule Practice.Twodoz do
  def start do
    input =
      prompt_msg("Would you like to create a new .csv?(Y/N) \n")
      |> String.downcase()

    case input do
      "y" ->
        create_initial_todo() |> get_command()

      "n" ->
        load_csv()

      _ ->
        start()
    end
  end

  def capitalize_header(header) do
    header
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(" ")
  end

  def create_header(headers) do
    case prompt_msg("Add fields: ") do
      "" -> headers
      header -> create_header([header |> capitalize_header() | headers])
    end
  end

  def create_headers do
    IO.puts("""
    What Fields should each Todo have?

    Enter field names one by one and an empty line when you are done.

    """)

    create_header([])
  end

  def create_initial_todo do
    titles = create_headers()
    name = get_item_name(%{})
    fields = Enum.map(titles, &field_from_user(&1))
    IO.puts(~s(a New Todo "#{name}" added))

    %{name => Enum.into(fields, %{})}
  end

  def get_command(data) do
    message = """
    ==========================================================
    Type the first letter of the command you want to run:
    R)ead Todos      A)dd a Todo      D)elete a Todo
    S)ave a .csv     L)oad a .csv     Q)uit
    ==========================================================
    """

    command = prompt_msg(message) |> String.downcase()

    case command do
      "r" ->
        show_todos(data)

      "a" ->
        add_todo(data)

      "d" ->
        delete_todo(data)

      "s" ->
        save_csv(data)

      "l" ->
        load_csv()

      "q" ->
        "Goodbye"

      _ ->
        get_command(data)
    end
  end

  # APIs

  def add_todo(data) do
    todo = get_item_name(data)
    titles = get_fields(data)
    fields = Enum.map(titles, fn field -> field_from_user(field) end)
    new_todo = %{todo => Enum.into(fields, %{})}
    IO.puts(~s(Added new Todo "#{todo}" on the list))
    new_data = Map.merge(data, new_todo)

    get_command(new_data)
  end

  def delete_todo(data) do
    todo = prompt_msg("Which todo would you like to delete? \n")

    if Map.has_key?(data, todo) do
      IO.puts("ok")
      new_data = Map.drop(data, [todo])
      get_command(new_data)
    else
      IO.puts(~s(There is no Todo named "#{todo}"))
      show_todos(data, false)
      delete_todo(data)
    end
  end

  def field_from_user(name) do
    field = prompt_msg("#{name} :")

    case field do
      _ -> {name, field}
    end
  end

  def get_fields(data) do
    data[hd(Map.keys(data))] |> Map.keys()
  end

  def get_item_name(data) do
    todo = prompt_msg("Enter the name of the new todo: ")

    if Map.has_key?(data, todo) do
      IO.puts(~s(You already have a Todo named "#{todo}""))
      get_item_name(data)
    else
      todo
    end
  end

  def load_csv do
    prompt_msg("Name of .csv to load: ")
    |> read
    |> parse
    |> get_command
  end

  def prompt_msg(message), do: IO.gets(message) |> String.trim()

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\r|\n)})
    titles = tl(String.split(header, ","))
    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s(Could not open the "#{filename}"\n))
        IO.puts(~s("#{:file.format_error(reason)}"))
        start()
    end
  end

  def prepare_csv(data) do
    headers = ["Item" | get_fields(data)]
    items = Map.keys(data)
    body = Enum.map(items, fn item -> [item | Map.values(data[item])] end)
    rows_array = [headers | body]
    rows_strings = Enum.map(rows_array, &Enum.join(&1, ","))
    Enum.join(rows_strings, "\n")
  end

  def save_csv(data) do
    filename = prompt_msg("Name of the file: ")
    filedata = prepare_csv(data)

    case File.write(filename, filedata) do
      :ok ->
        IO.puts("Successfully created #{filename}")

      {:error, reason} ->
        IO.puts("Could not create #{filename} \n")
        IO.puts(~s("#{:file.format_error(reason)}"))
    end
  end

  def show_todos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following TODOS: \n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      get_command(data)
    end
  end
end
