import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final FocusNode? focusNode;

  const CustomTextInput({this.focusNode, super.key});

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput>
    implements TextInputClient {
  late FocusNode focusNode;
  TextInputConnection? _connection;
  TextEditingValue? _textEditingValue;

  bool get _hasInputConnection => _connection?.attached ?? false;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();

    widget.focusNode?.addListener(_onFocusChanged);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void _onFocusChanged() {
    if (focusNode.hasFocus) {
      _openInputConnection();
    } else {
      _closeInputConnection();
    }
  }

  void _closeInputConnection() {
    if (_hasInputConnection) {
      _connection!.close();
      _connection = null;
    }
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _connection = TextInput.attach(
        this,
        const TextInputConfiguration(inputType: TextInputType.visiblePassword),
      );
    }
    _connection!.show();
  }

  @override
  AutofillScope? get currentAutofillScope => null;

  @override
  TextEditingValue? get currentTextEditingValue => _textEditingValue;

  @override
  void didChangeInputControl(
      TextInputControl? oldControl, TextInputControl? newControl) {}

  @override
  void insertTextPlaceholder(Size size) {}

  @override
  void performAction(TextInputAction action) {}

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {}

  @override
  void performSelector(String selectorName) {}

  @override
  void removeTextPlaceholder() {}

  @override
  void showAutocorrectionPromptRect(int start, int end) {}

  @override
  void showToolbar() {}

  @override
  void updateEditingValue(TextEditingValue value) {
    print(value.text);
    _textEditingValue = value;
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  @override
  void connectionClosed() {
    _closeInputConnection();
  }
}
