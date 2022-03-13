import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/auth_checker_cubit/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/ui_layer/screens/layout/layout_screen.dart';
import 'package:lavaloon/ui_layer/screens/login_screen/login_screen.dart';

class AuthCheckerCubit extends Cubit<AuthCheckerStates> {
  AuthCheckerCubit() : super(AuthCheckerStateInitial());
  static AuthCheckerCubit get(context) => BlocProvider.of(context);

  Widget authCheck(){
    if(getUserId() == null || getUserId()!.isEmpty ){
      return  LoginScreen();
    } else{
      return const LayoutScreen();
    }
  }
}