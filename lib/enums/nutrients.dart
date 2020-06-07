import 'package:recase/recase.dart';

enum NutrientsEnum {
  FAT,
  SUGAR,
  PROTEIN,
  CARBOHYDRATES,
  CALCIUM,
  FIBRE,
  IRON,
  POTASSIUM,
}

extension NutrientsEnumExtension on NutrientsEnum {
  String get name {
    return this.toString().split('.').last.titleCase;
  }

  String get units {
    switch (this) {
      case NutrientsEnum.CALCIUM:
        return 'mg';
        break;
      case NutrientsEnum.IRON:
        return 'mg';
        break;
      case NutrientsEnum.POTASSIUM:
        return 'mg';
        break;
      default:
        return 'g';
    }
  }
}