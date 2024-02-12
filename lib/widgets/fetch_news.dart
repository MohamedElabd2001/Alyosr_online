
import 'package:http/http.dart' as http;




Future<String> fetchHtmlContent() async {
  final response = await http.get(Uri.parse('https://news.alyosr.online/'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load HTML content');
  }
}
