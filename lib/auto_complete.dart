import 'package:flutter/material.dart';

import 'editor/debounce.dart';

class CustomAutocomplete<T extends Object> extends StatefulWidget {
  final List<T> options;
  final String Function(T) displayStringForOption;
  final InputDecoration decoration;
  final void Function(T) onSelected;

  const CustomAutocomplete({
    super.key,
    required this.options,
    required this.displayStringForOption,
    required this.decoration,
    required this.onSelected,
  });

  @override
  State<CustomAutocomplete<T>> createState() => _CustomAutocompleteState<T>();
}

class _CustomAutocompleteState<T extends Object>
    extends State<CustomAutocomplete<T>> {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    _focusNode?.addListener(() {
      setState(() {
        _isFocused = _focusNode?.hasFocus ?? false;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

   void _onFocusChange() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Debouncer.complete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (_){
        _onFocusChange();
      },
      child: RawAutocomplete<T>(
        focusNode: null,
        textEditingController: null,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return widget.options;
          }
          return widget.options.where((T option) {
            return widget
                .displayStringForOption(option)
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        displayStringForOption: widget.displayStringForOption,
        onSelected: widget.onSelected,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            controller: fieldTextEditingController,
            focusNode: focusNode,
            decoration: widget.decoration.copyWith(
              border: _isFocused
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0))
                  : const OutlineInputBorder(),
            ),
            onSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final T option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(widget.displayStringForOption(option)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AutoCompletePage extends StatelessWidget {
  final List<String> _options = <String>[
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomAutocomplete<String>(
        options: _options,
        displayStringForOption: (String option) => option,
        decoration: const InputDecoration(
          labelText: 'Search for a fruit',
          border: OutlineInputBorder(),
        ),
        onSelected: (String selection) {
          print('You selected: $selection');
        },
      ),
    );
  }
}
