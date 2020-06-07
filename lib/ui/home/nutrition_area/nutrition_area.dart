import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:bfit_tracker/ui/coval_solutions/no_glow_listview.dart';
import 'package:bfit_tracker/ui/home/nutrition_area/nutrient_card.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                'Nutrition Tracker',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                ),
                minFontSize: 26,
                maxFontSize: 26,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: AutoSizeText(
                'Weekly',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: CustomColor.DIM_GRAY,
                  fontStyle: FontStyle.italic,
                ),
                minFontSize: 18,
                maxFontSize: 18,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            noGlowListView(
              [
                NutrientCard(
                    nutrient: NutrientsEnum.FAT.name,
                    value: 178,
                    unit: NutrientsEnum.FAT.units,
                    color: mainTheme.primaryColor),
                NutrientCard(
                    nutrient: NutrientsEnum.SUGAR.name,
                    value: 36,
                    unit: NutrientsEnum.SUGAR.units,
                    color: mainTheme.accentColor),
                NutrientCard(
                    nutrient: NutrientsEnum.PROTEIN.name,
                    value: 490,
                    unit: NutrientsEnum.PROTEIN.units,
                    color: mainTheme.primaryColor),
                NutrientCard(
                    nutrient: NutrientsEnum.CARBOHYDRATES.name,
                    value: 540,
                    unit: NutrientsEnum.CARBOHYDRATES.units,
                    color: mainTheme.accentColor),
                NutrientCard(
                    nutrient: NutrientsEnum.CALCIUM.name,
                    value: 480,
                    unit: NutrientsEnum.CALCIUM.units,
                    color: mainTheme.primaryColor),
                NutrientCard(
                    nutrient: NutrientsEnum.FIBRE.name,
                    value: 640,
                    unit: NutrientsEnum.FIBRE.units,
                    color: mainTheme.accentColor),
                NutrientCard(
                    nutrient: NutrientsEnum.IRON.name,
                    value: 480,
                    unit: NutrientsEnum.IRON.units,
                    color: mainTheme.primaryColor),
                NutrientCard(
                    nutrient: NutrientsEnum.POTASSIUM.name,
                    value: 180,
                    unit: NutrientsEnum.POTASSIUM.units,
                    color: mainTheme.accentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
