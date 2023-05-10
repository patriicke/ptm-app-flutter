import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/forgot_password/bloc/verification/forgot_password_verification_bloc.dart';
import 'package:meetings/forgot_password/screen/reset_verification_form.dart';

class ResetVerificationScreen extends StatelessWidget {
  final int _verificationEventId;
  ResetVerificationScreen(verificationEventId)
      : assert(verificationEventId != null),
        _verificationEventId = verificationEventId;
  static Route route(int verificationEventId) {
    return MaterialPageRoute<void>(
        builder: (_) => ResetVerificationScreen(verificationEventId));
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
              return ForgotPasswordVerificationBloc(
                verificationEventId: _verificationEventId,
              );
            },
            child: ResetVerificationForm(),
          ),
        ),
      ),
    );
  }
}
