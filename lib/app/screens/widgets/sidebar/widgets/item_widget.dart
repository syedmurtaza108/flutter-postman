part of '../sidebar.dart';

class _ItemWidget extends StatefulWidget {
  const _ItemWidget({
    required this.onHoverPointer,
    required this.leading,
    required this.title,
    required this.textStyle,
    required this.padding,
    required this.offsetX,
    required this.scale,
    this.onTap,
  });

  final MouseCursor onHoverPointer;
  final Widget leading;
  final String title;
  final TextStyle textStyle;
  final double offsetX, scale, padding;
  final VoidCallback? onTap;

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onHoverPointer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(widget.padding),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [widget.leading, _title],
          ),
        ),
      ),
    );
  }

  Widget get _title {
    return Opacity(
      opacity: widget.scale,
      child: Transform.translate(
        offset: Offset(widget.offsetX, 0),
        child: Transform.scale(
          scale: widget.scale,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              widget.title,
              style: widget.textStyle,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }
}
