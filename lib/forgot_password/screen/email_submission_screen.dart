import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/forgot_password/bloc/email_submission/email_submission_bloc.dart';
import 'package:meetings/forgot_password/screen/email_submission_form.dart';

class EmailSubmissionScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => EmailSubmissionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ff1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BlocProvider(
            create: (context) {
              return EmailSubmissionBloc();
            },
            child: EmailSubmissionForm(),
          ),
        ),
      ),
    );
  }
}
