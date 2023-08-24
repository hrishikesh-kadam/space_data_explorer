import 'package:flutter/material.dart';

import '../nasa/cad/bloc/cad_state.dart';

class OutlinedButtonExtended extends StatelessWidget {
  const OutlinedButtonExtended({
    super.key,
    this.icon = const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ),
    required this.label,
    required this.networkState,
    this.onPressed,
  });

  final Widget icon;
  final Widget label;
  final NetworkState networkState;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    if (networkState == NetworkState.preparing ||
        networkState == NetworkState.sending) {
      return AbsorbPointer(
        absorbing: true,
        child: OutlinedButton.icon(
          icon: icon,
          label: label,
          onPressed: () {}, // coverage:ignore-line
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        child: label,
      );
    }
  }
}
