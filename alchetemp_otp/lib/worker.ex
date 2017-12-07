defmodule AlchetempOtp.Worker do
  use GenServer

  # CLIENT
  def start_link(opts \\ []) do
    GenServer.start(__MODULE__, :ok, opts)
  end

  def get_temperature(pid, location) do
    GenServer.call(pid, {:location, location})
  end


  # SERVER
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:location, location}, _from, state) do
    case temperature_of(location) do
      {:ok, temp} ->
        new_state = update_state(state, location)
        {:reply, "#{temp} C", state}
      _error ->
        {:reply, :error, state}
    end
  end

  # CALLBACK HELPERS


  defp temperature_of(location) do
    url_for(location) |> HTTPoison.get |> parse_response
  end

  defp url_for(location) do
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&APPID=#{apikey}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp update_state(old_state, location) do
    case Map.has_key?(old_state, location) do
      true ->
        Map.update!(old_state, location, &(&1 + 1))
      false ->
        Map.put_new(old_state, location, 1)
    end
  end

  defp apikey do
    "3ce510c72422b3ca0b6273e052aca96d"
  end
end
