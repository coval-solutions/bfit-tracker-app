import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NutrientCard extends StatelessWidget {
  final String nutrient;
  final int value;
  final String unit;
  final Color color;

  const NutrientCard(
      {Key key, this.nutrient, this.value, this.unit, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
              this.nutrient ?? '',
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
                text: this.value?.toString() ?? '0',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ' + this.unit,
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
    );
  }
}
