defmodule Modulecopy do
  # def generate_rsync_commmand(from_dir, to_dir, from_name, to_name) do
  #   ""
  # end

  # def generate_rpl_commmand() do
  #   ""
  # end

  def generate_all(from_dir, to_dir, from_snake, to_snake)
      when is_binary(from_dir) and is_binary(to_dir) and is_binary(from_snake) and
             is_binary(to_snake) and byte_size(to_dir) > 4 do
    from_path = Path.join(from_dir, "/")
    to_path = Path.join(to_dir, "/")

    if File.dir?(from_path) do
      [
        "mkdir -p #{to_path}",
        rsync_cmd(from_path, to_path),
        "autoload zmv",
        "zmv '#{to_path}/(**/)(*#{from_snake}*)(#qD)' '#{to_path}/$1${2//#{from_snake}/#{to_snake}}'",
        rpl_cmds(to_path, from_snake, to_snake)
      ]
      |> List.flatten()
    else
      {:error, "path #{from_path} not found"}
    end
  end

  def rsync_cmd(from_path, to_path) do
    "rsync -av --delete --exclude '_bit*' #{from_path}/ #{to_path}/"
  end

  def rpl_cmds(to_path, from_snake, to_snake) do
    [
      "rpl -R #{from_snake} #{to_snake} #{to_path}/",
      "rpl -R #{from_snake |> Macro.camelize()} #{to_snake |> Macro.camelize()} #{to_path}/"
    ]
  end
end
