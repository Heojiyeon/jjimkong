class MenuEatenModel {
  final String menuId;
  final bool isMenuEaten;

  MenuEatenModel({
    required this.menuId,
    required this.isMenuEaten,
  });

  Map<String, dynamic> toJson() {
    return {
      "menuId": menuId,
      "isChecked": isMenuEaten,
    };
  }

  MenuEatenModel.fromJson(Map<String, dynamic> json)
      : menuId = json["menuId"],
        isMenuEaten = json["isMenuEaten"];
}
