{ pkgs }:
pkgs.writeShellScriptBin "whatsong" ''
  song_info=$(playerctl metadata --format '{{title}} 󰝚  {{artist}}')
  echo "$song_info"
''
