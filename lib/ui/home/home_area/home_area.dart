import 'package:bfit_tracker/ui/home/home_area/articles_card.dart';
import 'package:bfit_tracker/ui/home/home_area/gyms_near_me.dart';
import 'package:bfit_tracker/ui/home/home_area/welcome_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              AspectRatio(
                aspectRatio: 3 / 2,
                child: ArticlesCard(),
              ),
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
