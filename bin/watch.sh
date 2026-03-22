source ~/.bashrc
nodemon -w boj.dart -w dist -e 'dart' -x './boj.dart ok one two three --flag --number 100 --text texto --text2 "texto con espacios" --array it1 it2 it3'