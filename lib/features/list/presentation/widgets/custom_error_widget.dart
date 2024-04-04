import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String text;

  final Future<void> Function() onRefresh;

  const CustomErrorWidget({
    super.key,
    required this.text,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
            ],
          ),
        )
      ]),
    );
  }
}
