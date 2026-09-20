import 'package:flutter/material.dart';

class GithubButton extends StatelessWidget {
  final void Function()? onTap;
  const GithubButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ),
        child: Image.asset(
          'assets/icon/github.png',
          height: 32,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}