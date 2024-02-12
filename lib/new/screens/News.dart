import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;


class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('أخبار'),
          centerTitle: true,
        ),
        body:FutureBuilder<String>(
          future: fetchHtmlContent(),
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

  Future<String> fetchHtmlContent() async {
    final response = await http.get(Uri.parse('https://news.alyosr.online/'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load HTML content');
    }
  }
}


