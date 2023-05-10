import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/home/bloc/meetings_home/meetings_home_bloc.dart';
import 'package:meetings/home/screen/create_meeting_screen.dart';
import 'package:meetings/home/screen/meetings_list.dart';

import '../../bannerads.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    // context.bloc<MeetingsHomeBloc>().add(MeetingsLoaded());
    return BlocProvider.value(
      value: BlocProvider.of<MeetingsHomeBloc>(context)
        ..add(new MeetingsLoaded()),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: MeetingsList(),
                ),
                Positioned(
                  child: FloatingActionButton(
                    backgroundColor: BottombarColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(CreateMeetingScreen.route());
                    },
                  ),
                  bottom: 16,
                  right: 16,
                ),
              ],
            ),
          ),
          // BannerAdmob(),
          SizedBox(height: 5)
        ],
      ),
    );
    // return Builder(
    //   builder: (context) {
    //     return Stack(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 30),
    //           child: MeetingsList(),
    //         ),
    //         Positioned(
    //           child: FloatingActionButton(
    //             backgroundColor: PrimaryColor,
    //             child: Icon(
    //               Icons.add,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               Navigator.of(context).push(CreateMeetingScreen.route());
    //             },
    //           ),
    //           bottom: 16,
    //           right: 16,
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
