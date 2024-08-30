import 'package:flutter/material.dart';

class TextFieldWithPopup extends StatefulWidget {
  @override
  _TextFieldWithPopupState createState() => _TextFieldWithPopupState();
}

class _TextFieldWithPopupState extends State<TextFieldWithPopup> {
  final GlobalKey _textFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showPopup(BuildContext context) {
    final RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
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
            child: Text('This is a popup!'),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup at End of TextField'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            key: _textFieldKey,
            decoration: InputDecoration(
              hintText: 'Tap here...',
              suffixIcon: IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  if (_overlayEntry == null) {
                    _showPopup(context);
                  } else {
                    _removePopup();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removePopup();
    super.dispose();
  }
}