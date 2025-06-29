// Enhanced ArrowTooltip Widget
import 'package:flutter/material.dart';

class ArrowTooltip extends StatelessWidget {
  final GlobalKey key;
  final String message;
  final Widget child;
  final ArrowPosition arrowPosition;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;

  const ArrowTooltip({
    required this.key,
    required this.message,
    required this.child,
    this.arrowPosition = ArrowPosition.bottomCenter,
    this.backgroundColor = const Color(0xFF323232),
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final dynamic tooltip = key.currentState;
        tooltip?.ensureTooltipVisible();
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: _getAlignment(),
        children: [
          child,
          Positioned(
            top: arrowPosition.isTop ? null : -10,
            bottom: arrowPosition.isTop ? -10 : null,
            left: arrowPosition.isLeft ? 0 : null,
            right: arrowPosition.isRight ? 0 : null,
            child: _buildTooltip(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTooltip(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (arrowPosition.isTop) _buildArrow(),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            message,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
        if (!arrowPosition.isTop) _buildArrow(),
      ],
    );
  }

  Widget _buildArrow() {
    return CustomPaint(
      size: const Size(20, 10),
      painter: ArrowPainter(
        color: backgroundColor,
        isDown: arrowPosition.isTop,
      ),
    );
  }

  Alignment _getAlignment() {
    switch (arrowPosition) {
      case ArrowPosition.topLeft:
      case ArrowPosition.bottomLeft:
        return Alignment.centerLeft;
      case ArrowPosition.topRight:
      case ArrowPosition.bottomRight:
        return Alignment.centerRight;
      case ArrowPosition.topCenter:
      case ArrowPosition.bottomCenter:
      default:
        return Alignment.center;
    }
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final bool isDown;

  ArrowPainter({required this.color, this.isDown = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isDown) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum ArrowPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom;

  bool get isTop => name.startsWith('top');
  bool get isBottom => name.startsWith('bottom');
  bool get isLeft => name.startsWith('left');
  bool get isRight => name.startsWith('right');
}
