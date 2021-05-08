import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    final CovalUser user = _authenticationBloc.state.props.first;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: mainTheme.accentColor,
      child: InkWell(
        onTap: () {
          Widget cancelButton = TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          );

          Widget yesButton = TextButton(
            child: Text('Yes, Sign Out'),
            onPressed: () {
              _authenticationBloc.add(LoggedOut());
              Navigator.pop(context);
            },
          );

          AlertDialog alert = AlertDialog(
            title: Text('Confirm Sign Out'),
            content: Text("Are you sure you would like to sign out?"),
            actions: [
              cancelButton,
              yesButton,
            ],
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AutoSizeText(
                  "Welcome back,\n${user.getForename()}!",
                  key: Key('welcomeMessage'),
                  maxLines: 2,
                  maxFontSize: 24,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: user.getDisplayPicture(),
                maxRadius: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
