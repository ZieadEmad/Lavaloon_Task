
import 'package:lavaloon/data_layer/models/now_playing_model/main_model.dart';

abstract class GetNowPlayingStates {}

class GetNowPlayingStateInitial extends GetNowPlayingStates {}

class GetNowPlayingStateLoading extends GetNowPlayingStates {}
class GetNowPlayingStateSuccess extends GetNowPlayingStates {
 NowPlayingModel nowPlayingModel ;
  int currentPage ;
  int totalPages ;
  GetNowPlayingStateSuccess(this.nowPlayingModel,this.currentPage,this.totalPages);
}
class GetNowPlayingStateError extends GetNowPlayingStates{
  String error ;
  GetNowPlayingStateError(this.error);
}


class ChangePageIndexState extends GetNowPlayingStates {}