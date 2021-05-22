import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/home_controller.dart';
import 'package:bfit_tracker/models/gym.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GymsNearMeList extends GetView<HomeController> {
  const GymsNearMeList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AutoSizeText(
                'Gyms Near Me',
                maxLines: 1,
                minFontSize: 18,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () =>
                  controller.gymsNearMe == null || controller.gymsNearMe.isEmpty
                      ? CircularProgressIndicator()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: controller.gymsNearMe.length,
                          separatorBuilder: (context, index) {
                            return Divider(height: 1);
                          },
                          itemBuilder: (context, index) {
                            Gym gym = controller.gymsNearMe[index];
                            return ListTile(
                              title: AutoSizeText(
                                '${gym.name}',
                                maxLines: 1,
                                maxFontSize: 14,
                              ),
                              subtitle: AutoSizeText(
                                '${gym.address}',
                                maxLines: 1,
                                minFontSize: 8,
                                maxFontSize: 10,
                              ),
                              onTap: () {
                                controller.launchGoogleMaps(gym.lat, gym.lng);
                              });
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
