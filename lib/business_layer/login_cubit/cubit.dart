import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/login_cubit/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/domain_layer/end_points.dart';
import 'package:lavaloon/domain_layer/remote.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStateInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login({@required username, @required password}) {
    emit(LoginStateLoading());
    DioHelper.getData(
        path: createTokenEndPoint,
        query: {
          'api_key': apikey,
        }
    ).then((value) {
    saveUserToken('${value.data['request_token']}');
    print(value.data['request_token']);
    DioHelper.postData(
        path: loginEndPoint,
        query: {
          'api_key':apikey,
        },
        data: {
          'username': '$username',
          'password': '$password',
          'request_token': value.data['request_token'],
        }).then((value) {
      print(value.data['request_token']);
      DioHelper.postData(
          path: createSessionEndPoint,
          query: {
            'api_key':apikey,
          },
          data: {
            'request_token': value.data['request_token'],
          }).then((value) {
        print(value.data['session_id']);
            saveSessionId('${value.data['session_id']}');
        DioHelper.getData(
          path: getUserDataEndPoint,
          query: {
            'api_key':apikey,
            'session_id':value.data['session_id'],
          },
        ).then((value) {
          print(value.data['id']);
         saveUserId('${value.data['id']}');
         emit(LoginStateSuccess('Login Successfully'));
        }).catchError((e) {
          if (e is DioError) {
            emit(LoginStateError('${e.response!.data['message']}'));
          } else {}
        });
      }).catchError((e) {
        if (e is DioError) {
          emit(LoginStateError('${e.response!.data['message']}'));
        } else {
          print(e.toString());
        }
      });
    }).catchError((e) {
      if (e is DioError) {
        emit(LoginStateError('${e.response!.data['message']}'));
      } else {
        print(e.toString());
      }
    });
    }).catchError((e) {
      if (e is DioError) {
        emit(LoginStateError('${e.response!.data['message']}'));
      } else {
        print(e.toString());
      }
    });
    }

  }
