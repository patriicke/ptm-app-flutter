import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: 140.0,
                width: 140.0,
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
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
