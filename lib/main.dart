import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/cubit.dart';
import 'package:lavaloon/business_layer/auth_checker_cubit/cubit.dart';
import 'package:lavaloon/business_layer/auth_checker_cubit/states.dart';
import 'package:lavaloon/business_layer/layout_cubit/cubit.dart';
import 'package:lavaloon/business_layer/login_cubit/cubit.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/domain_layer/remote.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferences();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LayoutCubit()),
        BlocProvider(create: (context)=> AddRemoveFromWatchListCubit()),
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=> AuthCheckerCubit()),
      ],
      child: BlocConsumer<AuthCheckerCubit,AuthCheckerStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            title: 'LavaLoon',
            theme: ThemeData(
              primarySwatch: defaultColor,
              primaryColor: defaultColor,
            ),
            home: AuthCheckerCubit.get(context).authCheck(),
          );
        },
      ),
    );
  }
}

