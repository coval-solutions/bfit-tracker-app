import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/enums/weekdays.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/no_glow_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekDayList extends StatefulWidget {
  final List<DateTime> days;

  WeekDayList({Key key, @required this.days}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeekDayListState(days: this.days.reversed.toList());
  }
}

class _WeekDayListState extends State<WeekDayList> {
  //ignore: close_sinks
  FitnessDataBloc fitnessDataBloc;
  List<DateTime> days;

  _WeekDayListState({Key key, @required this.days});

  @override
  void initState() {
    super.initState();
    setState(() {
      fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);
    });
  }

  updateDateSelected(DateTime dateTimeSelected) {
    fitnessDataBloc.add(SetDateSelected(dateTimeSelected));
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
                    child: index ==
                            this.days.indexOf(fitnessDataBloc.state.props.last)
                        ? weekdayCardSelected(index, this.days)
                        : weekdayCard(index, this.days),
                    onTap: () {
                      updateDateSelected(this.days[index]);
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
              WeekdaysEnum.values
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey.shade300,
            offset: Offset(0, 0.75),
          )
        ],
      ),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 6),
        color: mainTheme.buttonColor,
        minSize: 60,
        onPressed: () {},
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
              WeekdaysEnum.values
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
