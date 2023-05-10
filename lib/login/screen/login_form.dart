import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/forgot_password/screen/email_submission_screen.dart';
import 'package:meetings/login/bloc/login.dart';
import 'package:meetings/signup/screen/signup_screen.dart';
import 'package:repository_core/repository_core.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Login Failed: ${state.error}'),
              ),
            );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: const Alignment(0, -1 / 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 65)),
                    _LogoAvatar(),
                    const Padding(padding: EdgeInsets.only(top: 42)),
                    _HeaderText(),
                    const Padding(padding: EdgeInsets.only(top: 45)),
                    _UsernameInput(),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    _PasswordInput(),
                    const Padding(padding: EdgeInsets.only(top: 60)),
                    _LoginButton(),
                    const Padding(padding: EdgeInsets.only(top: 16)),
                    _ForgotPasswordNavigator(),
                    const Padding(padding: EdgeInsets.only(top: 80)),
                    _SignUpNavigator(),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    _ParentTeacherSwitcher(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 102.0,
        width: 102.0,
        color: Colors.grey[300],
        child: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
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
            ? Text('Parent Login', style: headerTextStyle)
            : Text('Teacher Login', style: headerTextStyle);
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
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
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (email) =>
                  context.bloc<LoginBloc>().add(LoginEmailChanged(email)),
              enabled: !state.status.isSubmissionInProgress,
              decoration: InputDecoration(
                hintText: 'example@email.com',
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
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
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.bloc<LoginBloc>().add(LoginPasswordChanged(password)),
              enabled: !state.status.isSubmissionInProgress,
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

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  key: const Key('loginForm_continue_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () {
                          context.bloc<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}

class _ForgotPasswordNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () =>
              Navigator.of(context).push(EmailSubmissionScreen.route()),
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: PrimaryColor),
          ),
        ),
      ],
    );
  }
}

class _SignUpNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return GestureDetector(
          onTap: state.status.isSubmissionInProgress
              ? null
              : () {
                  Navigator.of(context).pushReplacement(SignUpScreen.route());
                },
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: PrimaryColor,
              ),
              children: <TextSpan>[
                new TextSpan(text: 'Don\'t have an account? '),
                new TextSpan(
                  text: 'Sign Up',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ParentTeacherSwitcher extends StatelessWidget {
  String _generateButtonText(LoginType type) {
    switch (type) {
      case LoginType.unspecified:
        return null;
      case LoginType.parent:
        return 'I\'m a teacher';
      case LoginType.teacher:
        return 'I\m a parent';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, loginTypeState) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 2.0,
              color: PrimaryColor,
            ),
          ),
          width: double.infinity,
          child: BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, loginState) {
              return TextButton(
                onPressed: !loginState.status.isSubmissionInProgress
                    ? () {
                        final currentLoginType =
                            context.bloc<LoginTypeBloc>().state;
                        switch (currentLoginType) {
                          case LoginType.parent:
                            context
                                .bloc<LoginTypeBloc>()
                                .add(LoginTypeUpdated(LoginType.teacher));
                            break;
                          case LoginType.teacher:
                            context
                                .bloc<LoginTypeBloc>()
                                .add(LoginTypeUpdated(LoginType.parent));
                            break;
                          default:
                            break;
                        }
                      }
                    : null,
                child: Text(
                  _generateButtonText(context.bloc<LoginTypeBloc>().state),
                  style: TextStyle(color: PrimaryColor),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
