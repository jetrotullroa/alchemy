defmodule Phxz.Rocketry do

  def escape_velocity(:earth) do
    %{mass: 5.972e24, radius: 6.371e6}
    |> escape_velocity
  end

  def escape_velocity(planet) do is_map(planet)
    planet
    |> calculate_escape
    |> Converter.convert_to_km
    |> Converter.rounded_to_the_nearest_tenth
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do
    newton_constant = 6.67e-11
    2 * newton_constant * mass / radius
    |> :math.sqrt
  end

end
