import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/profile/bloc/edit_details/edit_details_bloc.dart';
import 'package:formz/formz.dart';

import '../../consts.dart';

class EditDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDetailsBloc, EditDetailsState>(
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 24)),
            Text(
              'Edit your details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: PrimaryColor,
              ),
            ),
            // const Padding(padding: EdgeInsets.only(top: 30)),
            // _EmailInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _MobileNoInput(),
            const Padding(padding: EdgeInsets.only(top: 30)),
            _DoneButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDetailsBloc, EditDetailsState>(
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
              key: const Key('editDetailsForm_emailInput_textField'),
              enabled: !state.status.isSubmissionInProgress,
              onChanged: (email) =>
                  context.bloc<EditDetailsBloc>().add(EmailUpdated(email)),
              decoration: InputDecoration(
                errorText: state.email.errorText(),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDetailsBloc, EditDetailsState>(
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
              key: const Key('editDetailsForm_passwordInput_textField'),
              onChanged: (password) => context
                  .bloc<EditDetailsBloc>()
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

class _MobileNoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDetailsBloc, EditDetailsState>(
      buildWhen: (previous, current) =>
      previous.phoneNo != current.phoneNo ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone number',
              style: TextStyle(fontSize: 16, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('editDetailsForm_phoneNoInput_textField'),
              onChanged: (mobileNo) {
                context.bloc<EditDetailsBloc>().add(PhoneNoUpdated(mobileNo));
              },
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                errorText: state.phoneNo.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ],
        );
      },
    );
  }
}

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDetailsBloc, EditDetailsState>(
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
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            key: const Key('editDetailsForm_editDetails_raisedButton'),
            onPressed: state.status.isValidated
                ? () {
              context
                  .bloc<EditDetailsBloc>()
                  .add(EditDetailsSubmitted());
            }
                : null,
          ),
        );
      },
    );
  }
}
