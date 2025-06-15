import 'package:flutter/material.dart';
import 'package:client/core/resources/language_strings.dart';

class ConfirmPopupComponent extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmPopupComponent({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(LanguageStrings.cancel),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(LanguageStrings.confirm),
        ),
      ],
    );
  }
}
