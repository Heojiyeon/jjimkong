class MenuCheckModel {
  final String menuId;
  final bool isChecked;

  MenuCheckModel({
    required this.menuId,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {
      "menuId": menuId,
      "isChecked": isChecked,
    };
  }

  MenuCheckModel.fromJson(Map<String, dynamic> json)
      : menuId = json["menuId"],
        isChecked = json["isChecked"];
}
