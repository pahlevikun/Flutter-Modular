library core_18n;

import 'dart:io';

import 'package:language/src/class/generate_i18n_constant_manifest.dart';
import 'package:language/src/class/generate_i18n_copies_all.dart';
import 'package:language/src/class/generate_i18n_manifest.dart';
import 'package:language/src/utilities/extra_json_copies_utilities.dart';
import 'package:language/src/utilities/extra_json_file_utilities.dart';
import 'package:language/src/utilities/print_utilities.dart';
import 'package:path/path.dart' as path;

class I18nOption {
  String sourceDir;
  String templateLocale;
  String outputDir;

  @override
  String toString() {
    return 'I18nOption{sourceDir: $sourceDir, templateLocale: $templateLocale, outputDir: $outputDir}';
  }
}

/**
 * Task :
 * 1. Generate string_i18n_copies_all.dart
 * 2. Generate string_i18n_constant_manifest.dart
 * 3. Generate string_i18n_generated_manifest.dart
 */
void handleGenerateAllI18nFiles(I18nOption option) async {
  Directory current = Directory.current;

  var sourcePath = Directory(path.join(current.path, option.sourceDir));
  if (!await sourcePath.exists()) {
    printError('Source path does not exist');
    return;
  }

  List<FileSystemEntity> files =
      await dirContents(Directory(path.join(current.path, option.sourceDir)));
  Map<String, FileSystemEntity> validFilesMap = getValidStringFileMap(files);
  FileSystemEntity defaultTemplateLang =
      getDefaultTemplateLang(validFilesMap, option.templateLocale);
  if (null != defaultTemplateLang) {
    Map<String, Message> defaultJsonKeyMessageMap =
        await generateJsonKeyMessageMap(File(defaultTemplateLang.path));

    String defaultLang = path.basename(getLocale(defaultTemplateLang.path));

    _handleGenerateMessageAllDart(
        path.join(
            current.path, option.outputDir, 'string_i18n_copies_all.dart'),
        defaultLang,
        defaultJsonKeyMessageMap,
        validFilesMap);

    _handleGenerateConstantDartFile(
        path.join(current.path, option.outputDir,
            'string_i18n_constant_manifest.dart'),
        defaultLang,
        defaultJsonKeyMessageMap,
        validFilesMap);

    _handleGenerateI18nManifestDartFile(
        path.join(current.path, option.outputDir,
            'string_i18n_generated_manifest.dart'),
        defaultLang,
        defaultJsonKeyMessageMap,
        validFilesMap);

    printInfo('Finished to generate 3 files.');
  }
}

/**
 * Task :
 * 1. Generate all copies lookup class
 * 2. Generate copies lookup instance
 * 3. Generate deferredLibraries
 * 4. Generate exact copies based on locale
 * 5. Generate string_i18n_copies.dart
 */
void _handleGenerateMessageAllDart(
    String path,
    String defaultLang,
    Map<String, Message> defaultKeyMap,
    Map<String, FileSystemEntity> validFilesMap) async {
  File generatedFile = File(path);
  if (!generatedFile.existsSync()) {
    generatedFile.createSync(recursive: true);
  }

  StringBuffer createMessageLookupClassBuilder = StringBuffer();
  StringBuffer deferredLibrariesBuilder = StringBuffer();
  StringBuffer findExactBuilder = StringBuffer();

  for (MapEntry<String, FileSystemEntity> mapEntry in validFilesMap.entries) {
    String locale = mapEntry.key;
    FileSystemEntity fileEntity = mapEntry.value;

    Map<String, Message> jsonKeyMap;
    StringBuffer messageBuilder = StringBuffer();
    if (locale != defaultLang) {
      jsonKeyMap = await generateJsonKeyMessageMap(File(fileEntity.path));
    } else {
      jsonKeyMap = defaultKeyMap;
    }

    for (MapEntry<String, Message> jsonKeyEntry in jsonKeyMap.entries) {
      String jsonKey = jsonKeyEntry.key;
      Message message = jsonKeyEntry.value;

      switch (message.messageKey.type) {
        case MessageType.message:
          {
            if (hasArgsInMessage(message.message)) {
              messageBuilder.writeln(generateKeyWithValue(
                  jsonKey,
                  generateMessageFunction(
                      extraArgsFromMessage(message.message), message.message)));
            } else {
              messageBuilder.writeln(generateKeyWithValue(
                  jsonKey, generateSimpleMessage(message.message)));
            }
            break;
          }
        case MessageType.plural:
          {
            messageBuilder.writeln(generateKeyWithValue(
                jsonKey,
                generatePluralFunction(
                    extraArgsFromPlural(message.zero, message.one, message.two,
                        message.few, message.many, message.other),
                    message.zero,
                    message.one,
                    message.two,
                    message.few,
                    message.many,
                    message.other)));
            break;
          }
        case MessageType.gender:
          {
            messageBuilder.writeln(generateKeyWithValue(
                jsonKey,
                generateGenderFunction(
                    extraArgsFromGender(
                        message.male, message.female, message.genderOther),
                    message.male,
                    message.female,
                    message.genderOther)));
            break;
          }
      }
    }

    deferredLibrariesBuilder.writeln(generateDeferredLibrariesLibrary(locale));
    findExactBuilder.writeln(generateFindExact(locale));
    createMessageLookupClassBuilder.writeln(
        generateMessageLookup(locale, message: messageBuilder.toString()));
  }

  generatedFile.writeAsStringSync(generatei18nCopiesAllDartFile(
    createMessageLookupClassBuilder.toString(),
    deferredLibrariesBuilder.toString(),
    findExactBuilder.toString(),
  ));
}

