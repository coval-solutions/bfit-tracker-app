import 'package:bfit_tracker/blocs/article/article_bloc.dart';
import 'package:bfit_tracker/ui/home/home_area/articles_card.dart';
import 'package:bfit_tracker/ui/home/home_area/gyms_near_me.dart';
import 'package:bfit_tracker/ui/home/home_area/welcome_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12,
          ),
          child: Column(
            children: <Widget>[
              WelcomeCard(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
              ),
              BlocConsumer<ArticleBloc, ArticleState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (!(state is ArticleLoaded)) {
                      return AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return StreamBuilder(
                        stream: state.props.first,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            return AspectRatio(
                              aspectRatio: 3 / 2,
                              child: state.props.first != null
                                  ? ArticlesCard(snapshot.data)
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
              ),
              Expanded(
                child: NearByGymsCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
