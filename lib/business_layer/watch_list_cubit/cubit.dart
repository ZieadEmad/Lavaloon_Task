import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/watch_list_cubit/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/data_layer/models/now_playing_model/main_model.dart';
import 'package:lavaloon/data_layer/models/watch_list_model/main_model.dart';
import 'package:lavaloon/domain_layer/end_points.dart';
import 'package:lavaloon/domain_layer/remote.dart';

class GetWatchListCubit extends Cubit<GetWatchListStates> {
  GetWatchListCubit() : super(GetWatchListStateInitial());
  static GetWatchListCubit get(context) => BlocProvider.of(context);
  late WatchListModel watchListModel ;
  int currentPage = 1 ;
  int totalPages = 0 ;
  getWatchListData(page){
    emit(GetWatchListStateLoading());
    print(getWatchListEndPoint);
    DioHelper.getData(
        path: getWatchListEndPoint,
        query: {
          'api_key': apikey,
          'session_id': getSessionId(),
          'page': currentPage
      }
    ).then((value) {
      print(value.data);
      watchListModel = WatchListModel.fromJson(value.data);
      currentPage = int.parse('${watchListModel.page}');
      totalPages = int.parse('${watchListModel.totalPages}');
      emit(GetWatchListStateSuccess(watchListModel,currentPage,totalPages));
    }).catchError((e)
    {
      if (e is DioError){
        print('${e.response!.data['message']}');
        emit(GetWatchListStateError('${e.response!.data['message']}'));
      } else {
        print('${e.toString()}');
        emit(GetWatchListStateError('$e'));
      }
    });
  }
  changeCurrentPage(){
    if(currentPage < totalPages){
      currentPage ++ ;
      print(currentPage);
      emit(ChangePageIndexState());
    }
  }
  changeCurrentPageDown(){
    if(currentPage == totalPages || currentPage < totalPages && currentPage != 1){
      currentPage -- ;
      emit(ChangePageIndexState());
    }
  }
}