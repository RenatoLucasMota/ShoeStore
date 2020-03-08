import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoes_store_app/models/shoe_model.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class ShoeItem extends StatefulWidget {
  final ShoeModel shoeModel;
  final int currentIndex;
  final int index;
  const ShoeItem(
      {Key key, this.shoeModel, this.currentIndex = 0, this.index = 0})
      : super(key: key);

  @override
  _ShoeItemState createState() => _ShoeItemState();
}

class _ShoeItemState extends State<ShoeItem> {
  MultiTrackTween tween;
  @override
  void initState() {
    super.initState();
    tween = MultiTrackTween([
      Track("rotate").add(
        Duration(milliseconds: 300),
        Tween(begin: -0.6, end: 0.0),
        curve: Curves.easeInCubic,
      ),
      Track("position").add(
        Duration(milliseconds: 300),
        Tween<double>(begin: -100, end: -20),
        curve: Curves.easeInOutCubic,
      ),
      Track("scale").add(
        Duration(milliseconds: 200),
        Tween<double>(begin: 0, end: 1),
        curve: Curves.easeInCubic,
      ),
      Track("opacity").add(
        Duration(milliseconds: 100),
        Tween<double>(begin: 0, end: 1),
        curve: Curves.easeInCubic,
      ),
      Track('transform-rotate').add(
        Duration(milliseconds: 300),
        Tween<double>(begin: 0.5, end: 0),
        curve: Curves.easeInCubic,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          ControlledAnimation(
              playback: widget.index == widget.currentIndex
                  ? Playback.PLAY_FORWARD
                  : Playback.PLAY_REVERSE,
              duration: tween.duration,
              tween: tween,
              builder: (context, animation) {
                return Transform(
                  child: Hero(
                    tag: 'circle' + widget.shoeModel.name,
                    child: Container(
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: RadialGradient(
                          colors: [
                            widget.shoeModel.color.withOpacity(0.4),
                            widget.shoeModel.color,
                          ],
                        ),
                      ),
                    ),
                  ),
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..rotateX(animation['transform-rotate'])
                    ..rotateY(animation['transform-rotate']),
                );
              }),
          ControlledAnimation(
              playback: widget.index == widget.currentIndex
                  ? Playback.PLAY_FORWARD
                  : Playback.PLAY_REVERSE,
              duration: tween.duration,
              tween: tween,
              builder: (context, animation) {
                return Transform(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Hero(
                                  tag: 'mark' + widget.shoeModel.name,
                                  child: Text(
                                    widget.shoeModel.mark.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ),
                                Hero(
                                  tag: 'favorite' + widget.shoeModel.name,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Hero(
                              tag: 'name' + widget.shoeModel.name,
                              child: Text(
                                widget.shoeModel.name.toUpperCase(),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Hero(
                              tag: 'price' + widget.shoeModel.name,
                              child: Text(
                                widget.shoeModel.price.toUpperCase(),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // perspective
                    ..rotateX(animation['transform-rotate'])
                    ..rotateY(animation['transform-rotate']),
                );
              }),
          ControlledAnimation(
            playback: widget.index == widget.currentIndex
                ? Playback.PLAY_FORWARD
                : Playback.PLAY_REVERSE,
            duration: tween.duration,
            tween: tween,
            builder: (context, animation) {
              return Positioned(
                right: animation['position'],
                child: Opacity(
                  opacity: animation['opacity'],
                  child: Transform.scale(
                    scale: animation['scale'],
                    child: Transform.rotate(
                      child: Hero(
                        tag: 'img' + widget.shoeModel.name,
                        child: Image.network(
                          widget.shoeModel.img,
                          height: 250,
                          width: 250,
                        ),
                      ),
                      angle: animation['rotate'],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
