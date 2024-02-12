import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class EmailSender extends StatefulWidget {
  final String serviceName;

  EmailSender({required this.serviceName});

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;

  final _nameController = TextEditingController(text: '');
  final _recipientController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _senderController = TextEditingController(
      text: 'alyosrorders@gmail.com');
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController(text: '');

  Future<void> send() async {
    String name = _nameController.text;
    String phoneNumber = _phoneController.text;

    // Build the body of the email with name and phone number
    String emailBody = '''
Name: $name
Phone Number: $phoneNumber

${_bodyController.text}
''';

    final Email email = Email(
      body: emailBody,
      subject: _subjectController.text,
      recipients: [_senderController.text],
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

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      List<String> filePaths = result.paths.map((path) => path!).toList();
      setState(() {
        attachments.addAll(filePaths);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _subjectController.text = widget.serviceName;
  }

  String _truncateFileName(String fileName, int maxLength) {
    if (fileName.length > maxLength) {
      return fileName.substring(0, maxLength) + '...';
    }
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'بوابة اليسر للخدمات الحكومية',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        centerTitle: true,
      ),
      body:  ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            textAlign: TextAlign.end,
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'الاسم',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            textAlign: TextAlign.end,
            controller: _phoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'رقم التليفون',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _recipientController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'الايميل',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            enabled: false,
            textAlign: TextAlign.end,
            controller: _subjectController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'الموضوع',
            ),
          ),
          SizedBox(height: 16.0),
          SizedBox(
            height: 120,
            child: TextField(
              maxLines: 50,
              textAlign: TextAlign.end,
              keyboardType:TextInputType.text,
              controller: _bodyController,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                labelText: 'الرسالة',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: pickFiles,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ارفق ملفات',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                Icon(Icons.attach_file),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'الملفات المرفقة',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              String fileName = path.basename(attachments[index]);
              return ListTile(
                title: Text(_truncateFileName(fileName, 30)),
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      attachments.removeAt(index);
                    });
                  },
                  child: Icon(Icons.delete),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: send,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'أرسل بريدا إلكترونيا',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.send),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*

Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
TextField(
controller: _nameController,
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'الاسم',
),
),
const SizedBox(height: 10),
TextField(
controller: _recipientController,
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'الايميل',
),
),
const SizedBox(height: 10),
TextField(
controller: _phoneController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'رقم التليفون',
),
),
const SizedBox(height: 10),
TextField(
controller: _subjectController,
decoration: const InputDecoration(
border: OutlineInputBorder(),
labelText: 'الموضوع',
),
),
const SizedBox(height: 10),
Expanded(
child: TextField(
controller: _bodyController,
maxLines: null,
expands: true,
textAlignVertical: TextAlignVertical.top,
decoration: const InputDecoration(
labelText: 'الرسالة',
border: OutlineInputBorder(),
),
),
),
Expanded(
child: ListView.builder(
scrollDirection: Axis.horizontal,
itemCount: attachments.length,
itemBuilder: (context, index) {
return Row(
children: <Widget>[
Tooltip(
message: attachments[index],
child: Text(
_truncateFileName(path.basename(attachments[index]), 20), // Set your preferred maximum length
),
),
IconButton(
icon: Icon(Icons.remove),
onPressed: () {
setState(() {
attachments.removeAt(index);
});
},
),
],
);
},
),
),
Align(
alignment: Alignment.centerRight,
child: ElevatedButton(
onPressed: pickFiles,
child: const Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
'ارفق ملفات',
style: TextStyle(fontSize: 16),
),
SizedBox(width: 10),
Icon(Icons.attach_file),
],
),
),
),
Align(
alignment: Alignment.centerRight,
child: ElevatedButton(
onPressed: send,
child: const Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
'ارسل',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
SizedBox(width: 10),
Icon(Icons.send),
],
),
),
),
],
),
),*/
