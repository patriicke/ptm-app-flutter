import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/signup/bloc/sign_up/sign_up_bloc.dart';
import 'package:meetings/signup/screen/signup_form.dart';
import 'package:repository_core/repository_core.dart';
import 'package:formz/formz.dart';

class SignUpScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ff1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: BlocProvider(
            create: (context) {
              var signupType = context.bloc<LoginTypeBloc>().state;
              return SignUpBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              )..add(signupType == LoginType.parent
                  ? SignUpStarted(0)
                  : SignUpStarted(1));
            },
            child: _SignUpWorkflow(),
          ),
        ),
      ),
    );
  }
}

class _SignUpWorkflow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        switch (state.status) {
          case FormzStatus.submissionFailure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('SignUp Failed: ${state.signupError}'),
                ),
              );
            break;
          case FormzStatus.submissionSuccess:
            break;
          default:
        }
      },
      child: SignupForm(),
    );
  }
}
