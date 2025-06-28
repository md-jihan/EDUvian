import 'package:flutter/material.dart';

class ArrowTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final String arrowPosition; // e.g., 'bottomCenter'
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  const ArrowTooltip({
    super.key,
    required this.child,
    required this.message,
    this.arrowPosition = 'bottomCenter',
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderRadius = 8,
  });

  @override
  State<ArrowTooltip> createState() => _ArrowTooltipState();
}

class _ArrowTooltipState extends State<ArrowTooltip> {
  OverlayEntry? _overlayEntry;

  void ensureTooltipVisible() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => hideTooltip(),
                behavior: HitTestBehavior.translucent,
              ),
            ),
            _buildTooltip(offset, size),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildTooltip(Offset offset, Size size) {
    final arrow = CustomPaint(
      painter: _ArrowPainter(
        color: widget.backgroundColor,
        position: widget.arrowPosition,
      ),
      size: const Size(20, 10),
    );

    final tooltipBox = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Text(widget.message, style: TextStyle(color: widget.textColor)),
    );

    Offset tooltipOffset = offset;
    Widget composedTooltip;

    switch (widget.arrowPosition) {
      case 'topCenter':
        tooltipOffset = offset.translate(size.width / 2 - 60, -50);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          children: [tooltipBox, arrow],
        );
        break;

      case 'bottomCenter':
        tooltipOffset = offset.translate(size.width / 2 - 60, size.height + 8);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          children: [arrow, tooltipBox],
        );
        break;

      case 'topLeft':
        tooltipOffset = offset.translate(0, -40);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [tooltipBox, arrow],
        );
        break;

      case 'topRight':
        tooltipOffset = offset.translate(size.width - 120, -40);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [tooltipBox, arrow],
        );
        break;

      case 'bottomLeft':
        tooltipOffset = offset.translate(0, size.height + 8);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [arrow, tooltipBox],
        );
        break;

      case 'bottomRight':
        tooltipOffset = offset.translate(size.width - 120, size.height + 8);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [arrow, tooltipBox],
        );
        break;

      case 'leftCenter':
        tooltipOffset = offset.translate(-130, size.height / 2 - 20);
        composedTooltip = Row(
          mainAxisSize: MainAxisSize.min,
          children: [tooltipBox, arrow],
        );
        break;

      case 'rightCenter':
        tooltipOffset = offset.translate(size.width + 8, size.height / 2 - 20);
        composedTooltip = Row(
          mainAxisSize: MainAxisSize.min,
          children: [arrow, tooltipBox],
        );
        break;

      default:
        tooltipOffset = offset.translate(size.width / 2 - 60, size.height + 8);
        composedTooltip = Column(
          mainAxisSize: MainAxisSize.min,
          children: [arrow, tooltipBox],
        );
    }

    return Positioned(
      left: tooltipOffset.dx,
      top: tooltipOffset.dy,
      child: Material(color: Colors.transparent, child: composedTooltip),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: ensureTooltipVisible, child: widget.child);
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final String position;

  _ArrowPainter({required this.color, required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (position.startsWith('top')) {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    } else if (position.startsWith('bottom')) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else if (position.startsWith('left')) {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
    } else {
      // right
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) => false;
}
