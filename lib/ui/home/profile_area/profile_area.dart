import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:bfit_tracker/ui/home/profile_area/profile_info.dart';
import 'package:bfit_tracker/ui/home/profile_area/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileArea extends StatefulWidget {
  final UserInfo _userInfo;

  ProfileArea(this._userInfo);

  @override
  _ProfileAreaState createState() => _ProfileAreaState();
}

class _ProfileAreaState extends State<ProfileArea> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _authenticationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    if (_authenticationBloc == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: EmptyAppBar(),
      backgroundColor: mainTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          children: <Widget>[
            profileInfo(_authenticationBloc.state.props.first),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ),
            ),
            Expanded(
              child: noGlowListView(
                <Widget>[
                  totalGymTimeStat(widget._userInfo.goals.getGym() / 100),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child: otherStats(
                                widget._userInfo.goals.getBmi(), 'BMI Goal')),
                      ),
                      Expanded(
                        child: Container(
                            child: otherStats(
                                widget._userInfo.goals.getWeight(),
                                'Weight Goal',
                                unit: 'kg')),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child: otherStats(
                                widget._userInfo.goals.getCourses(),
                                'Course Total')),
                      ),
                      Expanded(
                        child: Container(
                            child: otherStats(80, 'Daily Steps', unit: '%')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
