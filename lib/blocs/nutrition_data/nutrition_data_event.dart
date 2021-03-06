part of 'nutrition_data_bloc.dart';

abstract class NutritionDataEvent extends Equatable {
  const NutritionDataEvent();

  @override
  List<Object> get props => [];
}

class LoadNutritionData extends NutritionDataEvent {
  final DateTime startDateTime;
  final DateTime endDateTime;

  LoadNutritionData({DateTime startDateTime, DateTime endDateTime})
      : startDateTime = startDateTime ??
            ((Jiffy()..startOf(Units.DAY))
                  ..subtract(
                      duration:
                          Duration(days: NutritionDataBloc.numOfDaysInThePast)))
                .dateTime,
        endDateTime = endDateTime ?? DateTime.now();

  @override
  List<Object> get props => [this.startDateTime, this.endDateTime];

  @override
  String toString() =>
      "LoadNutritionData { startDateTime: ${this.startDateTime} endDateTime: ${this.endDateTime} }";
}

class AddNutritionData extends NutritionDataEvent {
  final Map<NutritionEnum, double> nutrients;
  final DateTime dateTime;

  AddNutritionData(this.nutrients, {DateTime dateTime})
      : dateTime = dateTime ?? DateTime.now();

  @override
  List<Object> get props => [this.nutrients, this.dateTime];

  @override
  String toString() =>
      "AddNutritionData { nutrients: ${this.nutrients} dateTime: ${this.dateTime} }";
}

class SetDateSelected extends NutritionDataEvent {
  final DateTime _dateSelected;

  SetDateSelected(dateSelected) : _dateSelected = dateSelected;

  @override
  List<Object> get props => [this._dateSelected];

  @override
  String toString() =>
      "SetDateSelected { dateSelected: ${this._dateSelected} }";
}
