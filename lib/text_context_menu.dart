import 'package:flutter/material.dart';

import 'auto_complete.dart';
import 'editor/autocomplete.dart';

class TextFieldWithContextMenu extends StatefulWidget {
  const TextFieldWithContextMenu({super.key});

  @override
  State<TextFieldWithContextMenu> createState() =>
      _TextFieldWithContextMenuState();
}

class _TextFieldWithContextMenuState extends State<TextFieldWithContextMenu> {
  final GlobalKey _textFieldKey = GlobalKey();

  void _showContextMenu(BuildContext context) {
    final RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        const PopupMenuItem(
          value: 'Option 1',
          child: Text('Option 1'),
        ),
        const PopupMenuItem(
          value: 'Option 2',
          child: Text('Option 2'),
        ),
        const PopupMenuItem(
          value: 'Option 3',
          child: Text('Option 3'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: $value')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Context Menu Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            AutoComplete(onSelected: (value) {
              print('AutoCompleteValue $value');
            }),
            const SizedBox(height: 20),
            CustomAutocomplete<String>(
              options: const [
                'Apple',
                'Banana',
                'Cherry',
                'Date',
                'Elderberry',
                'Fig',
                'Grape',
              ],
              displayStringForOption: (String option) => option,
              decoration: const InputDecoration(
                labelText: 'Search for a fruit',
                border: OutlineInputBorder(),
              ),
              onSelected: (String selection) {},
            ),
            SizedBox(height: 20),
            CustomAutocomplete<String>(
              options: const [
                'Apple',
                'Banana',
                'Cherry',
                'Date',
                'Elderberry',
                'Fig',
                'Grape',
              ],
              displayStringForOption: (String option) => option,
              decoration: const InputDecoration(
                labelText: 'Search for a fruit',
                border: OutlineInputBorder(),
              ),
              onSelected: (String selection) {},
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     key: _textFieldKey,
            //     decoration: InputDecoration(
            //       hintText: 'Tap and hold for context menu...',
            //       suffixIcon: IconButton(
            //         icon: const Icon(Icons.more_vert),
            //         onPressed: () {
            //           _showContextMenu(context);
            //         },
            //       ),
            //     ),
            //     onTap: () {
            //       _showContextMenu(context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
