import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/enums/weekdays.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekDayList extends StatefulWidget {
  WeekDayList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeekDayListState();
  }
}

class _WeekDayListState extends State<WeekDayList> {
  final DateTime _today = DateTime.now();
  FitnessDataBloc _fitnessDataBloc;

  List<DateTime> days = new List<DateTime>();
  int daySelectedIndex;

  _WeekDayListState();

  @override
  void initState() {
    super.initState();
    this._fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);

    this.days.add(_today);

    DateTime dateTime = _today;
    for (int i = 0; i < 4; i++) {
      dateTime = dateTime.subtract(Duration(days: 1));
      this.days.add(dateTime);
    }

    daySelectedIndex = 0;
  }
  
  @override
  void dispose() {
    super.dispose();
    _fitnessDataBloc.close();
  }

  updateDaySelectedIndex(int index) {
    setState(() {
      this.daySelectedIndex = index;
    });

    DateTime dateTimeSelected = this.days[index];
    this._fitnessDataBloc.add(LoadFitnessData(DateTime.utc(
        dateTimeSelected.year, dateTimeSelected.month, dateTimeSelected.day)));
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
                      updateDaySelectedIndex(index);
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
