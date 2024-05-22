import 'dart:io';

void main() async {
  String content = '''
<?xml version="1.0"?>
<gpx version="1.1" creator="ssafy.com">
''';
  int interval = 1000;
  DateTime now = DateTime.parse("2024-04-30T19:14:34Z");
  for (int i = 0; i < 2800; i += 3) {
    content += '''
 <wpt lat="${((9346380432597 + 200000000 * i) / 100000000000000 + 35).toStringAsFixed(5)}" lon="128.85293992087284">
    <ele>3.02</ele>
    <time>${now.add(Duration(milliseconds: interval)).toIso8601String()}</time>
</wpt>
''';
    now = now.add(Duration(milliseconds: interval));
  }
  content += '</gpx>';

  // File 객체 생성
  File file = File('output.gpx');

  // 파일에 문자열 쓰기
  try {
    await file.writeAsString(content);
    print("파일 저장 완료!");
  } catch (e) {
    print("파일을 저장하는 동안 오류가 발생했습니다: $e");
  }
}
