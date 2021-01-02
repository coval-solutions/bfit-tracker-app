import 'package:bfit_tracker/utils/GoogleApiClient.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/docs/v1.dart' as docsV1;

class GoogleDoc extends StatefulWidget {
  @override
  _GoogleDocState createState() => _GoogleDocState();
}

class _GoogleDocState extends State<GoogleDoc> {
  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    final client = await GoogleApiClient.create();
    final docsApi = docsV1.DocsApi(client);
    var document = await docsApi.documents
        .get('18j4mySvYQxdktF2Xc_CDMLw7AGc_MjqwTruwsBnF-rc');
    print('document.title: ${document.title}');
    print('content.length: ${document.body.content.length}');
    _parseDocument(document);
  }

  Future<void> _parseDocument(docsV1.Document document) async {
    // _documentTitle = document.title;
    // var content = KtList.from(document.body.content);
    //
    // final elements = content
    //     .mapNotNull(
    //       (element) => (element?.paragraph?.elements != null ||
    //               element?.paragraph?.positionedObjectIds != null)
    //           ? element
    //           : null,
    //     )
    //     .asList();
    //
    // var inlineObjects = emptyMap<String, DocImageData>();
    // if (document.inlineObjects?.isNotEmpty == true) {
    //   inlineObjects = KtMap.from(document.inlineObjects).map((inlineObject) {
    //     var embeddedObject =
    //         inlineObject.value.inlineObjectProperties.embeddedObject;
    //     return KtPair(
    //       inlineObject.key,
    //       DocImageData(
    //         url: embeddedObject.imageProperties.contentUri,
    //         width: embeddedObject.size.width.magnitude,
    //         height: embeddedObject.size.height.magnitude,
    //       ),
    //     );
    //   }).associate((pair) => pair);
    // }
    //
    // var positionedObjects = emptyMap<String, DocImageData>();
    // if (document.positionedObjects?.isNotEmpty == true) {
    //   positionedObjects =
    //       KtMap.from(document.positionedObjects).map((positionedObject) {
    //     var embeddedObject =
    //         positionedObject.value.positionedObjectProperties.embeddedObject;
    //     return KtPair(
    //       positionedObject.key,
    //       DocImageData(
    //         url: embeddedObject.imageProperties.contentUri,
    //         width: embeddedObject.size.width.magnitude,
    //         height: embeddedObject.size.height.magnitude,
    //       ),
    //     );
    //   }).associate((pair) => pair);
    // }
    //
    // setState(() {
    //   _listItems = elements;
    //   _imagesData = inlineObjects.plus(positionedObjects).asMap();
    //   _contentLoaded = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
