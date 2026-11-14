import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/widget/app_bottom_sheet.dart';

void showTripDetailMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showTripDetailComingSoon(BuildContext context) =>
    showTripDetailMessage(context, 'Tính năng đang phát triển');

enum TripDetailMoreAction { edit, delete }

Future<TripDetailMoreAction?> showTripDetailOwnerMoreSheet(
  BuildContext context,
) {
  return showAppBottomSheet<TripDetailMoreAction>(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: const Text('Chỉnh sửa chuyến đi'),
          onTap: () => Navigator.of(context).pop(TripDetailMoreAction.edit),
        ),
        ListTile(
          leading: Icon(Icons.delete_outline, color: AppColors.danger),
          title: Text(
            'Xóa chuyến đi',
            style: TextStyle(color: AppColors.danger),
          ),
          onTap: () => Navigator.of(context).pop(TripDetailMoreAction.delete),
        ),
      ],
    ),
  );
}

Future<bool> confirmTripDetailAction(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(onPressed: () => ctx.pop(false), child: const Text('Hủy')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
          onPressed: () => ctx.pop(true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
