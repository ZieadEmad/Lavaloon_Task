import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/layout_cubit/cubit.dart';
import 'package:lavaloon/business_layer/layout_cubit/states.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var currentIndex = LayoutCubit.get(context).currentIndex;
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 15,
                ),
              ],
              color: Colors.white,
              borderRadius:const BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Icon(Icons.home , color:currentIndex==0?
                    defaultColor: Colors.grey, )
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child:Icon(Icons.favorite ,
                      color:currentIndex==1?
                    defaultColor: Colors.grey, )
                  ),
                  label: '',
                ),
              ],
              onTap: (index) {
                LayoutCubit.get(context).changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              unselectedItemColor:const Color.fromRGBO(181, 183, 195, 1.0),
              currentIndex: currentIndex,
            ),
          ),
          body: LayoutCubit.get(context).widget[currentIndex],
        );
      },
    );
  }
}
