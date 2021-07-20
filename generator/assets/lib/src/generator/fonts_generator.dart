import 'package:assets/src/generator/generator.dart';
import 'package:assets/src/model/dart_class.dart';

DartClass? generateFontClass(List<String> fonts) {
  if (fonts.isEmpty) {
    return null;
  }
  final classString = StringBuffer("class FontManifest {\n");
  for (final font in fonts) {
    classString.writeln(
        "  static const String ${createVariableName(font)} = \"$font\";");
  }
  classString.writeln("}");
  return DartClass(code: classString.toString());
}
