import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EquipmentPill extends StatelessWidget {
  final Color pillColor;
  final Color borderColor;
  final Color textColor;
  final String equipment;

  const EquipmentPill(
      {@required this.pillColor,
      @required this.borderColor,
      @required this.textColor,
      this.equipment = '',
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: this.pillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: this.borderColor),
        ),
      ),
      child: AutoSizeText(
        equipment.isNotEmpty ? equipment : 'No equipment',
        minFontSize: 12,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
