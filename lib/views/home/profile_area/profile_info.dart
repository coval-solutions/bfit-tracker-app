import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wiredash/wiredash.dart';

Widget profileInfo(CovalUser user) {
  return Column(
    children: <Widget>[
      Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                onTap: () => Wiredash.of(context).show(),
                child: Icon(
                  Icons.info_outline,
                  color: CustomColor.DIM_GRAY,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              'Your Profile',
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CustomColor.DIM_GRAY,
              ),
              minFontSize: 26,
              maxFontSize: 26,
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                '${user?.getName()}',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CustomColor.DIM_GRAY,
                ),
                minFontSize: 16,
                maxFontSize: 18,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2,
                  bottom: 2,
                ),
              ),
              Row(
                children: <Widget>[
                  AutoSizeText(
                    'beginner',
                    maxLines: 1,
                    style: TextStyle(
                      color: CustomColor.DIM_GRAY,
                    ),
                    maxFontSize: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.cogs,
                    color: CustomColor.DIM_GRAY,
                    size: 18,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 24,
            ),
          ),
          CircleAvatar(
            maxRadius: 40,
            backgroundImage: user.getDisplayPicture(),
          ),
        ],
      ),
    ],
  );
}
