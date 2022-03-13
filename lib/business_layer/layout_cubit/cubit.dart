import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/layout_cubit/states.dart';
import 'package:lavaloon/ui_layer/screens/now_playing/now_playing_screen.dart';
import 'package:lavaloon/ui_layer/screens/watch_list/watch_list.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutStateInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);

  var widget = [
    const NowPlayingScreen(),
   const  WatchListScreen(),
  ];

  int currentIndex = 0 ;
  changeIndex(index){
    currentIndex = index ;
    emit(LayoutStateIndex());
  }
}