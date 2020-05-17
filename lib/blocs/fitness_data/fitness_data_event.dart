part of 'fitness_data_bloc.dart';

abstract class FitnessDataEvent extends Equatable {
  const FitnessDataEvent();

  @override
  List<Object> get props => [];
}

class LoadFitnessData extends FitnessDataEvent {
  final DateTime startDateTime;

  LoadFitnessData({DateTime startDateTime})
      : startDateTime = startDateTime ??
            Jiffy()
                .startOf(Units.DAY)
                .subtract(Duration(days: FitnessDataBloc.numOfDaysInThePast));

  @override
  List<Object> get props => [this.startDateTime];

  @override
  String toString() =>
      "LoadFitnessData { startDateTime: ${this.startDateTime} }";
}

class SetDateSelected extends FitnessDataEvent {
  final DateTime _dateSelected;

  SetDateSelected(dateSelected) : _dateSelected = dateSelected;

  @override
  List<Object> get props => [this._dateSelected];

  @override
  String toString() =>
      "SetDateSelected { dateSelected: ${this._dateSelected} }";
}
