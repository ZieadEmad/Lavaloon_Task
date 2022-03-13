
abstract class LoginStates {}

class LoginStateInitial extends LoginStates {}
class LoginStateLoading extends LoginStates {}
class LoginStateSuccess extends LoginStates {
  String success ;
  LoginStateSuccess(this.success);
}
class LoginStateError extends LoginStates {
  String error;
  LoginStateError(this.error);
}


