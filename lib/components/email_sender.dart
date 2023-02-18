import 'dart:html';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';

void main()=>{
  runApp(MaterialApp(
      home: email_sender()
  ))
};

class email_sender extends StatefulWidget {
  const email_sender({Key? key}) : super(key: key);

  @override
  State<email_sender> createState() => _email_senderState();
}

class _email_senderState extends State<email_sender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text("Send Email"),
          onPressed: () {
            sendmail();
          },
        ),
      ),
    );
  }
  sendmail() async {
    String username = 'shivaga9828@gmail.com';
    String password = 'hgmidmlzbqlswgve';
    final smtpServer = gmail(username, password);
    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name 😀')
      ..recipients.add(Address('destination@example.com'))
      ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
      ..bccRecipients.add('bccAddress@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>';
    // ..attachments = [
    //   FileAttachment(File('exploits_of_a_mom.png'))
    //     ..location = Location.inline
    //     ..cid = '<myimg@3.141>'
    // ];
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}