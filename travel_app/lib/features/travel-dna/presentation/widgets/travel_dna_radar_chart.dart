import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';

import '../../application/travel_dna_radar_view.dart';

class TravelDnaRadarChart extends StatelessWidget {
  const TravelDnaRadarChart({
    super.key,
    required this.axes,
    required this.showCommunity,
    required this.userLabel,
  });

  final List<TravelDnaAxisView> axes;
  final bool showCommunity;
  final String userLabel;

  @override
  Widget build(BuildContext context) {
    if (axes.length < 3) {
      return Text(
        'Cần ít nhất 3 trục để vẽ radar.',
        style: AppTypography.body,
        textAlign: TextAlign.center,
      );
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.05,
          child: CustomPaint(
            painter: _RadarPainter(axes: axes, showCommunity: showCommunity),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            _LegendDot(color: AppColors.primary, label: userLabel),
            if (showCommunity)
              const _LegendDot(
                color: AppColors.info,
                label: 'Trung bình cộng đồng',
                dashed: true,
              ),
          ],
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
    this.dashed = false,
  });

  final Color color;
  final String label;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dashed ? 18 : 10,
          height: dashed ? 2 : 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({required this.axes, required this.showCommunity});

  final List<TravelDnaAxisView> axes;
  final bool showCommunity;

  @override
  void paint(Canvas canvas, Size size) {
    final count = axes.length;
    final center = Offset(size.width / 2, size.height / 2 + 4);
    final radius = math.min(size.width, size.height) * 0.30;
    final scale = _scale(axes);
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFD5E5ED);
    final rayPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = const Color(0xFFCBD5E1);

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = AppColors.primary.withValues(alpha: 0.08),
    );

    for (final step in [0.2, 0.4, 0.6, 0.8, 1.0]) {
      final path = _polygon(center, radius * step, count, (index) => 1);
      canvas.drawPath(path, gridPaint);
    }
    for (var index = 0; index < count; index++) {
      final end = _vertex(center, radius, count, index, 1);
      canvas.drawLine(center, end, rayPaint);
    }

    if (showCommunity) {
      final community = _polygon(
        center,
        radius,
        count,
        (index) => axes[index].communityScore / scale,
      );
      canvas.drawPath(
        community,
        Paint()..color = AppColors.info.withValues(alpha: 0.10),
      );
      _drawDashed(
        canvas,
        community,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6
          ..color = AppColors.info,
      );
    }

    final user = _polygon(
      center,
      radius,
      count,
      (index) => axes[index].score / scale,
    );
    canvas.drawPath(
      user,
      Paint()..color = AppColors.primary.withValues(alpha: 0.28),
    );
    canvas.drawPath(
      user,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..color = AppColors.primary,
    );

    final nodeFill = Paint()..color = AppColors.surface;
    final nodeStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = AppColors.primaryActive;
    for (var index = 0; index < count; index++) {
      final point = _vertex(
        center,
        radius,
        count,
        index,
        axes[index].score / scale,
      );
      canvas.drawCircle(point, 4.5, nodeFill);
      canvas.drawCircle(point, 4.5, nodeStroke);
      _paintLabel(canvas, center, radius, count, index, axes[index]);
    }
  }

  void _paintLabel(
    Canvas canvas,
    Offset center,
    double radius,
    int count,
    int index,
    TravelDnaAxisView axis,
  ) {
    final anchor = _vertex(center, radius + 28, count, index, 1);
    final text = '${axis.icon} ${axis.shortLabel} (${axis.score})';
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.badge.copyWith(
          color: index == 0 ? AppColors.primary : AppColors.textPrimary,
          fontSize: 10,
          letterSpacing: 0,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
      maxLines: 2,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 88);
    var dx = anchor.dx - painter.width / 2;
    if (anchor.dx < center.dx - 8) dx = anchor.dx - painter.width;
    if (anchor.dx > center.dx + 8) dx = anchor.dx;
    final dy = anchor.dy - painter.height / 2;
    painter.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) {
    return oldDelegate.showCommunity != showCommunity ||
        oldDelegate.axes != axes;
  }
}

double _scale(List<TravelDnaAxisView> axes) {
  var maxScore = 100;
  for (final axis in axes) {
    if (axis.score > maxScore) maxScore = axis.score;
    if (axis.communityScore > maxScore) maxScore = axis.communityScore;
  }
  return maxScore.toDouble();
}

void _drawDashed(Canvas canvas, Path source, Paint paint) {
  for (final metric in source.computeMetrics()) {
    var distance = 0.0;
    while (distance < metric.length) {
      final next = math.min(distance + 6, metric.length);
      canvas.drawPath(metric.extractPath(distance, next), paint);
      distance = next + 4;
    }
  }
}

Path _polygon(
  Offset center,
  double radius,
  int count,
  double Function(int index) ratio,
) {
  final path = Path();
  for (var index = 0; index < count; index++) {
    final point = _vertex(center, radius, count, index, ratio(index));
    if (index == 0) {
      path.moveTo(point.dx, point.dy);
    } else {
      path.lineTo(point.dx, point.dy);
    }
  }
  path.close();
  return path;
}

Offset _vertex(
  Offset center,
  double radius,
  int count,
  int index,
  double ratio,
) {
  final clamped = ratio.clamp(0.0, 1.0);
  final angle = -math.pi / 2 + (2 * math.pi * index / count);
  return Offset(
    center.dx + radius * clamped * math.cos(angle),
    center.dy + radius * clamped * math.sin(angle),
  );
}
