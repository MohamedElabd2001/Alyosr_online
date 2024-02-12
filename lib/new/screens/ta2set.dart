import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class Ta2setScreen extends StatelessWidget {
  const Ta2setScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('أخبار'),
        centerTitle: true,
      ),
      body:FutureBuilder<String>(
        future: fetchHtmlCont(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return InAppWebView(
              initialData: InAppWebViewInitialData(
                data: snapshot.data!,
                mimeType: 'text/html',
              ),
            );
          }
        },
      ),

    );
  }

  Future<String> fetchHtmlCont() async {
    final response = await http.get(Uri.parse('https://alyosr.online/%d8%ae%d8%af%d9%85%d8%a7%d8%aa-%d8%a7%d9%84%d8%aa%d9%82%d8%b3%d9%8a%d8%b7-%d9%85%d8%b9-%d8%a8%d9%88%d8%a7%d8%a8%d8%a9-%d8%a7%d9%84%d9%8a%d8%b3%d8%b1/'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load HTML content');
    }
  }
}
