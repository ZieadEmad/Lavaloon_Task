

import 'package:lavaloon/data_layer/models/watch_list_model/main_model.dart';

abstract class GetWatchListStates {}

class GetWatchListStateInitial extends GetWatchListStates {}

class GetWatchListStateLoading extends GetWatchListStates {}
class GetWatchListStateSuccess extends GetWatchListStates {
  late WatchListModel watchListModel ;
  int currentPage ;
  int totalPages ;
  GetWatchListStateSuccess(this.watchListModel,this.currentPage,this.totalPages);
}
class GetWatchListStateError extends GetWatchListStates{
  String error ;
  GetWatchListStateError(this.error);
}


class ChangePageIndexState extends GetWatchListStates {}