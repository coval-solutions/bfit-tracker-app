import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/controllers/article_controller.dart';
import 'package:bfit_tracker/models/article.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_image_card.dart';
import 'package:bfit_tracker/ui/home/home_area/articles/article_info_card.dart';
import 'package:flutter/material.dart';

class ArticlesSelectionScreen extends StatefulWidget {
  final List<Article> articles;

  ArticlesSelectionScreen(this.articles);

  @override
  _ArticlesSelectionScreenState createState() =>
      _ArticlesSelectionScreenState();
}

class _ArticlesSelectionScreenState extends State<ArticlesSelectionScreen> {
  var selectedMenuItem;
  var articleViewCounts;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedMenuItem = 'new';
      articleViewCounts = this.getArticleViewedCount();
    });
  }

  void setSelectedMenuItem(String key) {
    setState(() {
      selectedMenuItem = key;
    });
  }

  Future<void> getArticleViewedCount() async {
    return await ArticleController.fetchArticleViewedCount();
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
                  child: ElevatedButton(
                    onPressed: () {
                      this.setSelectedMenuItem('new');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: this.selectedMenuItem == 'new'
                          ? Colors.white
                          : mainTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: AutoSizeText(
                      'New',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: this.selectedMenuItem == 'new'
                              ? mainTheme.primaryColor
                              : Colors.white.withOpacity(0.5)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      this.setSelectedMenuItem('quickRead');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: this.selectedMenuItem == 'quickRead'
                          ? Colors.white
                          : mainTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: AutoSizeText(
                      'Quick Read',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: this.selectedMenuItem == 'quickRead'
                              ? mainTheme.primaryColor
                              : Colors.white.withOpacity(0.5)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      this.setSelectedMenuItem('suggested');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      primary: this.selectedMenuItem == 'suggested'
                          ? Colors.white
                          : mainTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: AutoSizeText(
                      'Suggested',
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: this.selectedMenuItem == 'suggested'
                              ? mainTheme.primaryColor
                              : Colors.white.withOpacity(0.5)),
                    ),
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: FutureBuilder(
                  future: ArticleController.fetchArticleViewedCount(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<dynamic> viewCountPerArticle = snapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.articles.length,
                        itemBuilder: (context, index) {
                          Article currentArticle = widget.articles[index];
                          var viewCountForCurrentArticle = 0;
                          if (viewCountPerArticle != null) {
                            viewCountForCurrentArticle =
                                (viewCountPerArticle.firstWhere((element) =>
                                            element['article_doc_ref'] ==
                                            currentArticle.docRef)
                                        as Map<String, dynamic>)['count'] ??
                                    0;
                          }
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
                                    child: ArticleImageCard(
                                      widget.articles[index].imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 42,
                                child: Container(
                                  width: sizes.width * 0.46,
                                  height: sizes.height * 0.24,
                                  child: ArticleInfoCard(
                                    article: currentArticle,
                                    viewCount: viewCountForCurrentArticle,
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
