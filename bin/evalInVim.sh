if [ -z "$1" ]; then
  echo "usage: $0 servername expr"
  exit 1
fi

mvim --servername "$1" --remote-expr "$2"
