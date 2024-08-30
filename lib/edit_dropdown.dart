// Flutter imports:
import 'package:flutter/material.dart';

class AppDropdownButton<T> extends StatelessWidget {
  const AppDropdownButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.selectedItemBuilder,
    this.hintText,
    this.labelText,
    this.showBlank = false,
    this.blankValue = '',
    this.blankLabel,
    this.enabled = true,
    this.autofocus = false,
  });

  final String? labelText;
  final String? hintText;
  final dynamic value;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final bool showBlank;
  final bool enabled;
  final bool autofocus;

  /// set it to null to use a custom model as the dropdown value
  final dynamic blankValue;
  final String? blankLabel;
  final DropdownButtonBuilder? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    dynamic checkedValue = value;
    final values = items.toList().map((option) => option.value).toList();
    if (!values.contains(value)) {
      checkedValue = blankValue;
    }
    final bool isEmpty = checkedValue == null || checkedValue == '';

    return DropdownButtonFormField<T>(
      decoration: labelText != null
          ? InputDecoration(label: Text(labelText!), hintText: hintText)
          : const InputDecoration.collapsed(hintText: ''),
      value: checkedValue == blankValue ? null : checkedValue,
      isExpanded: true,
      autofocus: autofocus,
      isDense: labelText != null,
      onChanged: enabled ? onChanged : null,
      selectedItemBuilder: selectedItemBuilder,
      items: [
        if (showBlank || isEmpty)
          DropdownMenuItem<T>(
            value: blankValue,
            child: blankLabel == null ? const SizedBox() : Text(blankLabel!),
          ),
        ...items
      ],
    );
  }
}
