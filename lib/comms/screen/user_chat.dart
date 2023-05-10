import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/authentication/authentication.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/comms/bloc/user_chat/user_chat_bloc.dart';
import 'package:meetings/comms/screen/contact_details_screen.dart';
import 'package:meetings/models/user_message.dart';
import 'package:repository_core/repository_core.dart';
import 'package:swagger_api/swagger_api.dart';
import 'package:formz/formz.dart';

import '../../consts.dart';

class UserChat extends StatelessWidget {
  final String contactUserId;

  UserChat(this.contactUserId);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserChatBloc, UserChatState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is ChatLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ChatLoadSuccess) {
          return Column(
            children: [
              _UserHeader(),
              Expanded(
                child: _MessagesContainer(),
                flex: 10,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: _MessageInput(),
              ),
            ],
          );
        } else if (state is ChatLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              TextButton(
                onPressed: () {
                  context
                      .bloc<UserChatBloc>()
                      .add(ChatMessagesLoaded(contactUserId));
                },
                child: Text('Reload'),
              ),
            ],
          );
        } else {
          return Center(
            child: Text('Invalid state type'),
          );
        }
      },
    );
  }
}

class _UserHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, loginType) {
        return BlocBuilder<UserChatBloc, UserChatState>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.topCenter,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                tileColor: Colors.grey[300],
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.person,
                      color: loginType == LoginType.parent
                          ? ParentAccentColor
                          : AccentColor,
                    ),
                    color: AccentColor,
                    disabledColor: Colors.grey[200],
                    onPressed: () {
                      var stateVal = (state as ChatLoadSuccess);

                      var contactUserId = stateVal.contactUserId;
                      var contactUserDescription =
                          stateVal.contactUserDescription;
                      var contactUserType = stateVal.contactUserType;
                      Navigator.push(
                          context,
                          ChatContactDetailsScreen.route(contactUserId,
                              contactUserType, contactUserDescription));
                    },
                  ),
                ),
                title: Text(
                  (state as ChatLoadSuccess).contactUserName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  (state as ChatLoadSuccess).contactUserDescription,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  Icons.more_vert,
                  color: PrimaryColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _MessagesContainer extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserChatBloc, UserChatState>(
      listener: (context, state) {
        if (state is ChatLoadSuccess) {
          _scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }
      },
      child: BlocBuilder<LoginTypeBloc, LoginType>(
        builder: (context, loginType) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
              return BlocBuilder<UserChatBloc, UserChatState>(
                builder: (context, chatState) {
                  var mainColumn = Column(
                    children: [],
                  );
                  var messageBubbles = <Widget>[];
                  for (var message in (chatState as ChatLoadSuccess).messages) {
                    mainColumn.children.add(
                        _MessageBubble(message, authState.user, loginType));
                    messageBubbles.add(
                        _MessageBubble(message, authState.user, loginType));
                  }
                  return ListView(
                    children: messageBubbles.reversed.toList(),
                    controller: _scrollController,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    // child: Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 30),
                    //   child: mainColumn,
                    // ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble(this.message, this.currentUser, this.loginType);
  final ChatMessage message;
  final UserEntity currentUser;
  final LoginType loginType;

  bool get _byMe {
    return message.byUserId == currentUser.id;
  }

  Color _getMyMessageColor(LoginType loginType) {
    if (_byMe && loginType == LoginType.parent) {
      return ParentAccentColor;
    } else if (_byMe) {
      return PrimaryColor;
    } else {
      return Colors.grey[300];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Align(
        alignment: _byMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: _getMyMessageColor(loginType),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(message.body),
        ),
      ),
    );
    ;
  }
}

class _MessageInput extends StatelessWidget {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserChatBloc, UserChatState>(
      listenWhen: (previous, current) =>
          (previous as ChatLoadSuccess).textMessageStatus !=
          (current as ChatLoadSuccess).textMessageStatus,
      listener: (context, state) {
        if (state is ChatLoadSuccess) {
          if (state.textMessageStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.messageSubmissionError}'),
                ),
              );
          } else if (state.textMessageStatus.isSubmissionSuccess) {
            _textController.text = '';
          }
        }
      },
      child: BlocBuilder<UserChatBloc, UserChatState>(
        buildWhen: (previous, current) =>
            (previous as ChatLoadSuccess).textMessageStatus !=
            (current as ChatLoadSuccess).textMessageStatus,
        builder: (context, state) {
          if (state is ChatLoadSuccess) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: _textController,
                  key: const Key('createReportForm_studentNameInput_textField'),
                  enabled: !state.textMessageStatus.isSubmissionInProgress,
                  onChanged: (text) {
                    context.bloc<UserChatBloc>().add(MessageUpdated(text));
                  },
                  decoration: InputDecoration(
                    // errorText: state.meetingTitle.errorText(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusColor: PrimaryColor,
                    hoverColor: PrimaryColor,
                    fillColor: Colors.grey[300],
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      color: PrimaryColor,
                      onPressed: state.textMessageStatus.isValidated
                          ? () => context
                              .bloc<UserChatBloc>()
                              .add(MessageSubmitted())
                          : null,
                    ),
                  ),
                ),
              ),
            );
          } else
            return Text('Invalid state type');
        },
      ),
    );
  }
}
