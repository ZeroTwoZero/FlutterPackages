library customswitch;
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String righttext;
  final String lefttext;
  final Color rightTextSelectedColor;
  final Color leftTextSelectedColor;
  final Color containerColor;
  final AnimationController controller;
  final Function controllerFunction;
  CustomSwitch(
      {Key key,
      this.righttext,
      this.lefttext,
      this.containerColor,
      this.rightTextSelectedColor,
      this.leftTextSelectedColor,
      this.controller,
      this.controllerFunction})
      : super(key: key);
  @override
  _CustomSwitch createState() => _CustomSwitch();
}

class _CustomSwitch extends State<CustomSwitch> with TickerProviderStateMixin {
  bool _isRightText = false;
  AnimationController ctrl;
  @override
  void initState() {
    if (widget.controller == null) {
      super.initState();
      ctrl = new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    var movableContainer = new Container(
      width: MediaQuery.of(context).size.width / 2.8,
      height: 100,
      decoration: new BoxDecoration(
        color: widget.containerColor,
        borderRadius: new BorderRadius.all(Radius.circular(50)),
      ),
    );
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: new Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 100,
              decoration: new BoxDecoration(
                color: const Color(0x5C000000),
                borderRadius: new BorderRadius.all(Radius.circular(50)),
              ),
              child: Stack(
                children: <Widget>[
                  new SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset.zero, end: Offset(.86, 0))
                            .animate(widget.controller == null
                                ? ctrl
                                : widget.controller),
                    child: movableContainer,
                  ),
                  new Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(55, 0, 55, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            widget.lefttext,
                            style: TextStyle(
                              letterSpacing: 5,
                              color: !_isRightText
                                  ? (widget.leftTextSelectedColor != null
                                      ? widget.leftTextSelectedColor
                                      : Colors.black)
                                  : Colors.white,
                              fontWeight: !_isRightText
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          new Text(
                            widget.righttext,
                            style: TextStyle(
                              letterSpacing: 5,
                              color: _isRightText
                                  ? (widget.rightTextSelectedColor != null
                                      ? widget.rightTextSelectedColor
                                      : Colors.black)
                                  : Colors.white,
                              fontWeight: _isRightText
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () => {
        setState(() {
          if (widget.controller == null && widget.controllerFunction == null) {
            if (!_isRightText) {
              ctrl.forward();
            } else {
              ctrl.reverse();
            }
          } else {
            if (!_isRightText) {
              widget.controller.forward();
            } else {
              widget.controller.reverse();
            }
          }
          _isRightText = !_isRightText;
        })
      },
    );
  }
}
