import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {
  final String label;
  final String suffixText;
  final TextEditingController controller;
  final double width;
  final void Function(String) onChanged;
  final bool readOnly;
  final TextAlign textAlign;

  const InputTextWidget(
      {super.key,
      required this.label,
      required this.suffixText,
      required this.controller,
      required this.width,
      required this.onChanged,
      required this.readOnly,
      required this.textAlign});

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool autoSuccessTips = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        children: [
          Text(widget.label),
          Expanded(
            flex: 1,
            child: TextField(
              textAlign: widget.textAlign,
              controller: widget.controller,
              maxLines: 1,
              readOnly: widget.readOnly,
              onChanged: (val) {
                if (widget.controller.value.isComposingRangeValid) {
                  return;
                }
                widget.onChanged(val);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                isCollapsed: true,
                filled: true,
                suffixText: widget.suffixText,
                prefixIconConstraints: const BoxConstraints(),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
