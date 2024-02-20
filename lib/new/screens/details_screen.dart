import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:html/parser.dart';

import '../../email_sender.dart';
import '../model/model.dart';

class DetailsScreen extends StatelessWidget {
  final PageData page;

  const DetailsScreen({super.key, required this.page});

  String extractArabicText(String input) {
    // Remove HTML tags and HTML entities
    String withoutHtmlTags = input.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

    // Keep only Arabic characters, spaces, and common punctuation
    String arabicTextOnly = withoutHtmlTags.replaceAll(RegExp(r'[^\u0600-\u06FF\s،؛؟.!-*0-9]'), '');

    // Remove specific strings
    arabicTextOnly = arabicTextOnly.replaceAll("الاسم بالكامل", "");
    arabicTextOnly = arabicTextOnly.replaceAll("البريد الالكتروني", "");
    arabicTextOnly = arabicTextOnly.replaceAll("رقم الموبايل", "");
    arabicTextOnly = arabicTextOnly.replaceAll("الخدمة المطلوبة اختياري", "");
    arabicTextOnly = arabicTextOnly.replaceAll(" الاسم ", "");
    arabicTextOnly = arabicTextOnly.replaceAll(" وصف الطلب ", "");

    arabicTextOnly = arabicTextOnly.replaceAll(RegExp(r'wpforms[^ ]* '), '');
    return arabicTextOnly;
  }
  String formatHtmlString(String string) {
    return string
        .replaceAll("\n\n", "<p>") // Paragraphs
        .replaceAll("\n", "<br>") // Line Breaks
        .replaceAll("\"", "&quot;") // Quote Marks
        .replaceAll("'", "&apos;") // Apostrophe
        .replaceAll(">", "&lt;") // Less-than Comparator (Strip Tags)
        .replaceAll("<", "&gt;") // Greater-than Comparator (Strip Tags)
        .trim(); // Whitespace
  }

  @override
  Widget build(BuildContext context) {
    String htmlText = parse(page.content).body!.text;
    htmlText = extractArabicText(htmlText);

    String cleanedTitle = page.title.replaceAll(RegExp(r'&#8211;|;'), '');



    return Scaffold(
      appBar: AppBar(
        title: Text(cleanedTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Animate(
                        child: Image.network(
                          page.imageUrl,
                          fit: BoxFit.contain,
                        ).animate().fade().scale(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0,left: 10,right: 10,top: 25),
                      child: Animate(
                        child: Text(
                          htmlText.trim(),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ).animate().fade().scale(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54, // Change this to the desired color
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EmailSender(serviceName: page.title)),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:  Center(
                  child: Animate(
                    child: const Text(
                      'أطلب خدمتك الأن',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Cairo'),
                    ).animate().fade().scale(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}