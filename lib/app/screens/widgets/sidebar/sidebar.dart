library collapsible_sidebar;

import 'dart:math' as math show pi;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/screens/widgets/widgets.dart';
import 'package:flutter_postman/app/theme/theme.dart';
import 'package:flutter_postman/app/utils/utils.dart';

part './widgets/item_selection.dart';
part './widgets/item_widget.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
    required this.items,
    required this.body,
    this.isCollapsed = true,
    this.allowCollapse = true,
    required this.focusNode,
  });

  final Widget body;
  final bool isCollapsed;
  final List<CollapsibleItem> items;
  final bool allowCollapse;
  final FocusNode focusNode;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late CurvedAnimation _curvedAnimation;
  late double tempWidth;

  final height = double.infinity;
  final minWidth = 66.0;
  final maxWidth = 270.0;
  final borderRadius = 15.0;
  final iconSize = 24.0;
  final padding = 24.0;
  final topPadding = 16.0;
  final bottomPadding = 0.0;
  final screenPadding = 4.0;

  bool _isCollapsed = false;
  late double _currWidth, _delta, _maxOffsetX, _maxOffsetY;
  late int _selectedItemIndex;

  @override
  void initState() {
    super.initState();

    tempWidth = maxWidth > 270 ? 270 : maxWidth;

    _currWidth = minWidth;
    _delta = tempWidth - minWidth;
    _maxOffsetX = padding * 2 + iconSize;
    _maxOffsetY = 16 + iconSize;
    for (var i = 0; i < widget.items.length; i++) {
      if (!widget.items[i].isSelected) continue;
      _selectedItemIndex = i;
      break;
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    _controller.addListener(() {
      _currWidth = _widthAnimation.value;
      if (_controller.isCompleted) _isCollapsed = _currWidth == minWidth;
      setState(() {});
    });

    _isCollapsed = widget.isCollapsed;
    final endWidth = _isCollapsed ? minWidth : tempWidth;
    _animateTo(endWidth);
  }

  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      _listenCollapseChange();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _listenCollapseChange() {
    _isCollapsed = widget.isCollapsed;
    final endWidth = _isCollapsed ? minWidth : tempWidth;
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: EdgeInsets.only(left: !_isCollapsed ? maxWidth : minWidth),
          child: widget.body,
        ),
        GestureDetector(
          onDoubleTap: () {
            if (!widget.allowCollapse) {
              return;
            }
            _isCollapsed = !_isCollapsed;
            final endWidth = _isCollapsed ? minWidth : tempWidth;
            _animateTo(endWidth);
          },
          child: Container(
            height: height,
            width: _currWidth,
            color: themeColors.sideBarColor,
            child: Column(
              crossAxisAlignment: _isCollapsed
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                topPadding.height,
                SizedBox(
                  height: 0,
                  child: ElevatedButton(
                    focusNode: widget.focusNode,
                    onPressed: () {},
                    child: const Text('data'),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Visibility(
                    visible: !_isCollapsed,
                    replacement: AutoSizeText(
                      'FP',
                      style: context.theme.textTheme.bodyText1?.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    child: const Center(
                      child: AppLogo(
                        size: 20,
                        dotPadding: 3,
                        dotHeight: 25,
                      ),
                    ),
                  ),
                ),
                32.height,
                Padding(
                  padding: 16.horizontal,
                  child: AutoSizeText(
                    'MENU',
                    style: context.theme.textTheme.bodyText2?.copyWith(
                      color: themeColors.sidebarHeadingColor,
                    ),
                  ),
                ),
                24.height,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Stack(
                      children: [
                        _ItemSelection(
                          height: _maxOffsetY,
                          offsetY: _maxOffsetY * _selectedItemIndex,
                          color: themeColors.sideBarSelectedColor,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn,
                        ),
                        Column(children: _items),
                      ],
                    ),
                  ),
                ),
                bottomPadding.height,
                if (widget.allowCollapse) _toggleButton,
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get _items {
    return List.generate(widget.items.length, (index) {
      final item = widget.items[index];
      return _ItemWidget(
        onHoverPointer: SystemMouseCursors.click,
        offsetX: 36,
        scale: _fraction,
        leading: Icon(
          item.icon,
          size: iconSize,
          color: item.isSelected
              ? themeColors.sideBarSelectedTextColor
              : themeColors.sideBarUnselectedTextColor,
        ),
        title: item.text,
        alignment: _isCollapsed ? Alignment.center : Alignment.centerLeft,
        textStyle: context.theme.textTheme.bodyText1!.copyWith(
          color: item.isSelected
              ? themeColors.sideBarSelectedTextColor
              : themeColors.sideBarUnselectedTextColor,
        ),
        onTap: () {
          // if (item.isSelected) return;
          item.onPressed();
          widget.items[_selectedItemIndex].isSelected = false;
          item.isSelected = true;
          setState(() => _selectedItemIndex = index);
        },
      );
    });
  }

  Widget get _toggleButton {
    return _ItemWidget(
      onHoverPointer: SystemMouseCursors.click,
      offsetX: _offsetX,
      scale: _fraction,
      leading: Transform.rotate(
        angle: _currAngle,
        child: Icon(
          Icons.chevron_right,
          size: iconSize,
          color: Colors.white,
        ),
      ),
      alignment: _isCollapsed ? Alignment.center : Alignment.centerLeft,
      title: '',
      textStyle: context.theme.textTheme.bodyText1!,
      onTap: () {
        if (!widget.allowCollapse) {
          return;
        }
        _isCollapsed = !_isCollapsed;
        final endWidth = _isCollapsed ? minWidth : tempWidth;
        _animateTo(endWidth);
      },
    );
  }

  double get _fraction => (_currWidth - minWidth) / _delta;
  double get _currAngle => -math.pi * _fraction;
  double get _offsetX => _maxOffsetX * _fraction;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CollapsibleItem {
  CollapsibleItem({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
  });

  final String text;
  final IconData icon;
  final void Function() onPressed;
  bool isSelected;
}
