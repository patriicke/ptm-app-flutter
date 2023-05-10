import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/forgot_password/bloc/verification/forgot_password_verification_bloc.dart';
import 'package:formz/formz.dart';

class ResetVerificationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordVerificationBloc,
        ForgotPasswordVerificationState>(
      listener: (context, listenerState) {
        if (listenerState.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Reset Password failed: ${listenerState.error}'),
              ),
            );
        } else if (listenerState.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 24)),
                  Text(
                    'Verify and reset',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: PrimaryColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _VerificationInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _PasswordInput(),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _SubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordVerificationBloc,
        ForgotPasswordVerificationState>(
      buildWhen: (previous, current) =>
          previous.verificationCode != current.verificationCode ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification Code',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              onChanged: (code) => context
                  .bloc<ForgotPasswordVerificationBloc>()
                  .add(VerificationCodeUpdated(code)),
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordVerificationBloc,
        ForgotPasswordVerificationState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              onChanged: (password) => context
                  .bloc<ForgotPasswordVerificationBloc>()
                  .add(PasswordUpdated(password)),
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                errorText: state.password.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: true,
            ),
          ],
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordVerificationBloc,
        ForgotPasswordVerificationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PrimaryColor,
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .bloc<ForgotPasswordVerificationBloc>()
                              .add(VerificationCodeSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
