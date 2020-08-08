import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WorkoutsCard extends StatefulWidget {
  final String smallTitle;
  final String mainTitle;
  final String description;
  final String imageUrl;
  final Color color;
  final Duration duration;

  WorkoutsCard({
    Key key,
    @required this.smallTitle,
    @required this.mainTitle,
    @required this.description,
    @required this.imageUrl,
    @required this.color,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _WorkoutsCardState createState() => _WorkoutsCardState();
}

class _WorkoutsCardState extends State<WorkoutsCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Card(
        color: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      widget.smallTitle,
                      minFontSize: 8,
                      maxFontSize: 12,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    AutoSizeText(
                      widget.mainTitle,
                      minFontSize: 16,
                      maxFontSize: 20,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      widget.description,
                      minFontSize: 10,
                      maxFontSize: 12,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80,
                    width: 120,
                    child: SvgPicture.network(
                      widget.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
