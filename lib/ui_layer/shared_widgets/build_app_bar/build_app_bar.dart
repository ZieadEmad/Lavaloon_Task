import 'package:flutter/material.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';

class BuildAppBar extends AppBar {
   BuildAppBar({
     Key? key,
     required this.appBarTitle,
   }) : super(
       key: key,
     backgroundColor: Colors.white,
     bottom: PreferredSize(
       child: Container(),
       preferredSize:const Size(70, 10),
     ),
     shape: const RoundedRectangleBorder(
       borderRadius: BorderRadius.vertical(
         bottom: Radius.circular(30),
       ),
     ),
     title:  Text('$appBarTitle',
         style:const TextStyle(
             color: Color(0xff36596a),
             fontWeight: FontWeight.w700,
             fontFamily: "Poppins",
             fontStyle: FontStyle.normal,
             fontSize: 20.0),
         textAlign: TextAlign.left),
     iconTheme:const IconThemeData(color: defaultColor),
     centerTitle: true,
   );
  String appBarTitle ;
  @override
  Widget build(BuildContext context) {
    return AppBar();
  }
}
