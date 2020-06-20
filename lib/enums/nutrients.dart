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
  VITAMIN_A,
  VITAMIN_C,
  SODIUM,
  CHOLESTEROL,
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
      case NutrientsEnum.IRON:
      case NutrientsEnum.POTASSIUM:
      case NutrientsEnum.SODIUM:
      case NutrientsEnum.CHOLESTEROL:
        return 'mg';
        break;
      case NutrientsEnum.VITAMIN_A:
        return 'IV';
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

  static Map<String, NutrientsEnum> map() {
    return {
      'total_carbs': NutrientsEnum.CARBOHYDRATES,
      'total_fat': NutrientsEnum.FAT,
      'fiber': NutrientsEnum.FIBRE,
      'calcium': NutrientsEnum.CALCIUM,
      'potassium': NutrientsEnum.POTASSIUM,
      'vitamin_a': NutrientsEnum.VITAMIN_A,
      'vitamin_c': NutrientsEnum.VITAMIN_C,
      'sodium': NutrientsEnum.SODIUM,
      'protein': NutrientsEnum.PROTEIN,
      'iron': NutrientsEnum.IRON,
      'cholesterol': NutrientsEnum.CHOLESTEROL,
      'sugar': NutrientsEnum.SUGAR,
    };
  }
}
