---
name: adaptive_dialog-dialogs
description: >-
  Use when showing platform-adaptive alert dialogs, confirmation dialogs, modal action sheets,
  or text input dialogs across iOS, Android, macOS, and Web using adaptive_dialog.
---

# adaptive_dialog Dialogs & Action Sheets Guide

`adaptive_dialog` presents dialogs and action sheets adaptively matching the host platform (Cupertino style on iOS/macOS, Material Design 3 style on Android/Web/Desktop).

## Guidelines

- **Always Use Adaptive Helpers Over Raw Dialogs**:
  - Instead of handcrafting `showDialog(builder: (_) => AlertDialog(...))` or `showCupertinoDialog`, use `showOkAlertDialog`, `showOkCancelAlertDialog`, `showConfirmationDialog`, or `showModalActionSheet`.
- **Handling Results**:
  - `showOkCancelAlertDialog()` returns `OkCancelResult.ok` or `OkCancelResult.cancel`. Always check `if (result == OkCancelResult.ok)` rather than comparing against boolean or null.
  - `showModalActionSheet<T>()` returns the generic key `T?` associated with the chosen `BottomSheetAction<T>`. It returns `null` if dismissed.
- **Destructive Actions**:
  - Set `isDestructiveAction: true` on `BottomSheetAction` or `AlertDialogAction` for dangerous actions (e.g. Delete, Reset, Logout). This automatically applies platform-appropriate red text and emphasis.
- **Text Input**:
  - Use `showTextInputDialog()` to solicit one or more user inputs without manually wiring `TextEditingController` boilerplate and dialog state.
- **Platform Overrides (Optional)**:
  - If a uniform design across platforms is explicitly requested, pass `style: AdaptiveStyle.material` or `style: AdaptiveStyle.cupertino`.

## Examples

### 1. Alert & Confirmations

```dart
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

Future<void> confirmAccountDeletion(BuildContext context) async {
  final result = await showOkCancelAlertDialog(
    context: context,
    title: 'Delete Account',
    message: 'Are you sure you want to delete your account? This action cannot be undone.',
    okLabel: 'Delete',
    cancelLabel: 'Cancel',
    isDestructiveAction: true,
  );

  if (result == OkCancelResult.ok) {
    // Proceed with account deletion
  }
}
```

### 2. Modal Action Sheet with Generic Keys

```dart
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

enum PostAction { edit, share, delete }

Future<void> showPostMenu(BuildContext context) async {
  final action = await showModalActionSheet<PostAction>(
    context: context,
    title: 'Post Options',
    actions: const [
      BottomSheetAction(title: 'Edit Post', key: PostAction.edit, icon: Icons.edit),
      BottomSheetAction(title: 'Share', key: PostAction.share, icon: Icons.share),
      BottomSheetAction(
        title: 'Delete Post',
        key: PostAction.delete,
        icon: Icons.delete,
        isDestructiveAction: true,
      ),
    ],
  );

  switch (action) {
    case PostAction.edit:
      // Handle edit
      break;
    case PostAction.share:
      // Handle share
      break;
    case PostAction.delete:
      // Handle delete
      break;
    case null:
      // User tapped outside or dismissed
      break;
  }
}
```

### 3. Text Input Dialog

```dart
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

Future<void> renameItem(BuildContext context, String currentName) async {
  final inputs = await showTextInputDialog(
    context: context,
    title: 'Rename Item',
    textFields: [
      DialogTextField(
        initialText: currentName,
        hintText: 'Enter new name',
        validator: (value) =>
            (value == null || value.trim().isEmpty) ? 'Name cannot be empty' : null,
      ),
    ],
  );

  if (inputs != null && inputs.isNotEmpty) {
    final newName = inputs.first;
    print('Renamed to: $newName');
  }
}
```

## Common Pitfalls & Anti-Patterns

- ❌ **Anti-pattern**: Writing `Platform.isIOS ? CupertinoAlertDialog(...) : AlertDialog(...)` manually, which is fragile, misses macOS/Web adaptations, and creates repetitive boilerplate.
  - ✔️ **Correct**: Use `showOkAlertDialog` or `showOkCancelAlertDialog`.
- ❌ **Anti-pattern**: Forgetting to check for `null` when `showModalActionSheet` is dismissed without selection.
  - ✔️ **Correct**: Always handle the `null` case gracefully.
