import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';

class ResizableWidget extends StatefulWidget {
  final double height;
  final double maxHeight;
  final double dividerHeight;
  final double dividerSpace;
  final Widget child;
  final Function(bool)? onTap;
  final Function(double)? onRelease;

  const ResizableWidget({
    Key? key,
    required this.child,
    this.height = 300,
    this.maxHeight = 600,
    this.dividerHeight = 40,
    this.dividerSpace = 2,
    this.onTap,
    this.onRelease,
  }) : super(key: key);

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<ResizableWidget> {
  late double _height,
      _maxHeight,
      _dividerHeight,
      _dividerSpace,
      _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _height = widget.height;
    _maxHeight = widget.maxHeight;
    _dividerHeight = widget.dividerHeight;
    _dividerSpace = widget.dividerSpace;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        GestureDetector(
          child: SizedBox(
            height: _height,
            width: Tools.width(context),
            child: widget.child,
          ),
          onPanDown: (d) {
            widget.onTap!(true);
          },
          onPanUpdate: (details) {
            setState(() {
              _opacity = 0.8;
              _height += details.delta.dy;
              var maxLimit = _maxHeight - _dividerHeight - _dividerSpace;
              var minLimit = 44.0;
              if (_height > maxLimit) {
                _height = maxLimit;
              } else if (_height < minLimit) {
                _height = minLimit;
              }
            });
          },
          onPanEnd: (details) {
            widget.onRelease!(_height);
            widget.onTap!(false);
            setState(() {
              _opacity = 0.0;
            });
          },
        ),
        Positioned(
          bottom: _dividerHeight * -0.5,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: Container(
              height: _dividerHeight * .5,
              width: Tools.width(context),
              decoration: BoxDecoration(
                color: S.colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
