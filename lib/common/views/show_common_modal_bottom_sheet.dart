import 'package:flutter/material.dart';

Future<T?> showCommonModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool useSafeArea = false,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    builder: builder,
    useSafeArea: useSafeArea,
  );
}
