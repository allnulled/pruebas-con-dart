print_tree_files() {
  local dir="$1"
  local last_file=""
  for f in "$dir"/*; do
    [ ! -e "$f" ] && continue  # por si no hay nada
    [ "$f" = "./tree.txt" ] && continue
    [ "$f" = "./print.sh" ] && continue
    last_file="$(basename "$f")"
    # Omitir ficheros
    if [ -d "$f" ]; then
      print_tree_files "$f"
    elif [ -f "$f" ]; then
      case $last_file in main.dart|BojFramework.dart|BojCommandLineInterface.dart)
          ;;  # Si coincide, deja que continue con el resto del código
        *)
          continue  # Ignora todo lo que no coincida
          ;;
      esac
      echo ""
      echo "===== $f ====="
      cat "$f"
      echo
    fi
  done
}

rm tree.txt
print_tree_files . > tree.txt