import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/gym/gym_bloc.dart';
import 'package:bfit_tracker/blocs/location/location_bloc.dart';
import 'package:bfit_tracker/controllers/gym_controller.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearByGymsCard extends StatefulWidget {
  NearByGymsCard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NearByGymsCardState();
  }
}

class _NearByGymsCardState extends State<NearByGymsCard> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() {
    BlocProvider.of<GymBloc>(context)..add(LoadGym());
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Container(
                    child: AutoSizeText(
                      "Gyms Near Me",
                      maxLines: 1,
                      minFontSize: 18,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: this._refresh,
                    child: BlocConsumer<LocationBloc, LocationState>(
                      listener: (BuildContext context, state) {},
                      builder: (BuildContext context, state) {
                        if (state is LocationError) {
                          // We use a Stack and empty ListView so that
                          // the RefreshIndicator works
                          return Stack(
                            children: <Widget>[
                              Center(
                                child: AutoSizeText(
                                  'BFit Tracker is unable to locate your current position',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ListView()
                            ],
                          );
                        }

                        if (state is Located) {
                          return GymsNearMe();
                        } else {
                          // We use a Stack and empty ListView so that
                          // the RefreshIndicator works
                          return Stack(
                            children: <Widget>[
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                              ListView()
                            ],
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
              // We use a Stack and empty ListView so that
              // the RefreshIndicator works
              return Stack(
                children: <Widget>[
                  Center(
                    child: AutoSizeText(
                      'Unable to load gyms near you',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListView()
                ],
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
