import 'package:material_ui/material_ui.dart';

import '../../../l10n/l10n.dart';

/// Title and description of a deck, returned by [showDeckEditorDialog].
typedef DeckFields = ({String title, String description});

/// Create (no [initial]) or edit a deck's title and description. Resolves to
/// null when cancelled.
Future<DeckFields?> showDeckEditorDialog(
  BuildContext context, {
  DeckFields? initial,
}) {
  return showDialog<DeckFields>(
    context: context,
    builder: (_) => _DeckEditorDialog(initial: initial),
  );
}

class _DeckEditorDialog extends StatefulWidget {
  const _DeckEditorDialog({this.initial});

  final DeckFields? initial;

  @override
  State<_DeckEditorDialog> createState() => _DeckEditorDialogState();
}

class _DeckEditorDialogState extends State<_DeckEditorDialog> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _description = TextEditingController(
    text: widget.initial?.description,
  );

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    if (_title.text.trim().isEmpty) return;
    Navigator.of(
      context,
    ).pop((title: _title.text.trim(), description: _description.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(widget.initial == null ? l10n.deckNew : l10n.deckEdit),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: l10n.deckFieldTitle),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _description,
            textCapitalization: TextCapitalization.sentences,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(hintText: l10n.deckFieldDescription),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: _title.text.trim().isEmpty ? null : _submit,
          child: Text(
            widget.initial == null ? l10n.actionCreate : l10n.actionSave,
          ),
        ),
      ],
    );
  }
}
