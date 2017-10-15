defmodule Phxz.Rocketry do

  import Converter
  import Calcs
  import Phxz.Laws
  import Planets

  def escape_velocity(:earth) when is_atom(:earth), do: escape_velocity(earth)
  def escape_velocity(:mars) when is_atom(:mars), do: escape_velocity(mars)
  def escape_velocity(:moon) when is_atom(:moon), do: escape_velocity(moon)

  def escape_velocity(planet) do is_map(planet)
    planet
    |> calculate_escape
    |> convert_to_km
    |> rounded_to_the_nearest_tenth
  end

  def orbital_term(height) do
    4 * pie_squared * orbital_radius(height) / newton_gravitational_constant * earth.mass
    |> square_root
    |> seconds_to_hours
  end

  def orbital_height(hrs) do
    newton_gravitational_constant * earth.mass * ( hrs |> squared) / 4 * pie_squared
    |> cube_root
  end

  def orbital_acceleration(height) do
    (orbital_speed(height) |> squared ) / orbital_radius(height)
  end

  def orbital_speed(height) do
    newton_gravitational_constant * earth.mass / orbital_radius(height)
    |> square_root
  end

  defp orbital_radius(height) do
    earth.radius + (height |> convert_to_m)
  end

  defp calculate_escape(%{mass: mass, radius: radius}) do

    2 * newton_gravitational_constant * mass / radius
    |> square_root
  end

end
