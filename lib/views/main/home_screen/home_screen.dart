import 'package:bfit_tracker/controllers/home_controller.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/article_list.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/gyms_near_me_list.dart';
import 'package:bfit_tracker/views/main/home_screen/widgets/welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onInit,
      child: SingleChildScrollView(
        child: Column(
          children: [
            WelcomeCard(),
            // TODO: upon release of the BFit website, re-do articles section
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: Obx(() =>
            //       controller.articles == null || controller.articles.isEmpty
            //           ? CircularProgressIndicator()
            //           : ArticleList()),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GymsNearMeList(),
            ),
          ],
        ),
      ),
    );
  }
}
