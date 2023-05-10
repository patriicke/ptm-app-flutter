import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/profile/bloc/email_invite_form/email_invite_form_bloc.dart';
import 'package:formz/formz.dart';

class EmailInviteForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailInviteFormBloc, EmailInviteFormState>(
      listener: (context, listenerState) {
        if (listenerState.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content:
                    Text('Meeting Creation Failed: ${listenerState.error}'),
              ),
            );
        } else if (listenerState.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 24)),
          Text(
            'Send email invite',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: PrimaryColor,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30)),
          _EmailInput(),
          const Padding(padding: EdgeInsets.only(top: 30)),
          _SendButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailInviteFormBloc, EmailInviteFormState>(
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
              key: const Key('emailInviteForm_emailInput_textField'),
              enabled: !state.status.isSubmissionInProgress,
              onChanged: (email) =>
                  context.bloc<EmailInviteFormBloc>().add(EmailUpdated(email)),
              decoration: InputDecoration(
                // errorText: state.meetingTitle.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusColor: PrimaryColor,
                hoverColor: PrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailInviteFormBloc, EmailInviteFormState>(
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
                      'Send Invite',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  key: const Key('emailInviteForm_sendInvite_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .bloc<EmailInviteFormBloc>()
                              .add(EmailInviteFormSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
