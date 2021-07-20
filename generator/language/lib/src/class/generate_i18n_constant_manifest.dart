String generateConstantStringAndLocaleDartFile(
    String constants, String locales) {
  return '''
// DO NOT EDIT. 

import 'dart:ui';

class StringManifest {
${constants.replaceAll("\n", "").replaceAll(";", ";\n")}
}

class LocaleManifest {
${locales.replaceAll("\n", "").replaceAll(";", ";\n")}
}

// ignore_for_file: unnecessary_brace_in_string_interps
''';
}

String generateConstantString(String jsonKey, String jsonName) {
  return '''
  static const String $jsonKey = \"$jsonName\";
''';
}

String generateLocale(String locale) {
  String langCode = '';
  String countryCode = '';

  if (locale.contains('_')) {
    List<String> splits = locale.split('_');
    langCode = splits[0];
    countryCode = splits[1];
  } else {
    langCode = locale;
  }

  return '''
  static const Locale $langCode = Locale("$langCode", "$countryCode");
  ''';
}
