import 'package:expense_tracker/model/category.model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Category {
  AutoFare,
  BusFare,
  BottleWater,
  Food,
  GooglePay,
  Stationary,
  Medical,
}

class CategoryList {
  static List<CategoryModel> list = [
    CategoryModel(
        icon: FontAwesomeIcons.taxi, name: Category.AutoFare.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.taxi, name: Category.BusFare.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.bottleWater,
        name: Category.BottleWater.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.bowlFood, name: Category.Food.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.googlePay,
        name: Category.GooglePay.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.googlePay,
        name: Category.Stationary.categoryName),
    CategoryModel(
        icon: FontAwesomeIcons.googlePay, name: Category.Medical.categoryName),
  ];
}

// extension icon on Category {
//   IconData get getIcon {
//     switch (this) {
//       case Category.AutoFare:
//         return FontAwesomeIcons.taxi;
//       case Category.BusFare:
//         return FontAwesomeIcons.taxi;
//       default:
//         return Icons.money;
//     }
//   }
// }

extension name on Category {
  String get categoryName {
    return this.toString().split('.').last;
  }
}
