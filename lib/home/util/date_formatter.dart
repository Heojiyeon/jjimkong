///
/// 날짜 출력 방식 변환 함수
/// [date] 문자열 형태의 날짜 데이터 / 2024-12-23
///
///
String dateFormmater(String date) {
  DateTime dateTime = DateTime.parse(date);

  int month = dateTime.month;
  int day = dateTime.day;

  return '$month월 $day일';
}

///
/// 날짜에 해당하는 요일 반환 함수
/// [date] 문자열 형태의 잘짜 데이터 / 2024-12-23
///
///
String getWeekday(String date) {
  DateTime dateTime = DateTime.parse(date);

  List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  return weekdays[dateTime.weekday - 1];
}
