import 'package:flutter/material.dart';
import '../data/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final bool? showText;
  final Function(DateTime dateTime)? onClick;
  final Color borderColor;
  final DateTime activeDate;

  const HeatMapContainer({
    Key? key,
    required this.date,
    required this.borderColor,
    required this.activeDate,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.showText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Highlight either today, or the date clicked!
    // Highlight today in the calendar
    final bool isMarked = date.year == activeDate.year &&
        date.month == activeDate.month &&
        date.day == activeDate.day;

    return Padding(
        padding: margin ?? const EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () => onClick?.call(date),
          child: AnimatedContainer(
            width: size,
            height: size,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color:
                  selectedColor ?? backgroundColor ?? HeatMapColor.defaultColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
              border: isMarked
                  ? Border.all(color: borderColor.withAlpha(200), width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
              boxShadow: isMarked
                  ? [
                      BoxShadow(
                        color: borderColor.withAlpha(160),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: (showText ?? true)
                ? Text(
                    date.day.toString(),
                    style: TextStyle(
                        color: textColor ?? const Color(0xFF8A8A8A),
                        fontSize: fontSize),
                  )
                : null,
          ),
        ));
  }
}
