import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/notifications/bloc/meeting_approval/meeting_approval_bloc.dart';

import '../../consts.dart';

class MeetingApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingApprovalBloc, MeetingApprovalState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is MeetingApprovalLoadSuccess) {
          if (state.performedAction == PerformedAction.approved ||
              state.performedAction == PerformedAction.rejected) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<MeetingApprovalBloc, MeetingApprovalState>(
        builder: (context, state) {
          if (state is MeetingApprovalLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MeetingApprovalLoadSuccess) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _UserInfo(),
                    const Padding(padding: EdgeInsets.only(top: 150)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: _AcceptButton(),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: _RejectButton(),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MeetingApprovalLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context
                        .bloc<MeetingApprovalBloc>()
                        .add(MeetingApprovalLoaded());
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Invalid state type ${state.runtimeType.toString()}'),
            );
          }
        },
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingApprovalBloc, MeetingApprovalState>(
      builder: (context, state) {
        if (state is MeetingApprovalLoadSuccess) {
          return Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  color: AccentColor,
                  size: 40,
                ),
                radius: 49,
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              Text(
                state.meetingRequest.requesterUserName,
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 6)),
              Text(
                state.meetingRequest.requesterUserDescription,
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          );
        } else {
          return Text('Invalid state type: ${state.runtimeType.toString()}');
        }
      },
    );
  }
}

class _AcceptButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Accept',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        onPressed: () {
          context.bloc<MeetingApprovalBloc>().add(MeetingApprovalApproved());
        },
      ),
    );
  }
}

class _RejectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 2.0,
          color: PrimaryColor,
        ),
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          context.bloc<MeetingApprovalBloc>().add(MeetingApprovalApproved());
        },
        child: Text(
          'Reject',
          style: TextStyle(color: PrimaryColor),
        ),
      ),
    );
  }
}
