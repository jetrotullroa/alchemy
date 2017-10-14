defmodule Phxz.Rocketry do

  import Converter
  import Calcs

  @moon %{mass: 7.35e22, radius: 1.738e6}
  @mars %{mass: 6.39e23, radius: 3.4e6}
  @earth %{mass: 5.972e24, radius: 6.371e6}
  @newton_constant 6.67e-11

  def escape_velocity(planet) when is_atom(planet) do
    case planet do
      :earth -> @earth
      :mars -> @mars
      :moon -> @moon
    end |> escape_velocity
  end

  def escape_velocity(planet) do is_map(planet)
    planet
    |> calculate_escape
    |> convert_to_km
    |> rounded_to_the_nearest_tenth
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do

    2 * @newton_constant * mass / radius
    |> square_root
  end

end
