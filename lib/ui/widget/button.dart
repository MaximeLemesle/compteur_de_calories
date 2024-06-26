import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool showIcon;
  final bool isTitle;

  const Button({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.showIcon = true,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon)
            const Icon(
              Icons.add,
              size: 16,
            ),
          if (showIcon) const SizedBox(width: 8),
          Text(
            buttonText,
            style: isTitle
                ? Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white)
                : Theme.of(context).textTheme.labelSmall,
          )
        ],
      ),
    );
  }
}