/**
 * Task :
 * 1. Generate all copies Constant
 * 2. Generate supported locale
 * 3. Generate string_i18n_constant_manifest.dart
 */
void _handleGenerateConstantDartFile(
    String path,
    String defaultLang,
    Map<String, Message> defaultKeyMap,
    Map<String, FileSystemEntity> validFilesMap) async {
  File generatedFile = File(path);
  if (!generatedFile.existsSync()) {
    generatedFile.createSync(recursive: true);
  }

  _writeConstant(
    StringBuffer constantBuilder,
  ) {
    for (MapEntry<String, Message> entity in defaultKeyMap.entries) {
      String jsonKey = entity.key;
      final _jsonKey = jsonKey.toUpperCase();
      constantBuilder.writeln(generateConstantString(_jsonKey, jsonKey));
    }
  }

  _writeLocale(
    StringBuffer supportedLangBuilder,
  ) {
    supportedLangBuilder.writeln(generateLocale(defaultLang));

    for (var locale in validFilesMap.keys) {
      if (locale != defaultLang) {
        supportedLangBuilder.writeln("${generateLocale(locale).trim()}");
      }
    }
  }

  StringBuffer constantBuilder = StringBuffer();
  StringBuffer supportedLangBuilder = StringBuffer();

  _writeConstant(constantBuilder);
  _writeLocale(supportedLangBuilder);

  generatedFile.writeAsStringSync(generateConstantStringAndLocaleDartFile(
      constantBuilder.toString(), supportedLangBuilder.toString()));
}

/**
 * Task :
 * 1. Generate all getter
 * 2. Generate supported locale
 * 3. Generate string_i18n_generated_manifest.dart
 */
void _handleGenerateI18nManifestDartFile(
    String path,
    String defaultLang,
    Map<String, Message> defaultKeyMap,
    Map<String, FileSystemEntity> validFilesMap) {
  File generatedFile = File(path);
  if (!generatedFile.existsSync()) {
    generatedFile.createSync(recursive: true);
  }

  StringBuffer getterBuilder = StringBuffer();
  StringBuffer supportedLangBuilder = StringBuffer();

  for (MapEntry<String, Message> entity in defaultKeyMap.entries) {
    String jsonKey = entity.key;
    Message message = entity.value;
    final _jsonKey = toCamelCase(jsonKey);

    switch (message.messageKey.type) {
      case MessageType.message:
        {
          if (hasArgsInMessage(message.message)) {
            getterBuilder.writeln(generateGetterMessageWithArgsFunction(
                _jsonKey,
                message.message,
                extraArgsFromMessage(message.message)));
          } else {
            getterBuilder.writeln(
                generateGetterSimpleMessageFunction(_jsonKey, message.message));
          }
          break;
        }
      case MessageType.plural:
        {
          getterBuilder.writeln(generateGetterPluralFunction(
              _jsonKey,
              extraArgsFromPlural(message.zero, message.one, message.two,
                  message.few, message.many, message.other),
              message.zero,
              message.one,
              message.two,
              message.few,
              message.many,
              message.other));
          break;
        }
      case MessageType.gender:
        {
          getterBuilder.writeln(generateGetterGenderFunction(
              _jsonKey,
              extraArgsFromGender(
                  message.male, message.female, message.genderOther),
              message.male,
              message.female,
              message.genderOther));
          break;
        }
    }
  }

  supportedLangBuilder.writeln(generateSupportedLocale(defaultLang));

  for (var locale in validFilesMap.keys) {
    if (locale != defaultLang) {
      supportedLangBuilder.writeln(generateSupportedLocale(locale));
    }
  }

  // 3. Generate string_i18n_generated_manifest.dart
  generatedFile.writeAsStringSync(generateI18nManifestDartFile(
      getterBuilder.toString(), supportedLangBuilder.toString()));
}
