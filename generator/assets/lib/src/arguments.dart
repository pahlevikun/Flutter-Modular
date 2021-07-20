import 'package:yaml/yaml.dart';

import 'model/resources.dart';
import 'utils/utils.dart';

class Config {
  String? pubspecFilename;
  List<String> ignoreAssets = [];
  List<CustomAssetType> assetClasses = [];
  String? customPakcage;

  Config();

  factory Config.parsePubspecConfig(YamlMap yaml) {
    final arguments = Config()..pubspecFilename = 'pubspec.yaml';

    final assetGeneratorConfig = safeCast<YamlMap>(yaml["assets_generator"]);
    if (assetGeneratorConfig == null) {
      return arguments;
    }

    final ignoreRaw = safeCast<YamlList>(assetGeneratorConfig['ignore']);
    arguments.ignoreAssets = ignoreRaw
            ?.map((x) => safeCast<String>(x) ?? '')
            .where((it) => it.isNotEmpty)
            .toList() ??
        [];
    arguments.customPakcage =
        safeCast<String>(assetGeneratorConfig["custom_package"]);

    final assetClasses =
        safeCast<YamlMap>(assetGeneratorConfig['asset_classes']);
    final classes = <CustomAssetType>[];
    for (final key in assetClasses?.keys ?? []) {
      final keyString = safeCast<String>(key);
      if (keyString == null) {
        continue;
      }
      final Object value = assetClasses![key];
      var import = CustomAssetType.defaultImport;
      String className = '';
      if (value is YamlMap) {
        className = safeCast<String>(value['class']) ?? '';
        import = safeCast<String>(value['import']) ?? import;
      } else if (value is String) {
        className = value;
      } else {
        assert(false);
      }

      classes.add(CustomAssetType(className, keyString, import));
    }
    arguments.assetClasses = classes;

    return arguments;
  }
}
