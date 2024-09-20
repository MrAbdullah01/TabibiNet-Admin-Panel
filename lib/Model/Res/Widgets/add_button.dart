import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key,required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: onTap,
        child: const Icon(CupertinoIcons. add,color: bgColor,),
      ),
    );
  }
}
