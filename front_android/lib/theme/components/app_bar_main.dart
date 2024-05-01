import 'package:flutter/material.dart';
import 'package:front_android/theme/components/svg_icon.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarMain({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: SvgIcon(
            'bell',
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
