import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/notifications/bloc/connection/connection_bloc.dart';

class ConnectionApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectionsState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is ConnectionLoadSuccess) {
          if (state.performedAction == PerformedAction.approved ||
              state.performedAction == PerformedAction.rejected) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<ConnectionBloc, ConnectionsState>(
        builder: (context, state) {
          if (state is ConnectionLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ConnectionLoadSuccess) {
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
          } else if (state is ConnectionLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context.bloc<ConnectionBloc>().add(ConnectionLoaded());
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
    return BlocBuilder<ConnectionBloc, ConnectionsState>(
      builder: (context, state) {
        if (state is ConnectionLoadSuccess) {
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
                state.connectionRequest.parentUserName,
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 6)),
              Text(
                state.connectionRequest.parentUserDescription,
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
          context.bloc<ConnectionBloc>().add(ConnectionApproved());
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
          context.bloc<ConnectionBloc>().add(ConnectionApproved());
        },
        child: Text(
          'Reject',
          style: TextStyle(color: PrimaryColor),
        ),
      ),
    );
  }
}
