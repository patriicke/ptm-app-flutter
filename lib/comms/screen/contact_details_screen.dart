import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/comms/bloc/contact_details/contact_details_bloc.dart';
import 'package:meetings/comms/screen/chat_contact_details.dart';
import 'package:repository_core/repository_core.dart';

class ChatContactDetailsScreen extends StatelessWidget {
  final String contactUserId;
  final String contactUserDescription;
  final int contactUserType;
  ChatContactDetailsScreen(
      this.contactUserId, this.contactUserType, this.contactUserDescription);

  static Route route(String contactUserId, int contactUserType,
      String contactUserDescription) {
    return MaterialPageRoute<void>(
        builder: (_) => ChatContactDetailsScreen(
            contactUserId, contactUserType, contactUserDescription));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: BlocProvider(
        create: (context) {
          return ContactDetailsBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
            chatRepository: RepositoryProvider.of<ChatRepository>(context),
          )..add(ContactDetailsLoaded(
              contactUserId, contactUserType, contactUserDescription));
        },
        child: ChatContactDetails(
            contactUserId, contactUserType, contactUserDescription),
      ),
    );
  }
}
