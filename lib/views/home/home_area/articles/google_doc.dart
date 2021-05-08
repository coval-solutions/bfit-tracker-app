import 'package:bfit_tracker/models/article_image.dart';
import 'package:bfit_tracker/utils/google_api_client.dart';
import 'package:bfit_tracker/views/coval_solutions/no_glow_listview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;
import 'package:kt_dart/kt.dart';

class GoogleDoc extends StatefulWidget {
  @override
  _GoogleDocState createState() => _GoogleDocState();
}

class _GoogleDocState extends State<GoogleDoc> {
  List<docsV1.StructuralElement> _listItems = [];
  Map<String, ArticleImage> _imagesData = {};
  bool _contentLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _contentLoaded
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ScrollConfiguration(
                behavior: NoGlowingOverscrollIndicator(),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final element = _listItems[index];
                    return _elementToWidget(element);
                  },
                  itemCount: _listItems.length,
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _loadDocument() async {
    final client = await GoogleApiClient.create(context, useAccessToken: true);
    final docsApi = docsV1.DocsApi(client);
    var document = await docsApi.documents
        .get('18j4mySvYQxdktF2Xc_CDMLw7AGc_MjqwTruwsBnF-rc');
    _parseDocument(document);
  }

  Future<void> _parseDocument(docsV1.Document document) async {
    var content = KtList.from(document.body.content);

    final elements = content
        .mapNotNull(
          (element) => (element?.paragraph?.elements != null ||
                  element?.paragraph?.positionedObjectIds != null)
              ? element
              : null,
        )
        .asList();

    var inlineObjects = emptyMap<String, ArticleImage>();
    if (document.inlineObjects?.isNotEmpty == true) {
      inlineObjects = KtMap.from(document.inlineObjects).map((inlineObject) {
        var embeddedObject =
            inlineObject.value.inlineObjectProperties.embeddedObject;
        return KtPair(
          inlineObject.key,
          ArticleImage(
            url: embeddedObject.imageProperties.contentUri,
            width: embeddedObject.size.width.magnitude,
            height: embeddedObject.size.height.magnitude,
          ),
        );
      }).associate((pair) => pair);
    }

    var positionedObjects = emptyMap<String, ArticleImage>();
    if (document.positionedObjects?.isNotEmpty == true) {
      positionedObjects =
          KtMap.from(document.positionedObjects).map((positionedObject) {
        var embeddedObject =
            positionedObject.value.positionedObjectProperties.embeddedObject;
        return KtPair(
          positionedObject.key,
          ArticleImage(
            url: embeddedObject.imageProperties.contentUri,
            width: embeddedObject.size.width.magnitude,
            height: embeddedObject.size.height.magnitude,
          ),
        );
      }).associate((pair) => pair);
    }

    setState(() {
      _listItems = elements;
      _imagesData = inlineObjects.plus(positionedObjects).asMap();
      _contentLoaded = true;
    });
  }

  Widget _elementToWidget(docsV1.StructuralElement element) {
    final alignment =
        _getAlignment(element.paragraph.paragraphStyle?.alignment);
    final paragraphSpans = KtList.from(element.paragraph.elements)
        .mapNotNull((element) => element?.textRun)
        .map(
      (textRun) {
        if (textRun.textStyle != null) {
          return TextSpan(
            text: textRun.content,
            style: _getTextStyle(
              element.paragraph.paragraphStyle?.namedStyleType,
              textRun.textStyle,
            ),
          );
        } else {
          return TextSpan(text: textRun.content);
        }
      },
    );

    var paragraphText = paragraphSpans.isNotEmpty()
        ? Container(
            width: double.infinity,
            child: RichText(
              textAlign: alignment,
              text: TextSpan(
                children: paragraphSpans.asList(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        : null;

    var paragraphInlineImages = [];
    if (element.paragraph.elements != null) {
      paragraphInlineImages = KtList.from(element.paragraph.elements)
          .mapNotNull((element) => element.inlineObjectElement?.inlineObjectId)
          .map((String objectId) => _imagesData[objectId])
          .map((ArticleImage imgData) {
        return CachedNetworkImage(
          imageUrl: imgData.url,
          width: imgData.width,
          height: imgData.height,
        );
      }).asList();
    }

    var paragraphPositionedImages = [];
    if (element.paragraph.positionedObjectIds != null) {
      paragraphPositionedImages =
          KtList.from(element.paragraph.positionedObjectIds)
              .map((String objectId) {
        return _imagesData[objectId];
      }).map((ArticleImage imgData) {
        return CachedNetworkImage(
          imageUrl: imgData.url,
          width: imgData.width,
          height: imgData.height,
        );
      }).asList();
    }

    final hasImages = (paragraphInlineImages.isNotEmpty == true) ||
        (paragraphPositionedImages.isNotEmpty == true);

    return hasImages
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...paragraphInlineImages,
              ...paragraphPositionedImages,
              if (paragraphText != null) paragraphText,
            ],
          )
        : (paragraphText != null)
            ? paragraphText
            : Container();
  }

  TextStyle _getTextStyle(String paragraphStyle, docsV1.TextStyle textStyle) {
    final fontSize = _getFontSize(paragraphStyle);

    final foregroundColor = textStyle?.foregroundColor?.color?.rgbColor;
    final backgroundColor = textStyle?.backgroundColor?.color?.rgbColor;
    Color textColor;
    if (foregroundColor != null) {
      textColor = colorFromRGBO(foregroundColor);
    } else {
      textColor =
          paragraphStyle == 'SUBTITLE' ? Colors.black.withOpacity(0.5) : null;
    }
    Color textBgColor;
    if (backgroundColor != null) {
      textBgColor = colorFromRGBO(backgroundColor);
    }

    return TextStyle(
      fontSize: fontSize,
      color: textColor,
      backgroundColor: textBgColor,
      fontWeight: textStyle.bold == true ? FontWeight.bold : null,
      fontStyle: textStyle.italic == true ? FontStyle.italic : null,
      decoration: textStyle.underline == true ? TextDecoration.underline : null,
    );
  }

  Color colorFromRGBO(docsV1.RgbColor foregroundColor) {
    return Color.fromRGBO(
      ((foregroundColor.red ?? 0) * 255).toInt(),
      ((foregroundColor.green ?? 0) * 255).toInt(),
      ((foregroundColor.blue ?? 0) * 255).toInt(),
      1,
    );
  }

  double _getFontSize(String styleType) {
    switch (styleType) {
      case 'TITLE':
        return 30.0;
      case 'SUBTITLE':
        return 16.0;
      case 'HEADING_1':
        return 24.0;
      case 'HEADING_2':
        return 22.0;
      case 'HEADING_3':
        return 20.0;
      case 'HEADING_4':
        return 19.0;
      case 'HEADING_5':
        return 18.0;
      case 'HEADING_6':
        return 17.0;
      default:
        return null;
    }
  }

  TextAlign _getAlignment(String alignment) {
    switch (alignment) {
      case 'START':
        return TextAlign.left;
      case 'END':
        return TextAlign.right;
      case 'CENTER':
        return TextAlign.center;
      case 'JUSTIFIED':
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }
}
