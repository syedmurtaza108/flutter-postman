library collapsible_sidebar;

import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/sidebar/collapsible_sidebar/collapsible_container.dart';
import 'package:flutter_postman/app/screens/widgets/sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter_postman/app/screens/widgets/sidebar/collapsible_sidebar/collapsible_item_selection.dart';
import 'package:flutter_postman/app/screens/widgets/sidebar/collapsible_sidebar/collapsible_item_widget.dart';

class CollapsibleSidebar extends StatefulWidget {
  const CollapsibleSidebar({
    super.key,
    required this.items,
    required this.body,
    this.title = 'Lorem Ipsum',
    this.titleStyle,
    this.titleBackIcon = Icons.arrow_back,
    this.onHoverPointer = SystemMouseCursors.click,
    this.textStyle,
    this.toggleTitleStyle,
    this.toggleTitle = 'Collapse',
    this.height = double.infinity,
    this.minWidth = 80,
    this.maxWidth = 270,
    this.borderRadius = 15,
    this.iconSize = 40,
    this.toggleButtonIcon = Icons.chevron_right,
    this.backgroundColor = const Color(0xff2B3138),
    this.selectedIconBox = const Color(0xff2F4047),
    this.selectedIconColor = const Color(0xff4AC6EA),
    this.selectedTextColor = const Color(0xffF3F7F7),
    this.unselectedIconColor = const Color(0xff6A7886),
    this.unselectedTextColor = const Color(0xffC0C7D0),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.screenPadding = 4,
    this.showToggleButton = true,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.fitItemsToBottom = false,
    this.onTitleTap,
    this.isCollapsed = true,
    this.padding = 10,
    this.itemPadding = 10,
    this.sidebarBoxShadow = const [
      BoxShadow(
        color: Colors.blue,
        blurRadius: 10,
        spreadRadius: 0.01,
        offset: Offset(3, 3),
      ),
    ],
  });

  final String title, toggleTitle;
  final MouseCursor onHoverPointer;
  final TextStyle? titleStyle, textStyle, toggleTitleStyle;
  final IconData titleBackIcon;
  final Widget body;
  final bool showToggleButton, fitItemsToBottom, isCollapsed;
  final List<CollapsibleItem> items;
  final double height,
      minWidth,
      maxWidth,
      borderRadius,
      iconSize,
      padding,
      itemPadding,
      topPadding,
      bottomPadding,
      screenPadding;
  final IconData toggleButtonIcon;
  final Color backgroundColor,
      selectedIconBox,
      selectedIconColor,
      selectedTextColor,
      unselectedIconColor,
      unselectedTextColor;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTitleTap;
  final List<BoxShadow> sidebarBoxShadow;

  @override
  State<CollapsibleSidebar> createState() => _CollapsibleSidebarState();
}

