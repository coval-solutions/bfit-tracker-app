import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/enums/weekdays.dart';
import 'package:bfit_tracker/models/stats.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget analyticsArea() {
  return Scaffold(
    appBar: EmptyAppBar(),
    backgroundColor: mainTheme.backgroundColor,
    body: Padding(
      padding: const EdgeInsets.symmetric(
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
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
          ),
          WeekDayCards(),
          Padding(
            padding: const EdgeInsets.symmetric(
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FitnessDataBloc, FitnessDataState>(
      listener: (BuildContext context, FitnessDataState state) {},
      builder: (BuildContext context, FitnessDataState state) {
        if (!(state is FitnessDataLoaded)) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder<Stats>(
            future: state.props.first,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: 190,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      StatCard(
                        title: Stats.HEART_RATE_NAME,
                        value: snapshot.data.heartRate.toString(),
                        unit: Stats.HEART_RATE_UNIT,
                      ),
                      StatCard(
                        title: Stats.STEPS_NAME,
                        value: snapshot.data.steps.toString(),
                        unit: Stats.STEPS_UNIT,
                        color: CustomColor.MAYA_BLUE
                      ),
                      StatCard(
                        title: Stats.WORKOUTS_COMPLETE_NAME,
                        value: '30',
                      ),
                      StatCard(
                        title: Stats.BLOOD_PRESSURE_NAME,
                        value: "${snapshot.data.bloodPressureSystolic}/${snapshot.data.bloodPressureDiastolic}",
                        color: CustomColor.MAYA_BLUE
                      ),
                      StatCard(
                        title: Stats.BIOTIN_LEVELS_NAME,
                        value: '73.2',
                        unit: Stats.BIOTIN_LEVELS_UNIT,
                      ),
                      StatCard(
                        title: Stats.RESPIRATORY_RATE_NAME,
                        value: '30p/60s',
                        color: CustomColor.MAYA_BLUE
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard(
      {Key key, this.title = '', this.value = '', this.unit = '', this.color})
      : super(key: key);

  final String title;
  final String value;
  final String unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Container(
        width: 166,
        child: Card(
          elevation: 2,
          color: this.color ?? mainTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 14,
                ),
                child: AutoSizeText(
                  this.title,
                  minFontSize: 22,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 34,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                ),
                child: AutoSizeText.rich(
                    TextSpan(
                      text: this.value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: this.unit,
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

  List<DateTime> days = new List<DateTime>();
  int daySelectedIndex;

  _WeekDayCardsState();

  @override
  void initState() {
    super.initState();

    this.days.add(today);

    DateTime dateTime = today;
    for (int i = 0; i < 4; i++) {
      dateTime = dateTime.subtract(Duration(days: 1));
      this.days.add(dateTime);
    }

    daySelectedIndex = 0;
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
                reverse: true,
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
    padding: const EdgeInsets.symmetric(
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
    padding: const EdgeInsets.symmetric(
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
