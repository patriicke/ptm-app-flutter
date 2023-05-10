import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/forgot_password/bloc/email_submission/email_submission_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meetings/forgot_password/screen/reset_verification_screen.dart';

class EmailSubmissionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailSubmissionBloc, EmailSubmissionState>(
      listener: (context, listenerState) {
        if (listenerState.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text('Email submission failed: ${listenerState.error}'),
              ),
            );
        } else if (listenerState.status.isSubmissionSuccess) {
          Navigator.pushReplacement(context,
              ResetVerificationScreen.route(listenerState.signupEventId));
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
                    'Account recovery',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: PrimaryColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  _EmailInput(),
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailSubmissionBloc, EmailSubmissionState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              onChanged: (email) =>
                  context.bloc<EmailSubmissionBloc>().add(EmailUpdated(email)),
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailSubmissionBloc, EmailSubmissionState>(
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
                              .bloc<EmailSubmissionBloc>()
                              .add(EmailSubmissionSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
