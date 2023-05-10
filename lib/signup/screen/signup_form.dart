import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/login/screen/login_screen.dart';
import 'package:meetings/signup/bloc/sign_up/sign_up_bloc.dart';
import 'package:repository_core/repository_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/verification/verification_bloc.dart';

String GetMobileNo='';

class SignupForm extends StatelessWidget {
  TextEditingController getMobileNo=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 110)),
                      _HeaderText(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _FullNameInput(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _EmailInput(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _PasswordInput(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _MobileNoInput(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _AboutInput(),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      _SignUpButton(),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      _SignInNavigator(),
                    ],
                  ),
                ),
                Positioned(
                  top: 60.0,
                  left: -15,
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: PrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderText extends StatelessWidget {
  final headerTextStyle =
  TextStyle(color: PrimaryColor, fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state == LoginType.parent
            ? Text('Parent SignUp', style: headerTextStyle)
            : Text('Teacher SignUp', style: headerTextStyle);
      },
    );
  }
}

class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.fullName != current.fullName ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: TextStyle(fontSize: 12, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('signUpForm_fullNameInput_textField'),
              onChanged: (fullName) =>
                  context.bloc<SignUpBloc>().add(FullNameUpdated(fullName)),
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                errorText: state.fullName.errorText(),
                hintText: 'John Doe',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.email != current.email || previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
              style: TextStyle(fontSize: 12, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (email) =>
                  context.bloc<SignUpBloc>().add(EmailUpdated(email)),
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                errorText: state.email.errorText(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.password != current.password ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: TextStyle(fontSize: 12, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.bloc<SignUpBloc>().add(PasswordUpdated(password)),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.mobileNo != current.mobileNo ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile No.',
              style: TextStyle(fontSize: 12, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('signUpForm_mobileNoInput_textField'),
              onChanged: (mobileNo) {
                context.bloc<SignUpBloc>().add(MobileNoUpdated(mobileNo));
                GetMobileNo=mobileNo;
              },
              enabled: state.status.isSubmissionInProgress ? false : true,
              decoration: InputDecoration(
                errorText: state.mobileNo.errorText(),
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

class _AboutInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.about != current.about || previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 12, color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            TextField(
              key: const Key('signUpForm_aboutInput_textField'),
              enabled: state.status.isSubmissionInProgress ? false : true,
              onChanged: (about) =>
                  context.bloc<SignUpBloc>().add(AboutUpdated(about)),
              decoration: InputDecoration(
                errorText: state.about.errorText(),
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

class _SignUpButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: const Text(
                'SignUp',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            key: const Key('signUpForm_continue_raisedButton'),
            onPressed: state.status.isValidated
                ? () {
              context
                  .bloc<SignUpBloc>()
                  .add(const SignUpSubmitted());
            }
                : null,
            /*onPressed: state.status.isValidated
                ? () async {
              print("$GetMobileNo");
              //var prefs = await SharedPreferences.getInstance();
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: "+91 $GetMobileNo",
                verificationCompleted: (firebaseUser) {
                  print('verificationCompleted');
                },
                verificationFailed: (e) {
                  print('verificationFailed');
                  if (e.code == 'invalid-phone-number') {
                    print(
                        'The provided phone number is not valid.');
                  } else {
                    print('Some error occoured: ${e.toString()}');
                  }
                },
                codeSent: (verificationId, [forceResendingToken]) {
                  print('codeSent');
                  print("sms is for $verificationId");
                  //prefs.setString("verificationId", verificationId);
                  context
                      .bloc<SignUpBloc>()
                      .add(const SignUpSubmitted());
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  print("Timeout: $verificationId");
                },
                timeout: Duration(seconds: 15),
              );
            }
                : null,*/
          ),
        );
      },
    );
  }
}

class _SignInNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(LoginScreen.route());
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.0,
            color: PrimaryColor,
          ),
          children: <TextSpan>[
            new TextSpan(text: 'Already have an account? '),
            new TextSpan(
              text: 'Sign In',
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
