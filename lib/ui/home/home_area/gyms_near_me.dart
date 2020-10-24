import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/gym/gym_bloc.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GymsNearMe extends StatefulWidget {
  @override
  _GymsNearMeState createState() => _GymsNearMeState();
}

class _GymsNearMeState extends State<GymsNearMe> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymBloc, GymState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (!(state is GymLoaded)) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<List<Gym>>(
          future: BlocProvider.of<GymBloc>(context).state.props.first,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: AutoSizeText('Unable to load gyms near you'),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: AutoSizeText(
                        '${snapshot.data[index].name}',
                        maxLines: 1,
                        maxFontSize: 14,
                      ),
                      subtitle: AutoSizeText(
                        '${snapshot.data[index].address}',
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 10,
                      ),
                      onTap: () {
                        GymController.launchGoogleMaps(
                            snapshot.data[index].lat, snapshot.data[index].lng);
                      });
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 1);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
