import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class NitaraCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Gradient? gradient;
  final Color? color;
  final double? borderRadius;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;

  const NitaraCard({
    super.key,
    required this.child,
    this.padding,
    this.gradient,
    this.color,
    this.borderRadius,
    this.onTap,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          color: color ?? (isDark ? NitaraColors.surfaceDark : Colors.white),
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: NitaraColors.pink.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
        ),
        child: child,
      ),
    );
  }
}

class NitaraSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const NitaraSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: NitaraColors.pinkPastel,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                actionLabel!,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: NitaraColors.pink,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class NitaraStatTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const NitaraStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? NitaraColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    unit,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: NitaraColors.textLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: NitaraColors.textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NitaraProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Color color;
  final Widget child;
  final double strokeWidth;

  const NitaraProgressRing({
    super.key,
    required this.progress,
    required this.size,
    required this.color,
    required this.child,
    this.strokeWidth = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress,
              color: color,
              strokeWidth: strokeWidth,
              backgroundColor: color.withOpacity(0.12),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final fgPaint = Paint()
      ..shader = SweepGradient(
        colors: [color.withOpacity(0.5), color],
        startAngle: -1.5708,
        endAngle: -1.5708 + (6.2832 * progress),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708,
      6.2832 * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
