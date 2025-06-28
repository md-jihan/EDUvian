import 'package:flutter/material.dart';

class ArrowTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double arrowHeight;
  final GlobalKey<ArrowTooltipState>? key;

  ArrowTooltip({
    required this.message,
    required this.child,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.arrowHeight = 8.0,
    this.key,
  }) : super(key: key);

  @override
  ArrowTooltipState createState() => ArrowTooltipState();
}

class ArrowTooltipState extends State<ArrowTooltip> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void show() {
    if (_overlayEntry != null) return;

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy - widget.arrowHeight - 40,
          child: Material(
            color: Colors.transparent,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, -size.height - widget.arrowHeight - 8),
              showWhenUnlinked: false,
              child: TooltipContent(
                message: widget.message,
                backgroundColor: widget.backgroundColor,
                textColor: widget.textColor,
                borderRadius: widget.borderRadius,
                arrowHeight: widget.arrowHeight,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), hide);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: show, // Optional: show on tap
        child: widget.child,
      ),
    );
  }
}

class TooltipContent extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double arrowHeight;

  const TooltipContent({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.arrowHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: _ArrowPainter(color: backgroundColor),
          child: const SizedBox(height: 8, width: 16),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(message, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;

  _ArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path =
        Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
