import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/exercise.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final Color color;

  const ExerciseListItem({Key key, this.exercise, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 76,
        height: 76,
        color: this.color ?? mainTheme.primaryColor,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: this.exercise.imageLocation,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error, size: 52),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            this.exercise.name,
            minFontSize: 16,
            maxFontSize: 18,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColor.DIM_GRAY,
            ),
          ),
          SizedBox(height: 6),
          AutoSizeText(
            '${this.exercise.seconds} seconds',
            minFontSize: 12,
            maxFontSize: 14,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColor.DIM_GRAY,
            ),
          ),
        ],
      ),
    );
  }
}
