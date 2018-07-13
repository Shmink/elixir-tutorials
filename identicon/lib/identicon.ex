defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end
  
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    gird =
      Enum.filter grid, fn({code, _index}) ->
        rem(code, 2) == 0
      end
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid
      = hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    # We just keep adding to an object/struct with elixir
    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _third] = row

    # [145, 46, 200, 46, 145]
    row ++ [second, first]
  end

  # You can pattern match IN the parameters of a function!ß
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{ image | color: {r, g, b} }
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
