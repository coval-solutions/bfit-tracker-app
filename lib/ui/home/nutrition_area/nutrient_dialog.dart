import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NutrientDialog extends StatelessWidget {
  final NutrientsEnum nutrientsEnum;

  NutrientDialog({
    @required this.nutrientsEnum,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(this.nutrientsEnum, context),
    );
  }
}

dialogContent(NutrientsEnum nutrientsEnum, BuildContext buildContext) {
  return Stack(
    children: <Widget>[
      Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12.0,
              offset: const Offset(0.0, 12.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(buildContext).pop();
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28, left: 16),
                        child: SvgPicture.asset(
                          'assets/images/left-pointing-arrow.svg',
                          color: CustomColor.DIM_GRAY,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: AutoSizeText(
                        nutrientsEnum.fullName,
                        style: TextStyle(
                          color: CustomColor.DIM_GRAY,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 26,
                        maxFontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.0),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: AutoSizeText(
                    nutrientsEnum.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColor.DIM_GRAY,
                      fontWeight: FontWeight.bold,
                    ),
                    maxFontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Container(
                width: MediaQuery.of(buildContext).size.width / 2,
                child: TextField(
                  maxLines: 1,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintMaxLines: 1,
                      hintText: "Enter value (${nutrientsEnum.units})"),
                ),
              ),
              SizedBox(height: 32.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoButton(
                  color: mainTheme.buttonColor,
                  onPressed: () {
                    Navigator.of(buildContext).pop();
                  },
                  child: AutoSizeText(
                    'Confirm',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    minFontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ],
  );
}
