part of 'extensions.dart';

extension StringDoubleExt on double {
  String toRupiah() {
    if (this == null) {
      return "";
    } else {
      String rupiah = "Rp. ";
      final numberFormat = NumberFormat("#,###.##", "en_US");
      String result = numberFormat.format(this);

      return rupiah + result;
    }
  }
}

extension StringExt on String {
  String formatIndonesiaPhoneNumber() {
    if (this.isEmpty) {
      return "";
    } else {
      String temp = "+62";
      if (this.substring(0, 1) == "0") {
        temp += this.substring(1);
      } else {
        temp += this;
      }
      return temp;
    }
  }

  String formateAgeRange(String from, String to, String postfix) {
    if (this.isEmpty) {
      return "-";
    } else {
      List<String> range = this.split(",");
      if (range.length > 1) {
        return "$from ${range[0]} $to ${range[1]} $postfix";
      } else {
        return "-";
      }
    }
  }
}

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
