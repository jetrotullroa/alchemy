defmodule Practice.Traveller do
  def travel(r, zipcode) do
    # Your code goes here

    case is_binary(r) do
      true ->
        address_list = split(r, :comma)
        matched_address = Enum.filter(address_list, &(get_address(&1, :zipcode) == zipcode))

        cond do
          length(matched_address) == 1 -> matched_address |> format_address(zipcode, :single)
          length(matched_address) > 1 -> matched_address |> format_address(zipcode, :multi)
          true -> "#{zipcode}:/"
        end

      false ->
        "#{zipcode}:/"
    end
  end

  defp format_address(address, zipcode, :single) do
    street_address =
      address
      |> List.to_string()
      |> get_address(:street)

    house_number =
      address
      |> List.to_string()
      |> get_address(:number)

    "#{zipcode}:#{street_address}/#{house_number}"
  end

  defp format_address(addresses, zipcode, :multi) do
    house_numbers =
      addresses
      |> Enum.map(&get_address(&1, :number))
      |> Enum.join(",")

    street_addresses =
      addresses
      |> Enum.map(&get_address(&1, :street))
      |> Enum.join(",")

    "#{zipcode}:#{street_addresses}/#{house_numbers}"
  end

  defp get_address(address, :zipcode),
    do: split(address, :space) |> Enum.take(-2) |> Enum.join(" ")

  defp get_address(address, :street),
    do: split(address, :space) |> Enum.drop(1) |> Enum.drop(-2) |> Enum.join(" ")

  defp get_address(address, :number), do: split(address, :space) |> List.first()

  # HELPERS

  defp split(str, :comma), do: String.split(str, ",", trim: true)
  defp split(str, :space), do: String.split(str, " ", trim: true)
end
