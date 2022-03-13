import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/now_playing_cubit/states.dart';
import 'package:lavaloon/data_layer/models/now_playing_model/main_model.dart';
import 'package:lavaloon/domain_layer/end_points.dart';
import 'package:lavaloon/domain_layer/remote.dart';

class GetNowPlayingCubit extends Cubit<GetNowPlayingStates> {
  GetNowPlayingCubit() : super(GetNowPlayingStateInitial());
  static GetNowPlayingCubit get(context) => BlocProvider.of(context);
  late NowPlayingModel nowPlayingModel ;
  int currentPage = 1 ;
  int totalPages = 0 ;
  getNowPlayingData(page){
    emit(GetNowPlayingStateLoading());
    DioHelper.getData(
        path: getNowPlayingEndPoint,
        query: {
          'api_key': apikey,
          'page': currentPage
      }
    ).then((value) {
      nowPlayingModel = NowPlayingModel.fromJson(value.data);
      currentPage = int.parse('${nowPlayingModel.page}');
      totalPages = int.parse('${nowPlayingModel.totalPages}');
      emit(GetNowPlayingStateSuccess(nowPlayingModel,currentPage,totalPages));
    }).catchError((e)
    {
      if (e is DioError){
        print('${e.response!.data['message']}');
        emit(GetNowPlayingStateError('${e.response!.data['message']}'));
      } else {
        print('${e.toString()}');
        emit(GetNowPlayingStateError('$e'));
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