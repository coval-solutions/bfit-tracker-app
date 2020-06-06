import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:flutter/material.dart';

class NutritionArea extends StatefulWidget {
  NutritionArea({Key key}) : super(key: key);

  @override
  _NutritionAreaState createState() => _NutritionAreaState();
}

class _NutritionAreaState extends State<NutritionArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                'Nutrition',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                ),
                minFontSize: 26,
                maxFontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
