abstract class AuthCheckerStates {}

class AuthCheckerStateInitial extends AuthCheckerStates {}
class AuthCheckerStateLoading extends AuthCheckerStates {}
class AuthCheckerStateSuccess extends AuthCheckerStates {
  String success ;
  AuthCheckerStateSuccess(this.success);
}