import 'package:bfit_tracker/app.dart';
import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/blocs/user_info/user_info_bloc.dart';
import 'package:bfit_tracker/repositories/user_info_repository.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:bfit_tracker/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final UserInfoRepository userInfoRepository = UserInfoRepository();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
            userRepository: userRepository,
          )
          ..add(AppStarted()),
        ),
        BlocProvider<UserInfoBloc>(
          create: (BuildContext context) => UserInfoBloc(
            user: context.bloc<AuthenticationBloc>().state.props.first,
            userInfoRepository: userInfoRepository,
          )
          ..add(LoadUserInfo()),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return App();
        }
      ),
    ),
  );
}
