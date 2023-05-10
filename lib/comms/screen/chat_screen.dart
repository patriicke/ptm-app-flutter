import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/comms/bloc/user_chat/user_chat_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/comms/screen/user_chat.dart';
import 'package:repository_core/repository_core.dart';

class ChatScreen extends StatelessWidget {
  final String contactUserId;

  ChatScreen(this.contactUserId);

  static Route route(String contactUserId) {
    return MaterialPageRoute<void>(builder: (_) => ChatScreen(contactUserId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      builder: (context, state) {
        return BlocProvider<UserChatBloc>(
          create: (context) {
            return UserChatBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
              chatRepository: RepositoryProvider.of<ChatRepository>(context),
            )..add(ChatMessagesLoaded(contactUserId));
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:
                  state == LoginType.parent ? ParentPrimaryColor : PrimaryColor,
            ),
            body: UserChat(contactUserId),
          ),
        );
      },
    );
  }
}
