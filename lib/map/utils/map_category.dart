class MapCategory {
  static final MapCategory _instance = MapCategory._internal();
  static const Map<String, String> options = {
    "FP": "붕어빵",
    "KR": "한식",
    "JP": "일식",
    "CN": "중식",
    "WE": "양식",
    "CF": "카페",
    "OT": "기타",
  };

  factory MapCategory() {
    return _instance;
  }

  MapCategory._internal();

  String findCategoryByCode(String code) {
    return options[code] ?? "-";
  }

  MapEntry<String, String> findCategoryByIndex(int index) {
    return options.entries.toList()[index];
  }

  String? getKeyFromValue(String value) {
    return options.entries
        .firstWhere((entry) => entry.value == value,
            orElse: () => MapEntry('', ''))
        .key;
  }
}
