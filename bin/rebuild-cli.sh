SCRIPT_DIR="$(dirname "$0")"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PARENT_DIR"
rm -rf .dart_tool
dart pub global deactivate fluttagenda
dart pub cache gc
dart build cli
dart pub global activate --source path . --overwrite
