abstract class AddRemoveFromWatchListStates {}

class AddRemoveFromWatchListStateInitial extends AddRemoveFromWatchListStates {}
class AddRemoveFromWatchListStateLoading extends AddRemoveFromWatchListStates {}
class AddRemoveFromWatchListStateSuccess extends AddRemoveFromWatchListStates {
  String successMessage ;
  AddRemoveFromWatchListStateSuccess(this.successMessage);
}
class AddRemoveFromWatchListStateError extends AddRemoveFromWatchListStates {
  String error;
  AddRemoveFromWatchListStateError(this.error);
}