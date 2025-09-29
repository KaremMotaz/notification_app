import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theming/colors_manager.dart';
import '../theming/text_styles.dart';
import 'app_text_button.dart';
import 'custom_circular_progress_indicator.dart';

class BlocButton<C extends StateStreamable<S>, S> extends StatelessWidget {
  final bool Function(S state)? isLoading;
  final VoidCallback onPressed;
  final String label;

  const BlocButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        final bool loading = isLoading?.call(state) ?? false;
        return IgnorePointer(
          ignoring: loading,
          child: AppTextButton(
            backgroundColor: ColorsManager.mainBlue,
            buttonWidth: double.infinity,
            onPressed: onPressed,
            child: loading
                ? const CustomCircularProgressIndicator()
                : Text(
                    label,
                    style: TextStyles.bold18.copyWith(color: ColorsManager.white),
                  ),
          ),
        );
      },
    );
  }
}
