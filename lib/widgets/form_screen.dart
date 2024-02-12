import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<String> attachments = [];
  bool isHTML = false;
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController(
    text: 'alyosrforservices@gmail.com',
  );
  // create an instance of the FormData class
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الاسم',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                formData.name = value!;
              },
            ),
            const Text(
              'رقم التليفون',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Phone Number';
                }

                return null;
              },
              onSaved: (value) {
                formData.phone = value!;
              },
            ),
            const Text(
              'الايميل',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Invalid email';
                }
                return null;
              },
              onSaved: (value) {
                formData.email = value!;
              },
            ),
            const Text(
              'الرسالة',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              maxLines: 5,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
              onSaved: (value) {
                formData.message = value!;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  sendEmail(); // call the sendEmail function
                }
              },
              child: const Text('ارسل'),
            ),
          ],
        ),
      ),
    );
  }
  void sendEmail() async {
    final Email email = Email(
      body:
          '${formData.name} ,\n ${formData.phone},\n  ${formData.email} ,\n ${formData.message}',
      subject: 'New Request',
      recipients: ['info@alyosr.online', '${_recipientController}'],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
class FormData {
  late String name;
  late String phone;
  late String email;
  late String message;
}
