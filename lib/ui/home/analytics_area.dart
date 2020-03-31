import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/enums/weekdays.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';

Widget analyticsArea() {
  return Scaffold(
    appBar: EmptyAppBar(),
    backgroundColor: mainTheme.backgroundColor,
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: AutoSizeText(
              'Your Analytics',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.DIM_GRAY,
              ),
              minFontSize: 26,
              maxFontSize: 26,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6,
            ),
          ),
          WeekDayCards(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6,
            ),
          ),
          StatCards(),
        ],
      ),
    ),
  );
}

class StatCards extends StatefulWidget {
  StatCards({Key key}) : super(key: key);

  @override
  _StatCardsState createState() => _StatCardsState();
}

class _StatCardsState extends State<StatCards> {
  final List<Color> colors = [
    CustomColor.SELECTIVE_YELLOW,
    CustomColor.MAYA_BLUE
  ];

  // TODO: get stats from Firebase and based on date
  var stats = {
    'Heart Rate': {
      'value': 120,
      'unit': 'bpm',
    },
    'Steps': {
      'value': 2349,
      'unit': 'steps',
    },
    'Workouts': {
      'value': 32,
    },
    'Blood': {
      'value': '12/80',
    },
    'Biotin': {
      'value': '73.2%',
    },
    'Respiratory': {
      'value': '30p/60s',
    },
  };

  @override
  Widget build(BuildContext context) {
    // final FitnessDataState fitnessDataState =
    //     BlocProvider.of<FitnessDataBloc>(context).state;

    // print(fitnessDataState);
    // if (fitnessDataState.props.isEmpty) {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    return BlocConsumer<FitnessDataBloc, FitnessDataState>(
      listener: (BuildContext context, FitnessDataState state) {},
      builder: (BuildContext context, FitnessDataState state) {
        if (!(state is FitnessDataLoaded)) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<List<HealthDataPoint>>(
          future: state.props.first,
          builder: (context, snapshot) {
            return Container(
              height: 190,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: this.stats.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = this.stats.keys.elementAt(index);
                    var values = this.stats.values.elementAt(index);
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Container(
                        width: 166,
                        child: Card(
                          elevation: 2,
                          color: this.colors[index % colors.length],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 40,
                                  left: 14,
                                ),
                                child: AutoSizeText(
                                  key,
                                  minFontSize: 22,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 34,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 14,
                                ),
                                child: AutoSizeText.rich(
                                    TextSpan(
                                      text: values['value'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: values['unit'] != null
                                              ? values['unit'].toString()
                                              : '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        );
      },
    );
  }
}

class WeekDayCards extends StatefulWidget {
  WeekDayCards({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeekDayCardsState();
  }
}

class _WeekDayCardsState extends State<WeekDayCards> {
  final DateTime today = DateTime.now();
  final DateTime startDate = DateTime.now().subtract(new Duration(days: 2));
  final DateTime endDate = DateTime.now().add(new Duration(days: 2));

  List<DateTime> days = new List<DateTime>();
  int daySelectedIndex;

  _WeekDayCardsState();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime date = startDate.add(Duration(days: i));
      this.days.add(date);
      if (today.day == date.day) {
        daySelectedIndex = i;
      }
    }
  }

  updateDaySelectedIndex(int index) {
    setState(() {
      this.daySelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            height: 64,
            child: ScrollConfiguration(
              behavior: NoGlowingOverscrollIndicator(),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: this.days.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: index == daySelectedIndex
                        ? weekdayCardSelected(index, this.days)
                        : weekdayCard(index, this.days),
                    onTap: () {
                      setState(() {
                        this.daySelectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget weekdayCard(int index, List<DateTime> days) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 4,
    ),
    child: Container(
      width: 60,
      child: FlatButton(
        color: Colors.white,
        onPressed: null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              days[index].day.toString().padLeft(2, '0'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.DIM_GRAY,
              ),
              minFontSize: 18,
              maxLines: 1,
            ),
            AutoSizeText(
              Weekdays.values
                  .elementAt(days[index].weekday - 1)
                  .toString()
                  .split('.')
                  .last,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColor.DIM_GRAY,
              ),
              minFontSize: 12,
              maxLines: 1,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget weekdayCardSelected(int index, List<DateTime> days) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 4,
    ),
    child: Container(
      width: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey.shade300,
            offset: Offset(0, 0.75),
          )
        ],
      ),
      child: FlatButton(
        color: CustomColor.SELECTIVE_YELLOW,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              days[index].day.toString().padLeft(2, '0'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              minFontSize: 18,
              maxLines: 1,
            ),
            AutoSizeText(
              Weekdays.values
                  .elementAt(days[index].weekday - 1)
                  .toString()
                  .split('.')
                  .last,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              minFontSize: 12,
              maxLines: 1,
            ),
          ],
        ),
      ),
    ),
  );
}
