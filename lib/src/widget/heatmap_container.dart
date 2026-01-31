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

  const HeatMapContainer({
    Key? key,
    required this.date,
    required this.borderColor,
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
    // Highlight today in the calendar
    final bool isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

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
              border: isToday
                  ? Border.all(color: borderColor.withAlpha(200), width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
              boxShadow: isToday
                  ? [
                      BoxShadow(
                        color: borderColor.withAlpha(128),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: borderColor.withAlpha(77),
                        blurRadius: 12,
                        spreadRadius: 4,
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
