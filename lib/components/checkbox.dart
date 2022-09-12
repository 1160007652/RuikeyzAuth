import 'package:flutter/material.dart';

class CheckBoxLabelWidget extends StatefulWidget {
  final String label;
  final void Function(bool?) onChanged;
  final bool value;

  const CheckBoxLabelWidget({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
  });

  @override
  State<CheckBoxLabelWidget> createState() => _CheckBoxLabelWidgetState();
}

class _CheckBoxLabelWidgetState extends State<CheckBoxLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          activeColor: Colors.white10,
          onChanged: widget.onChanged,
        ),
        Text(widget.label)
      ],
    );
  }
}
