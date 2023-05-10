import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/signup/bloc/verification/verification_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationBloc, VerificationState>(
      listener: (context, state) {
        switch (state.status) {
          case FormzStatus.submissionFailure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                ),
              );
            break;
          default:
            break;
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 155)),
                  Text(
                    'Verification Code',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  _HeaderText(),
                  const Padding(padding: EdgeInsets.only(top: 160)),
                  _VerificationInput(),
                  const Padding(padding: EdgeInsets.only(top: 180)),
                  _VerifyButton(),
                  const Padding(padding: EdgeInsets.only(top: 48)),
                  Text(
                    'Resend',
                    style: TextStyle(color: PrimaryColor),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 96)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return BlocBuilder<VerificationBloc, VerificationState>(
      builder: (context, state) {
        var email = state.emailAddress;
        return Container(
          width: c_width,
          child: Text(
            'Please enter the verification code sent to $email',
            textAlign: TextAlign.center,
            style: TextStyle(color: PrimaryColor),
          ),
        );
      },
    );
  }
}

class _VerificationInput extends StatelessWidget {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border(
          bottom: BorderSide(
        color: PrimaryColor,
        width: 2.0,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _pinPutFocusNode.requestFocus();
    return BlocBuilder<VerificationBloc, VerificationState>(
      buildWhen: (previous, current) =>
          previous.verificationCode != current.verificationCode ||
          previous.status != current.status,
      builder: (context, state) {
        return Theme(
          data: new ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 5.0,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          child: PinPut(
            enabled: state.status != FormzStatus.submissionInProgress,
            fieldsCount: 5,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: _pinPutDecoration,
            eachFieldWidth: 42.0,
            textStyle: TextStyle(
              color: PrimaryColor,
            ),
            selectedFieldDecoration: _pinPutDecoration.copyWith(
              border: Border(
                bottom: BorderSide(
                  color: PrimaryColor,
                  width: 5.0,
                ),
              ),
            ),
            followingFieldDecoration: _pinPutDecoration,
            onChanged: (code) => context
                .bloc<VerificationBloc>()
                .add(VerificationCodeUpdated(code)),
          ),
        );
      },
    );
  }
}

class _VerifyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationBloc, VerificationState>(
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? CircularProgressIndicator()
            : Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PrimaryColor,
                    textStyle: TextStyle(color: Colors.white,),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    context
                        .bloc<VerificationBloc>()
                        .add(const VerificationSubmitted());
                  },
                ),
              );
      },
    );
  }
}
