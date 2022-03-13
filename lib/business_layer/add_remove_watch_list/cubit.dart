import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/domain_layer/end_points.dart';
import 'package:lavaloon/domain_layer/remote.dart';

class AddRemoveFromWatchListCubit extends Cubit<AddRemoveFromWatchListStates> {
  AddRemoveFromWatchListCubit() : super(AddRemoveFromWatchListStateInitial());
  static AddRemoveFromWatchListCubit get(context) => BlocProvider.of(context);

  void addRemoveFromWatchList({
    @required mediaType,
    @required mediaId,
    @required watchList,
  }) {
    emit(AddRemoveFromWatchListStateLoading());
    DioHelper.postData(
        path: addRemoveFromWatchListEndPoint,
        query: {
          'api_key': apikey,
          'session_id': getSessionId(),
        },
        data: {
          'media_type': '$mediaType',
          'media_id': mediaId,
          'watchlist': watchList,
        }).then((value) {
      emit(AddRemoveFromWatchListStateSuccess(value.data['status_message']));
    }).catchError((e) {
      if (e is DioError) {
        emit(AddRemoveFromWatchListStateError('${e.response!.data['message']}'));
      } else {
        print(e.toString());
      }
    });
  }

}