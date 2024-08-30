import 'package:flutter/material.dart';

class TextFieldWithFocusPopup extends StatefulWidget {
  @override
  _TextFieldWithFocusPopupState createState() => _TextFieldWithFocusPopupState();
}

class _TextFieldWithFocusPopupState extends State<TextFieldWithFocusPopup> {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  void _showPopup(BuildContext context) {
    final RenderBox renderBox =
        context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + size.width, // Position at the end of the TextField
        top: offset.dy + size.height, // Position below the TextField
        child: Material(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.white,
            child: Text('This is a focus-based popup!'),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showPopup(context);
      } else {
        _removePopup();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus-Based Popup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Focus here...',
            ),
          ),
        ),
      ),
    );
  }
}