import 'package:flutter/material.dart';

class SelectLabelWidget extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final double width;
  final void Function(String?) onChanged;

  const SelectLabelWidget({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.width,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: width,
      child: Row(
        children: [
          Text(label),
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                isCollapsed: true,
                filled: true,
                prefixIconConstraints: BoxConstraints(),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              value: value,
              onChanged: onChanged,
              // 传入可选的数组
              items: items,
            ),
          ),
        ],
      ),
    );
  }
}
