import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetings/blocs/login_type/login_type_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:meetings/models/gender.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:meetings/landing/screen/landing_screen.dart';
import 'package:meetings/signup/bloc/profile_completion/profile_completion_bloc.dart';
import 'package:meetings/signup/screen/connect_teachers_screen.dart';
import 'package:meetings/signup/screen/tell_us_more_screen.dart';
import 'package:repository_core/repository_core.dart';

class ProfileCompletionForm extends StatelessWidget {
  final headerTextStyle =
      TextStyle(color: PrimaryColor, fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCompletionBloc, ProfileCompletionState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Profile Completion Failed: ${state.error}'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            LandingScreenNew.route(),
            (route) => false,
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, -1 / 3),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 110)),
                        Text(
                          'Complete your profile',
                          style: headerTextStyle,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 45)),
                        _ProfilePhotoControl(),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        _GenderSelectionControl(),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        _DateOfBirthInput(),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        _SubmitButton(),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 60.0,
                    left: -20,
                    child: _BackButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginTypeBloc, LoginType>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: PrimaryColor,
          ),
          onPressed: () {
            switch (state) {
              case LoginType.unspecified:
                break;
              case LoginType.parent:
                Navigator.push(context, ConnectTeachersScreen.route());
                break;
              case LoginType.teacher:
                Navigator.push(context, TellUsMoreScreen.route());
                break;
            }
          },
        );
      },
    );
  }
}

class _ProfilePhotoControl extends StatefulWidget {
  @override
  _ProfilePhotoControlState createState() => _ProfilePhotoControlState();
}

class _ProfilePhotoControlState extends State<_ProfilePhotoControl> {
  File _image;

  Future imageFromGallery(BuildContext context) async {
    File pickedFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    setState(() {
      if (pickedFile != null) {
        try {
          _image = File(pickedFile.path);
          List<int> imageBytes = _image.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          context
              .bloc<ProfileCompletionBloc>()
              .add(ProfilePhotoUpdated(base64Image));
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  Future imageFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );

    setState(() {
      if (pickedFile != null) {
        log(pickedFile.path);
        context
            .bloc<ProfileCompletionBloc>()
            .add(ProfilePhotoUpdated(pickedFile.path));
        try {
          _image = File(pickedFile.path);
          return;
        } catch (e) {}
      } else {
        print('No image selected');
      }
    });
  }

  void _showPicker(context) {
    final provider = BlocProvider.of<ProfileCompletionBloc>(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: BlocProvider.value(
            value: provider,
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        imageFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imageFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Profile photo',
                style: TextStyle(color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 2.0,
                      color: Color.fromRGBO(185, 210, 235, 1),
                    ),
                  ),
                  height: 78.0,
                  width: 78.0,
                  child: _image != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(_image.path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.all(12),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color.fromRGBO(185, 210, 235, 1),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenderSelectionControl extends StatefulWidget {
  _GenderSelectionControl({Key key}) : super(key: key);
  @override
  _GenderSelectionControlState createState() => _GenderSelectionControlState();
}

class _GenderSelectionControlState extends State<_GenderSelectionControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: TextStyle(color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 6)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: GenderValue.male,
              groupValue:
                  context.bloc<ProfileCompletionBloc>().state.gender.value,
              onChanged: (GenderValue value) {
                setState(() {
                  context
                      .bloc<ProfileCompletionBloc>()
                      .add(GenderUpdated(value));
                });
              },
            ),
            Text(
              'Male',
              style: TextStyle(color: PrimaryColor),
            ),
            const Padding(padding: EdgeInsets.only(right: 50)),
            Radio(
              value: GenderValue.female,
              groupValue:
                  context.bloc<ProfileCompletionBloc>().state.gender.value,
              onChanged: (GenderValue value) {
                setState(() {
                  context
                      .bloc<ProfileCompletionBloc>()
                      .add(GenderUpdated(value));
                });
              },
            ),
            Text(
              'Female',
              style: TextStyle(color: PrimaryColor),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateOfBirthInput extends StatelessWidget {
  final format = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of birth',
          style: TextStyle(color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        DateTimeField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
          ),
          cursorColor: PrimaryColor,
          format: format,
          onChanged: (date) => context
              .bloc<ProfileCompletionBloc>()
              .add(DateOfBirthUpdated(date.toString())),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
              context: context,
              initialDate: currentValue ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionBloc, ProfileCompletionState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(78, 120, 178, 1),
                    textStyle: TextStyle(color: Colors.white, fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      'Create',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                  key: const Key('profileCompletionForm_create_raisedButton'),
                  onPressed: () {
                    context
                        .bloc<ProfileCompletionBloc>()
                        .add(const ProfileCompletionSubmitted());
                  },
                ),
              );
      },
    );
  }
}
