import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/login_cubit/cubit.dart';
import 'package:lavaloon/business_layer/login_cubit/states.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';
import 'package:lavaloon/ui_layer/helpers/navigations/navigations.dart';
import 'package:lavaloon/ui_layer/screens/layout/layout_screen.dart';
import 'package:lavaloon/ui_layer/shared_widgets/build_toast/build_toast.dart';
import 'package:lavaloon/ui_layer/shared_widgets/custom_text_field_without_icon/custom_text_field_without_icon.dart';
import 'package:lavaloon/ui_layer/shared_widgets/default_button/default_button.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions:  [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: (){
                navigateAndFinish(context,const LayoutScreen());
              },
                child: const Text('Skip',style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 20),)
            ),
          ),
        ],
      ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginStateLoading ){
            const  Center(child: CircularProgressIndicator(),);
          }
          if(state is LoginStateSuccess){
            showToast(text: state.success, error: false);
            navigateAndFinish(context,const LayoutScreen());
          }
          if(state is LoginStateError){
            showToast(text: state.error, error: true);
          }
        },
        builder: (context,state){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  const Text('Login',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 35),),
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFieldWithoutIcon(
                              hintLabel: 'User Name',
                              controller: userNameController,
                              textInputType: TextInputType.name,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter Your User Name';
                                }
                              },
                              isPassword: false
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/30,),
                          CustomTextFieldWithoutIcon(
                              hintLabel: 'Password',
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter Your Password';
                                }
                              },
                              isPassword: true
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Center(
                    child: DefaultButton(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.3,
                      function: (){
                        if(formKey.currentState!.validate()){
                          LoginCubit.get(context).login(
                            username: userNameController.text.toString(),
                            password: passwordController.text.toString(),
                          );
                        }
                      },
                      radius: 16,
                      titleColor: Colors.white,
                      fontSize: 16,
                      text: 'Login',
                      toUpper: false,
                      background: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
