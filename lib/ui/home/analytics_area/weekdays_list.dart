import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/fitness_data/fitness_data_bloc.dart';
import 'package:bfit_tracker/enums/weekdays.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class WeekDayList extends StatefulWidget {
  WeekDayList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeekDayListState();
  }
}

class _WeekDayListState extends State<WeekDayList> {
  DateTime _today;
  FitnessDataBloc _fitnessDataBloc;

  List<DateTime> days = new List<DateTime>();

  _WeekDayListState();

  @override
  void initState() {
    super.initState();
    this._fitnessDataBloc = BlocProvider.of<FitnessDataBloc>(context);

    this._today = Jiffy().startOf(Units.DAY);
    this.days.add(_today);

    DateTime dateTime = this._today;
    for (int i = 0; i < 4; i++) {
      dateTime = dateTime.subtract(Duration(days: 1));
      this.days.add(dateTime);
    }
  }

  updateDateSelected(DateTime dateTimeSelected) {
    if (this._fitnessDataBloc != null) {
      this._fitnessDataBloc.add(SetDateSelected(dateTimeSelected));
    }
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
                  return BlocConsumer<FitnessDataBloc, FitnessDataState>(
                      listener: (context, state) {},
                      builder: (BuildContext context, FitnessDataState state) {
                        if (state is FitnessDataLoaded) {
                          return GestureDetector(
                            child: index == this.days.indexOf(state.props.last)
                                ? weekdayCardSelected(index, this.days)
                                : weekdayCard(index, this.days),
                            onTap: () {
                              updateDateSelected(this.days[index]);
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      });
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
