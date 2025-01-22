import 'package:flutter/material.dart';

import '../domain/colors.dart';


class MyNavigationButton extends StatefulWidget {
  Color? btnBackground ;
  Color? iconColor ; 
  IconData btnIcon ;
  VoidCallback onPressed ;
  
  MyNavigationButton({super.key , 
     this.btnBackground , 
     this.iconColor  , 
    required this.btnIcon ,
    required this.onPressed
  });

  @override
  State<MyNavigationButton> createState() => _MyNavigationButtonState();
}

class _MyNavigationButtonState extends State<MyNavigationButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: widget.onPressed ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation:0,
      backgroundColor: AppColors.primaryLight.withOpacity(0.3),
      child:Icon(widget.btnIcon),);
  }
}
