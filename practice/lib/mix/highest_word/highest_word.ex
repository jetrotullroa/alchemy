defmodule Practice.HighestWord do
  def high(str) do
    # your code here
    case str do
     "" -> ""
     _ ->
       str
       |> format_string_to_list
       |> lowercase_list_of_string
       |> get_value_of_each_word
       |> get_index_of_highest_value
       |> get_the_highest_value_string_via_index(str)
   end
  end

  # MAIN

  defp format_string_to_list(string) do
    string
    |> split(:string)
    |> Enum.map(&(atoz_only(&1)))
  end

  defp lowercase_list_of_string(list) do
    list
    |> Enum.map(&(to_lowercase(&1)))
  end

  defp get_value_of_each_word(word), do: word |> value(:list)

  def get_index_of_highest_value(list) do
    high_value = list
    |> Enum.max

    Enum.find_index list, &(&1 === high_value)
  end

  defp get_the_highest_value_string_via_index(index, string) do
    word = string
    |> split(:string)
    |> Enum.at(index)

    word |> atoz_only |> to_lowercase
  end

  # HELPERS

  defp split(value, :string), do: value |> String.split(" ", trim: true)
  defp split(value, :word), do: value |> String.split("", trim: true)

  defp to_lowercase(value), do: value |> String.downcase

  defp atoz_only(word), do: Regex.replace(~r/[^a-z ]/i, word, "")

  defp value(list, :list) do
    list
    |> Enum.map(&(value(&1, :word)))
  end

  defp value(letter, :letter) do
    <<code>> = letter

    ?a..code
    |> Enum.to_list
    |> List.to_string
    |> String.split("", trim: true)
    |> length
  end

  defp value(word, :word) do
    word_list = word
    |> split(:word)
    |> Enum.map(&(value(&1, :letter)))

    word_list |> Enum.sum
  end
end
