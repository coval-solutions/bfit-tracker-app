import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArticlesScreen extends StatefulWidget {
  final List<Article> articles;

  ArticlesScreen(this.articles);

  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  var selectedMenuItem;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMenuItem = 'new';
    });
  }

  void setSelectedMenuItem(String key) {
    setState(() {
      selectedMenuItem = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainTheme.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 36,
              ),
              child: AutoSizeText(
                'Latest Articles',
                minFontSize: 24,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {
                      this.setSelectedMenuItem('new');
                    },
                    child: const Text(
                      'New',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: this.selectedMenuItem == 'new'
                        ? Colors.white
                        : mainTheme.primaryColor,
                    textColor: this.selectedMenuItem == 'new'
                        ? mainTheme.primaryColor
                        : Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {
                      this.setSelectedMenuItem('quickRead');
                    },
                    child: const Text(
                      'Quick Read',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: this.selectedMenuItem == 'quickRead'
                        ? Colors.white
                        : mainTheme.primaryColor,
                    textColor: this.selectedMenuItem == 'quickRead'
                        ? mainTheme.primaryColor
                        : Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () {
                      this.setSelectedMenuItem('suggested');
                    },
                    child: const Text(
                      'Suggested',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: this.selectedMenuItem == 'suggested'
                        ? Colors.white
                        : mainTheme.primaryColor,
                    textColor: this.selectedMenuItem == 'suggested'
                        ? mainTheme.primaryColor
                        : Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: EdgeInsets.zero,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.articles.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: sizes.width * 0.54,
                              height: sizes.height * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 28.0,
                                  top: 14.0,
                                  bottom: 14.0,
                                ),
                                child: Card(
                                  color: mainTheme.primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.network(
                                      widget.articles[index].imageUrl,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 42,
                            child: Container(
                              width: sizes.width * 0.46,
                              height: sizes.height * 0.24,
                              child: Card(
                                color: mainTheme.primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                          widget.articles[index].title),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
