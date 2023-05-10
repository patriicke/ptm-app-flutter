import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetings/consts.dart';
import 'package:formz/formz.dart';
import 'package:meetings/signup/bloc/tell_us_more/tell_us_more_bloc.dart';
import 'package:meetings/signup/screen/profile_completion_screen.dart';

class TellUsMoreForm extends StatelessWidget {
  final headerTextStyle =
      TextStyle(color: PrimaryColor, fontSize: 18, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TellUsMoreBloc, TellUsMoreState>(
      listener: (context, state) {
        if (state is TellUsMoreLoadSuccess) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                ),
              );
          } else if (state.status.isSubmissionSuccess) {
            Navigator.pushReplacement(context, ProfileCompletionScreen.route());
          }
        }
      },
      child: BlocBuilder<TellUsMoreBloc, TellUsMoreState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is TellUsMoreLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TellUsMoreLoadSuccess) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(0, -1 / 3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 110)),
                              Text('Tell us more', style: headerTextStyle),
                              const Padding(padding: EdgeInsets.only(top: 45)),
                              _SchoolNameInput(),
                              const Padding(padding: EdgeInsets.only(top: 25)),
                              _SchoolStateInput(),
                              // const Padding(padding: EdgeInsets.only(top: 20)),
                              // _SchoolCityInput(),
                              const Padding(padding: EdgeInsets.only(top: 30)),
                              _ZipCodeInput(),
                              const Padding(padding: EdgeInsets.only(top: 30)),
                              _ContinueButton(),
                              const Padding(padding: EdgeInsets.only(top: 50)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is TellUsMoreLoadFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.error),
                TextButton(
                  onPressed: () {
                    context.bloc<TellUsMoreBloc>().add(TellUsMoreLoaded());
                  },
                  child: Text('Reload'),
                ),
              ],
            );
          } else
            return Center(child: Text('Invalid state type'));
        },
      ),
    );
  }
}

class _SchoolNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'School Name',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        TextField(
          key: const Key('tellUsMoreForm_schoolNameInput_textField'),
          onChanged: (schoolName) {
            context.bloc<TellUsMoreBloc>().add(SchoolNameUpdated(schoolName));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
          ),
        ),
      ],
    );
  }
}

class _SchoolNameInput1 extends StatelessWidget {
  var _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {

  }
}

class _SchoolStateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TellUsMoreBloc, TellUsMoreState>(
      builder: (context, state) {
        if (state is TellUsMoreLoadSuccess) {
          var dropdownItems = <DropdownMenuItem>[];
          var dropDownField = DropdownButtonFormField(
            key: const Key('tellUsMoreForm_schoolStateInput_textField'),
            onChanged: (schoolState) {
              context
                  .bloc<TellUsMoreBloc>()
                  .add(SchoolStateUpdated(schoolState));
            },
            iconEnabledColor: PrimaryColor,
            decoration: InputDecoration(
              // errorText: state.meetingTitle.errorText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusColor: PrimaryColor,
              hoverColor: PrimaryColor,
            ),
            items: dropdownItems,
          );
          state.cities.forEach((city) {
            dropdownItems.add(DropdownMenuItem(
              child: Text(
                city.cityName,
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
              value: city.cityName,
            ));
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'School State',
                style: TextStyle(fontSize: 16, color: PrimaryColor),
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              dropDownField,
            ],
          );
        } else
          return Text('Invalid state type');
      },
    );
  }
}

class _SchoolCityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'School City',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        DropdownButtonFormField(
          key: const Key('tellUsMoreForm_schoolCityInput_textField'),
          onChanged: (schoolCity) =>
              context.bloc<TellUsMoreBloc>().add(SchoolCityUpdated(schoolCity)),
          iconEnabledColor: PrimaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
          ),
          value: 'None',
          items: [
            DropdownMenuItem(
              child: Text(
                'Select City',
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
              value: 'None',
            ),
            DropdownMenuItem(
              child: Text(
                'New York',
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
              value: 'New York',
            ),
            DropdownMenuItem(
              child: Text(
                'Chicago',
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
              value: 'Chicago',
            ),
            DropdownMenuItem(
              child: Text(
                'San Francisco',
                style: TextStyle(
                  color: PrimaryColor,
                ),
              ),
              value: 'San Francisco',
            ),
          ],
        ),
      ],
    );
  }
}

class _ZipCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Zip Code',
          style: TextStyle(fontSize: 16, color: PrimaryColor),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        TextField(
          key: const Key('tellUsMoreForm_zipCodeInput_textField'),
          onChanged: (schoolZipCode) => context
              .bloc<TellUsMoreBloc>()
              .add(SchoolZipCodeUpdated(schoolZipCode)),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusColor: PrimaryColor,
            hoverColor: PrimaryColor,
          ),
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
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
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        onPressed: () {
          context.bloc<TellUsMoreBloc>().add(TellUsMoreSubmitted());
        },
      ),
    );
  }
}
