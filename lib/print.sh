print_tree_files() {
  local dir="$1"
  local f=""

  for f in "$dir"/*; do
    [ ! -e "$f" ] && continue
    [ "$f" = "./tree.txt" ] && continue
    [ "$f" = "./print.sh" ] && continue

    if [ -d "$f" ]; then
      print_tree_files "$f"
    elif [ -f "$f" ]; then
      case "$f" in
        ./main.dart|./usables/*.dart|./usables/commands/*.dart)
          ;;
        *)
          continue
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