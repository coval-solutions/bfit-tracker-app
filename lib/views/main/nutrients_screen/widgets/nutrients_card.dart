import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/utils/coval_math.dart';
import 'package:bfit_tracker/views/main/nutrients_screen/widgets/nutrient_dialog/nutrient_dialog.dart';
import 'package:flutter/material.dart';

class NutrientsCard extends StatelessWidget {
  final NutrientStat nutrientStat;
  final Color color;

  const NutrientsCard({Key key, this.nutrientStat, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              NutrientDialog(this.nutrientStat.type),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: this.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 22,
              ),
              child: AutoSizeText(
                this.nutrientStat.type.fullName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                minFontSize: 22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                right: 22,
              ),
              child: AutoSizeText.rich(
                TextSpan(
                  text: CovalMath.decimal(
                          double.parse(this.nutrientStat.value ?? 0))
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ' + this.nutrientStat.type.units,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                minFontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
