import 'package:flutter/material.dart';
import '../../ihelper/shared_variables.dart';

class CustAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustAppBar({
    super.key,
    required this.title,
    this.isSyncVisible = true,
    this.onSyncPressed,
  });

  final String title;
  final bool isSyncVisible;
  final VoidCallback? onSyncPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: myGoldenColor,
        ),
      ),

      backgroundColor: Colors.black87,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustDrawer()),
          );
          */
        },
        icon: Icon(Icons.menu),
        color: Colors.grey,
      ),

      actions: [
        if (isSyncVisible)
          IconButton(
            onPressed: onSyncPressed,
            icon: Icon(Icons.sync),
            color: myGoldenColor,
          ),
      ],
    );
  }
}
