import 'package:flutter/material.dart';

class GradientSlider extends StatefulWidget {
  const GradientSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.minValue,
    required this.maxValue,
    required this.stops,
    required this.divisions,
  });

  final double value, minValue, maxValue;
  final List<Color> stops;
  final String label;
  final ValueChanged<double> onChanged;
  final int divisions;

  @override
  State<GradientSlider> createState() => _GradientSliderState();
}

class _GradientSliderState extends State<GradientSlider> {
  late final controller = TextEditingController(text: widget.value.toString());
  final focusNode = FocusNode();

  @override
  void didUpdateWidget(covariant GradientSlider oldWidget) {
    if (widget.value != oldWidget.value && !focusNode.hasFocus) {
      controller.text = widget.value.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text field
        Row(
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Spacer(),
            Container(
              width: 100,
              height: 40,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  final double? doubleValue = double.tryParse(value);
                  if (doubleValue != null) {
                    if (doubleValue < widget.minValue) {
                      controller.text = widget.minValue.toString();
                    } else if (doubleValue > widget.maxValue) {
                      controller.text = widget.maxValue.toString();
                    } else {
                      widget.onChanged(doubleValue);
                    }
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Linear gradient background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.stops,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              // Slider
              Positioned.fill(
                left: -25,
                right: -25,
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: getOnColor(),
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                  ),
                  child: Slider(
                    value: widget.value,
                    onChanged: widget.onChanged,
                    min: widget.minValue,
                    max: widget.maxValue,
                    divisions: widget.divisions,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color getOnColor() {
    final offset = widget.value / widget.maxValue;
    final nearestStop = widget.stops.reduce((a, b) {
      final aOffset = widget.stops.indexOf(a) / (widget.stops.length - 1);
      final bOffset = widget.stops.indexOf(b) / (widget.stops.length - 1);
      final aDistance = (aOffset - offset).abs();
      final bDistance = (bOffset - offset).abs();
      return aDistance < bDistance ? a : b;
    });
    return nearestStop.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}