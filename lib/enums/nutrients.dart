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

  String get fullName {
    switch (this) {
      case NutrientsEnum.FAT:
        return 'Total Fat';
        break;
      default:
        return this.toString().split('.').last.titleCase;
        break;
    }
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
        break;
    }
  }

  String get description {
    switch (this) {
      case NutrientsEnum.FAT:
        return 'Total fat is the amount of all fats consumed — saturated, unsaturated (monounsaturated and polyunsaturated) and trans fats. Fats are one of the body’s three sources of energy, along with carbohydrates and proteins.';
        break;
      default:
        return '';
        break;
    }
  }
}