class _CollapsibleSidebarState extends State<CollapsibleSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late CurvedAnimation _curvedAnimation;
  late double tempWidth;

  bool _isCollapsed = false;
  late double _currWidth,
      _delta,
      _delta1By4,
      _delta3by4,
      _maxOffsetX,
      _maxOffsetY;
  late int _selectedItemIndex;

  @override
  void initState() {
    super.initState();

    tempWidth = widget.maxWidth > 270 ? 270 : widget.maxWidth;

    _currWidth = widget.minWidth;
    _delta = tempWidth - widget.minWidth;
    _delta1By4 = _delta * 0.25;
    _delta3by4 = _delta * 0.75;
    _maxOffsetX = widget.padding * 2 + widget.iconSize;
    _maxOffsetY = widget.itemPadding * 2 + widget.iconSize;
    for (var i = 0; i < widget.items.length; i++) {
      if (!widget.items[i].isSelected) continue;
      _selectedItemIndex = i;
      break;
    }

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.addListener(() {
      _currWidth = _widthAnimation.value;
      if (_controller.isCompleted) _isCollapsed = _currWidth == widget.minWidth;
      setState(() {});
    });

    _isCollapsed = widget.isCollapsed;
    final endWidth = _isCollapsed ? widget.minWidth : tempWidth;
    _animateTo(endWidth);
  }

  @override
  void didUpdateWidget(covariant CollapsibleSidebar oldWidget) {
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      _listenCollapseChange();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _listenCollapseChange() {
    _isCollapsed = widget.isCollapsed;
    final endWidth = _isCollapsed ? widget.minWidth : tempWidth;
    _animateTo(endWidth);
  }

  void _animateTo(double endWidth) {
    _widthAnimation = Tween<double>(
      begin: _currWidth,
      end: endWidth,
    ).animate(_curvedAnimation);
    _controller
      ..reset()
      ..forward();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      _currWidth += details.primaryDelta!;
      if (_currWidth > tempWidth) {
        _currWidth = tempWidth;
      } else if (_currWidth < widget.minWidth) {
        _currWidth = widget.minWidth;
      } else {
        setState(() {});
      }
    }
  }

  void _onHorizontalDragEnd(DragEndDetails _) {
    if (_currWidth == tempWidth) {
      setState(() => _isCollapsed = false);
    } else if (_currWidth == widget.minWidth) {
      setState(() => _isCollapsed = true);
    } else {
      final threshold = _isCollapsed ? _delta1By4 : _delta3by4;
      final endWidth = _currWidth - widget.minWidth > threshold
          ? tempWidth
          : widget.minWidth;
      _animateTo(endWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.minWidth * 1.1),
          child: widget.body,
        ),
        Padding(
          padding: EdgeInsets.all(widget.screenPadding),
          child: GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: CollapsibleContainer(
              height: widget.height,
              width: _currWidth,
              padding: widget.padding,
              borderRadius: widget.borderRadius,
              color: widget.backgroundColor,
              sidebarBoxShadow: widget.sidebarBoxShadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: widget.topPadding,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      reverse: widget.fitItemsToBottom,
                      child: Stack(
                        children: [
                          CollapsibleItemSelection(
                            height: _maxOffsetY,
                            offsetY: _maxOffsetY * _selectedItemIndex,
                            color: widget.selectedIconBox,
                            duration: widget.duration,
                            curve: widget.curve,
                          ),
                          Column(
                            children: _items,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.bottomPadding,
                  ),
                  if (widget.showToggleButton)
                    Divider(
                      color: widget.unselectedIconColor,
                      indent: 5,
                      endIndent: 5,
                      thickness: 1,
                    )
                  else
                    const SizedBox(height: 5),
                  if (widget.showToggleButton)
                    _toggleButton
                  else
                    SizedBox(height: widget.iconSize),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get _items {
    return List.generate(widget.items.length, (index) {
      final item = widget.items[index];
      var iconColor = widget.unselectedIconColor;
      var textColor = widget.unselectedTextColor;
      if (item.isSelected) {
        iconColor = widget.selectedIconColor;
        textColor = widget.selectedTextColor;
      }
      return CollapsibleItemWidget(
        onHoverPointer: widget.onHoverPointer,
        padding: widget.itemPadding,
        offsetX: _offsetX,
        scale: _fraction,
        leading: Icon(
          item.icon,
          size: widget.iconSize,
          color: iconColor,
        ),
        title: item.text,
        textStyle: _textStyle(textColor, widget.textStyle),
        onTap: () {
          if (item.isSelected) return;
          item.onPressed();
          item.isSelected = true;
          widget.items[_selectedItemIndex].isSelected = false;
          setState(() => _selectedItemIndex = index);
        },
      );
    });
  }

  Widget get _toggleButton {
    return CollapsibleItemWidget(
      onHoverPointer: widget.onHoverPointer,
      padding: widget.itemPadding,
      offsetX: _offsetX,
      scale: _fraction,
      leading: Transform.rotate(
        angle: _currAngle,
        child: Icon(
          widget.toggleButtonIcon,
          size: widget.iconSize,
          color: widget.unselectedIconColor,
        ),
      ),
      title: widget.toggleTitle,
      textStyle:
          _textStyle(widget.unselectedTextColor, widget.toggleTitleStyle),
      onTap: () {
        _isCollapsed = !_isCollapsed;
        final endWidth = _isCollapsed ? widget.minWidth : tempWidth;
        _animateTo(endWidth);
      },
    );
  }

  double get _fraction => (_currWidth - widget.minWidth) / _delta;
  double get _currAngle => -math.pi * _fraction;
  double get _offsetX => _maxOffsetX * _fraction;

  TextStyle _textStyle(Color color, TextStyle? style) {
    return style == null
        ? TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: color,
          )
        : style.copyWith(color: color);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
