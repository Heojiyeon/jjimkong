/// 알러지 코드 관련 클래스
class AllergyCode {
  /// 알러지 코드 리스트
  static final List<Map<String, String>> allergyCodes = [
    {'code': 'ML', 'name': '우유'},
    {'code': 'WH', 'name': '밀'},
    {'code': 'BK', 'name': '메밀'},
    {'code': 'PN', 'name': '땅콩'},
    {'code': 'SO', 'name': '대두'},
    {'code': 'WT', 'name': '호두'},
    {'code': 'PI', 'name': '잣'},
    {'code': 'PK', 'name': '돼지고기'},
    {'code': 'CK', 'name': '닭고기'},
    {'code': 'BF', 'name': '소고기'},
    {'code': 'PC', 'name': '복숭아'},
    {'code': 'TM', 'name': '토마토'},
    {'code': 'EG', 'name': '난류'},
    {'code': 'SQ', 'name': '오징어'},
    {'code': 'MS', 'name': '고등어'},
    {'code': 'CR', 'name': '게'},
    {'code': 'SH', 'name': '새우'},
    {'code': 'MO', 'name': '조개류'},
    {'code': 'SU', 'name': '아황산류'},
  ];

  /// 알러지 코드를 이름으로 변환한다.
  /// [code] 알러지 코드
  ///
  static String getAllergyNameByCode(String code) {
    Map<String, String> codeToName = allergyCodes
        .where((allergyCode) => allergyCode['code'] == code)
        .toList()[0];

    return codeToName['name'] ?? '';
  }
}
