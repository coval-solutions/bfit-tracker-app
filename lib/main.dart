import 'package:bfit_tracker/app.dart';
import 'package:bfit_tracker/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}