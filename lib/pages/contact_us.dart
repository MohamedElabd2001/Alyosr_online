import 'package:alyosr_online/email_sender.dart';
import 'package:flutter/material.dart';


class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'تواصل معنا',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Image.asset('assets/images/contact-us.webp'),
              ),
              const SizedBox(
                height: 50,
              ),
                EmailSender(serviceName: '',),
            ],
          ),
        ),
      ),
    );
  }
}
