import 'package:flutter/material.dart';

import '../nasa/cad/bloc/cad_state.dart';

class WorkerButton extends StatelessWidget {
  const WorkerButton({
    super.key,
    this.icon,
    required this.label,
    required this.networkState,
    this.onPressed,
  });

  final Widget? icon;
  final Widget label;
  final NetworkState networkState;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (networkState == NetworkState.preparing ||
        networkState == NetworkState.sending) {
      late final Widget icon;
      if (this.icon == null) {
        icon = SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        );
      } else {
        icon = this.icon!;
      }
      return AbsorbPointer(
        absorbing: true,
        child: FilledButton.icon(
          icon: icon,
          label: label,
          onPressed: () {}, // coverage:ignore-line
        ),
      );
    } else {
      return FilledButton(
        onPressed: onPressed,
        child: label,
      );
    }
  }
}
