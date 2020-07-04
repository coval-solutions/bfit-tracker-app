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
        return 'mcg';
        break;
      default:
        return 'g';
        break;
    }
  }

  String get description {
    switch (this) {
      case NutrientsEnum.CARBOHYDRATES:
        return 'Carbohydrates are used by the body to make glucose — the fuel that gives you energy. Carbohydrates occur in a variety of forms: simple sugars, more complex starches and fibre. Most natural unprocessed foods — vegetables, fruits, legumes and whole grains, for example — are rich in carbohydrates. Other foods like white rice, white bread, cakes and cookies also contain carbohydrates, often in the form of starch of sugar.';
        break;
      case NutrientsEnum.FAT:
        return 'Total fat is the amount of all fats consumed — saturated, unsaturated (monounsaturated and polyunsaturated) and trans fats. Fats are one of the body’s three sources of energy, along with carbohydrates and proteins.';
        break;
      case NutrientsEnum.FIBRE:
        return 'Dietary fibre (also called roughage) is plant matter that humans can\'t digest. Even though your body doesn\'t absorb fibre, it\'s good for you in other ways. In addition to helping you feel fuller with fewer calories, fibre helps keep your digestive tract working well. Fibre is found only in plant products: most fruits, vegetables and whole grains are high in fibre.';
        break;
      case NutrientsEnum.CALCIUM:
        return 'Calcium is a mineral found in many foods. Almost all calcium in your body is stored in bones and teeth to help make and keep them strong. Your body needs calcium to help muscles and blood vessels contract and expand, and to send messages through the nervous system. Calcium is also used to help release hormones and enzymes that affect almost every function in the human body.';
        break;
      case NutrientsEnum.POTASSIUM:
        return 'A type of electrolyte, potassium helps build proteins, break down carbohydrates, build muscle, promote growth, regulate the heart’s electrical activity and control acidity. Too much or too little (hyper or hypokalemia) can cause abnormal heart rhythms. Many foods are great sources, including red meats, soy products, milk, yoghurt, nuts, citrus fruits, cantaloupes, bananas, apricots (especially dried), broccoli, lima beans, tomatoes and potatoes (including their skins).';
        break;
      case NutrientsEnum.VITAMIN_A:
        return 'Contributes to healthy skin, teeth, bony and soft tissues, and mucus membranes. Also called retinol, vitamin A gives pigment to the retina and promotes good vision, particularly in poor light. Dietary sources include eggs, meat, fortified milk, cheese, cream, liver, kidney and fish oil, or (in the form of beta-carotene) yellow and orange fruits, carrots, pumpkins, sweet and potatoes, broccoli, spinach and most dark-green leafy vegetables.';
        break;
      case NutrientsEnum.VITAMIN_C:
        return 'Vitamin C is a water-soluble vitamin that supports normal growth and development. Vitamin C also helps your body absorb iron. Because your body doesn\'t produce or store vitamin C, you need to include it in your diet. For most people, a large orange or a handful of sliced strawberries, chopped red pepper or broccoli provides enough vitamin C for the day. Any extra vitamin C is flushed out of your body in your urine.';
        break;
      case NutrientsEnum.SODIUM:
        return 'Sodium helps maintain the right balance of fluids in your body, helps transmit nerve impulses, and influences muscle contraction and relaxation. Our kidneys naturally balance the amount of sodium stored in your body to maintain optimal health. When your body sodium is low, your kidneys hold on to sodium. When body sodium is high, your kidneys excrete the excess in urine. Most adults consume much more sodium than is needed. It’s found in many prepared and processed foods, including prepared dinners, cold cuts and bacon, soup, condiments and fast foods, In addition, many recipes call for salt, and many people also salt their food at the table.';
        break;
      case NutrientsEnum.PROTEIN:
        return 'Protein is critical for your body to function properly. Among other things, protein creates and maintain your muscles, organs, and much of the body’s other tissues. The word protein comes from the Greek word protos, which means "first" or "of prime importance". Proteins are made of smaller molecules called amino acids. The body produces most amino acids all by itself, but we must get some of them from our diet. Most foods contain at least some protein: good sources include meat, fish eggs, dairy products, nuts, seeds and legumes.';
        break;
      case NutrientsEnum.IRON:
        return 'Iron is a mineral that (among other things) helps transport oxygen throughout the body. Iron deficiency may lead to anaemia, cause fatigue and impair other functions. Lean meats, poultry, fish, beans, legumes and dark-green leafy vegetables are some good dietary iron sources. Eating foods rich in vitamin C at the same time can help your body absorb iron.';
        break;
      case NutrientsEnum.CHOLESTEROL:
        return 'Cholesterol is a fat-like substance found in all cells of the body. It’s used to make hormones, vitamin D and substances that help you digest foods. Your body makes all the cholesterol it needs, but you get extra cholesterol when you eat foods such as meats, liver and other organ meats, dairy foods, egg yolks and shellfish.';
        break;
      case NutrientsEnum.SUGAR:
        return 'Sugar is a simple carbohydrate that gives the body energy. The white granulated table sugar you put in your tea — sucrose from sugar beets or sugar cane — is the only type of sugar. There are many other types, including fructose, found in fruits and honey, and lactose, found in milk, the type of sugar found in our blood, called glucose, is often referred to as "blood sugar". Sugar cane was first cultivated in New Guinea about 10,000 years ago.';
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
