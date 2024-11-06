import 'package:flutter/material.dart';

class HexColorTextField extends StatefulWidget {
  const HexColorTextField(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<HexColorTextField> createState() => _HexColorTextFieldState();
}

class _HexColorTextFieldState extends State<HexColorTextField> {
  late final controller = TextEditingController(text: widget.value.toString());
  final focusNode = FocusNode();

  @override
  void didUpdateWidget(covariant HexColorTextField oldWidget) {
    if (widget.value != oldWidget.value && !focusNode.hasFocus) {
      controller.text = widget.value.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("Hex Color", style: Theme.of(context).textTheme.titleMedium),
      Spacer(),
      Container(
        width: 100,
        height: 40,
        child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(10),
            ),
            onChanged: (value) {
              print(value);
              widget.onChanged(value);
            }),
      )
    ]);
  }
}