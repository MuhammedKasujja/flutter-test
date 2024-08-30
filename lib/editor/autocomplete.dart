import 'package:flutter/material.dart';

import 'debounce.dart';

class AutoComplete extends StatefulWidget {
  const AutoComplete({super.key});

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  TextEditingController? _textEditingController;
  final items = ['One', 'Tow', 'Thress', "medie", "med"];

  void _onFocusChange() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Debouncer.complete();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        _onFocusChange();
      },
      skipTraversal: true,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: RawAutocomplete<String>(
          key: const ValueKey('__line_item__name__'),
          textEditingController: _textEditingController,
          initialValue: const TextEditingValue(text: ''),
          optionsBuilder: (TextEditingValue textEditingValue) {
            final options = items.where((ele) {
              final filter = textEditingValue.text.toLowerCase();
              final productKey = ele.toLowerCase();

              return productKey.contains(filter);
            }).toList();

            // if (options.length == 1) {
            //   return [];
            // }

            return options;
          },
          displayStringForOption: (item) => item,
          onSelected: (ele) {
            print(ele);
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              key: const ValueKey('ghjkl'),
              // Enables tests to find fields
              focusNode: focusNode,
              controller: textEditingController,
              autofocus: false,
              decoration: InputDecoration(
                labelText: '',
                hintText: '',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textEditingController.text = '';
                    setState(() {
                      // _showClear = false;
                    });
                  },
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              expands: false,
              autocorrect: false,
              textInputAction: TextInputAction.newline,
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                onFieldSubmitted();
              },
              enabled: true,
              textAlign: TextAlign.start,
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            final highlightedIndex = AutocompleteHighlightedOption.of(context);
            return Theme(
              data: ThemeData.light(),
              child: Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: Container(
                    color: Theme.of(context).cardColor,
                    width: 250,
                    height: 270,
                    constraints: const BoxConstraints(maxHeight: 270),
                    child: ListView.builder(
                      itemCount: options.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final entity = options.elementAt(index);
                        return Text(entity);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
