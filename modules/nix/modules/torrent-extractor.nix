# TODO fix this
{ pkgs, ... }:

let
  torrentExtractor = pkgs.writeScriptBin "torrent-extractor" ''
    shopt -s nullglob

    download_dir="$1"
    extract() {
        case "$1" in
            *.rar)
                echo "Extracting rar: $1"
                unrar x "$1" "$download_dir/"
                ;;
            *.zip)
                echo "Extracting zip: $1"
                unzip -d "$download_dir/" "$1"
                ;;
            *)
                echo "No extraction rule for: $1"
                ;;
        esac
    }

    for i in "$download_dir"/*.{rar,zip}
    do
      if [ -e "$i" ]; then  # Check if file exists
        echo "Processing file: $i"
        extract "$i"
      fi
    done
  '';
in
{
  environment.systemPackages = [
    pkgs.unrar
    pkgs.unzip

    torrentExtractor
  ];
}
