// /*
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bfit_tracker/enums/nutrients.dart';
// import 'package:bfit_tracker/utils/coval_math.dart';
// import 'package:bfit_tracker/views/home/nutrition_area/nutrient_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:nutrition/nutrition_enum.dart';
//
// class NutrientCard extends StatelessWidget {
//   final NutritionEnum nutritionEnum;
//   final double value;
//   final Color color;
//
//   const NutrientCard({Key key, this.nutritionEnum, this.value, this.color})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) =>
//               NutrientDialog(nutrientsEnum: this.nutritionEnum),
//         );
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         color: this.color,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 16,
//                 bottom: 16,
//                 left: 22,
//               ),
//               child: AutoSizeText(
//                 this.nutritionEnum.name ?? '',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//                 minFontSize: 22,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 16,
//                 bottom: 16,
//                 right: 22,
//               ),
//               child: AutoSizeText.rich(
//                 TextSpan(
//                   text: CovalMath.decimal(this.value ?? 0).toString(),
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: ' ' + this.nutritionEnum.units,
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//                 minFontSize: 22,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// */
