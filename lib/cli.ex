defmodule Modulecopy.CLI do
  @moduledoc """
  modulecopy is best used as command line utility:
  ./modulecopy old_dir new_dir old_name new_name
  """

  # alias Modulecopy.Lp

  def main([help_opt]) when help_opt == "-h" or help_opt == "--help" do
    IO.puts(@moduledoc)
  end

  def main(argv) do
    {opts, args, _invalid} =
      argv
      |> parse_args

    opts = fix_opts(opts)

    # |> IO.inspect(label: "mwuits-debug 2020-12-10_13:08 ")

    [from_dir, to_dir, from_snake, to_snake] = args

    Modulecopy.generate_all(from_dir, to_dir, from_snake, to_snake)
    |> Enum.join(";\n")
    |> IO.puts()
  end

  def fix_opts(opts) do
    opts =
      if opts[:grep] do
        Regex.compile(opts[:grep])
        |> case do
          {:ok, regex} ->
            Keyword.put(opts, :search_regex, regex)

          _ ->
            opts
        end
      else
        opts
      end

    if opts[:timegrep] do
      Regex.compile(opts[:timegrep])
      |> case do
        {:ok, regex} ->
          Keyword.put(opts, :timesearch_regex, regex)

        _ ->
          opts
      end
    else
      opts
    end
  end

  defp parse_args(argv) do
    switches = [
      info: :boolean,
      debug: :boolean,
      warn: :boolean,
      error: :boolean,
      match: :string,
      timematch: :string
    ]

    OptionParser.parse(argv, switches: switches)

    # case parse do
    #   {[ {switch, true } ], [player_move], _ } ->
    #     {to_string(switch), player_move}
    #   {_, [player_move], _} ->
    #     {get_comp_move, player_move}
    # end
  end
end
