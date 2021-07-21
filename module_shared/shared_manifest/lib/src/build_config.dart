import 'dart:ui';

class BuildConfig {
  static const APP_ID = "id.digiva.moslem.app";

  static const _PROD_BASE_URL = "http://157.175.85.34/";
  static const _DEV_BASE_URL = "http://157.175.85.34/";

  static const BASE_URL = STAGING ? _DEV_BASE_URL : _PROD_BASE_URL;

  static const COUNTRY_CODE = BuildConfig.DEBUG ? "+62" : "+966";

  static const SHOW_LOG = true;
  static const STAGING = true;
  static const DEBUG = false;
  static const ALLOW_AUTO_LOCATION_UPDATE = false;

  static const LANG_EN_NAME = "English";
  static const LANG_AR_NAME = "Arabic";

  static const List<Locale> SUPPORTED_LOCALE = [];
}
