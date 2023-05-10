import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/comms/bloc/contact_selection/contact_selection_bloc.dart';
import 'package:meetings/comms/screen/chat_screen.dart';
import 'package:swagger_api/swagger_api.dart';

import '../../consts.dart';

class ContactSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactSelectionBloc, ContactSelectionState>(
      builder: (context, builderState) {
        if (builderState is ContactSelectionLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (builderState is ContactSelectionLoadSuccess) {
          var parentContactDtos = builderState.contacts
              .where((contact) => contact.contactUserType == 0)
              .toList();
          var teacherContactDtos = builderState.contacts
              .where((contact) => contact.contactUserType == 1);

          var mainColumn = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 24)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Select Contacts',
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Teachers',
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
            ],
          );

          // Add teacher contacts
          teacherContactDtos.forEach((teacher) {
            mainColumn.children.add(_Contact(teacher));
          });

          // Add layout for parents section
          mainColumn.children.add(
            const Padding(padding: EdgeInsets.only(top: 40)),
          );
          mainColumn.children.add(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Parents',
                style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          );
          mainColumn.children.add(
            const Padding(padding: EdgeInsets.only(top: 15)),
          );

          // Add parent contacts
          parentContactDtos.forEach((parent) {
            mainColumn.children.add(_Contact(parent));
          });
          return SingleChildScrollView(
            child: mainColumn,
          );
        } else if (builderState is ContactSelectionLoadFailure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(builderState.error),
              TextButton(
                onPressed: () {
                  context
                      .bloc<ContactSelectionBloc>()
                      .add(ContactSelectionLoaded());
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

class _Contact extends StatelessWidget {
  const _Contact(this.contact);
  // final String contactName;
  final SearchContactDto contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: IconButton(
          icon: Icon(Icons.person, color: AccentColor),
          color: Colors.grey[200],
          disabledColor: Colors.grey[200],
          onPressed: () {},
        ),
      ),
      title: Text(
        contact.contactUserName,
        style: TextStyle(
          fontSize: 15,
          color: PrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(contact.contactUserId));
      },
    );
  }
}
