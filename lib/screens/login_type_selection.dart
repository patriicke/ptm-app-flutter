import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/signup/screen/signup_screen.dart';
import 'package:repository_core/repository_core.dart';

class LoginTypeSelectionScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginTypeSelectionScreen());
  }

  final headerTextStyle =
      TextStyle(color: PrimaryColor, fontSize: 28, fontWeight: FontWeight.w500);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('I\'m a', style: headerTextStyle),
            const Padding(padding: EdgeInsets.only(top: 70)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: 136,
                  height: 136,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      backgroundColor: AccentColor
                    ),
                    child: Text(
                      'Parent',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    onPressed: () {
                      context
                          .bloc<LoginTypeBloc>()
                          .add(LoginTypeUpdated(LoginType.parent));
                      Navigator.of(context).push(SignUpScreen.route());
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: 136,
                  height: 136,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        backgroundColor: AccentColor
                    ),
                    child: Text(
                      'Teacher',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    onPressed: () {
                      context
                          .bloc<LoginTypeBloc>()
                          .add(LoginTypeUpdated(LoginType.teacher));
                      Navigator.of(context).push(SignUpScreen.route());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
