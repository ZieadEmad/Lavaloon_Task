import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/cubit.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/states.dart';
import 'package:lavaloon/business_layer/now_playing_cubit/cubit.dart';
import 'package:lavaloon/business_layer/now_playing_cubit/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/data_layer/models/now_playing_model/main_model.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';
import 'package:lavaloon/ui_layer/shared_widgets/build_app_bar/build_app_bar.dart';
import 'package:lavaloon/ui_layer/shared_widgets/build_toast/build_toast.dart';
import 'package:lavaloon/ui_layer/widgets/now_playing_widgets/now_playing_item.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(appBarTitle: 'Now Playing',),
      body: BlocProvider(
        create: (context) => GetNowPlayingCubit()..getNowPlayingData(1),
        child: BlocConsumer<GetNowPlayingCubit, GetNowPlayingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            int currentPage = GetNowPlayingCubit.get(context).currentPage;
            int totalPages = GetNowPlayingCubit.get(context).totalPages;
           late NowPlayingModel nowPlayingModel =  GetNowPlayingCubit.get(context).nowPlayingModel;
            return ConditionalBuilder(
              condition: state is GetNowPlayingStateLoading,
              builder: (context)=>const Center(child: CircularProgressIndicator(),),
              fallback:(context)=> ConditionalBuilder(
                condition: state is GetNowPlayingStateError,
                builder: (context)=>const Center(child: Text('ERROR'),),
                fallback: (context)=> ConditionalBuilder(
                  condition: nowPlayingModel != null || state is GetNowPlayingStateSuccess || state is ChangePageIndexState,
                  builder: (context)=> SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child:  BlocConsumer<AddRemoveFromWatchListCubit,AddRemoveFromWatchListStates>(
                        listener: (context,state){
                          if(state is  AddRemoveFromWatchListStateSuccess){
                            showToast(text: state.successMessage, error: false);
                          }
                          if(state is  AddRemoveFromWatchListStateError){
                            showToast(text: state.error, error: true);
                          }
                          if(state is  AddRemoveFromWatchListStateLoading){
                            const Center(child: CircularProgressIndicator(),) ;
                          }
                        },
                        builder: (context,state){
                          return  Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height/80,),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context,index)=> NowPlayingItem(
                                    favoritePress: (){
                                      if(getUserId() == null || getUserId()!.isEmpty || getUserId()!.length == 0 ){
                                        showToast(text: 'Please Sign In First', error: true);
                                      }
                                      if(getUserId() != null || getUserId()!.isNotEmpty || getUserId()!.length != 0 ){
                                        AddRemoveFromWatchListCubit.get(context).addRemoveFromWatchList(
                                            mediaType: 'movie',
                                            mediaId: nowPlayingModel.results[index].id,
                                            watchList: true,
                                        );
                                      }
                                    },
                                    imagePath: '${nowPlayingModel.results[index].backdropPath}',
                                    details: '${nowPlayingModel.results[index].title}',
                                    description: '${nowPlayingModel.results[index].overview}',
                                  ),
                                  separatorBuilder: (context,state)=> SizedBox(height: MediaQuery.of(context).size.height/250,),
                                  itemCount: nowPlayingModel.results.length,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        if(currentPage == 1){
                                          showToast(text: 'You in first page', error: true);
                                        }
                                        if(currentPage == totalPages || currentPage < totalPages && currentPage != 1){
                                          GetNowPlayingCubit.get(context).changeCurrentPageDown();
                                          GetNowPlayingCubit.get(context).getNowPlayingData(currentPage);
                                        }
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2.8,
                                        height: 50,
                                        color: Colors.red,
                                        child:const Center(child: Text('Back',style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 4,),
                                        Text(currentPage.toString(),style: TextStyle(color: currentPage == totalPages? Colors.red : defaultColor,fontWeight: FontWeight.bold,fontSize: 16),),
                                        const SizedBox(width: 4,),
                                        const Text('-',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                                        const SizedBox(width: 4,),
                                        Text(totalPages.toString(),style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                                        const SizedBox(width: 4,),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: (){
                                        if(currentPage == totalPages){
                                          showToast(text: 'Cant find next page', error: true);
                                        }
                                        if(currentPage != totalPages){
                                          GetNowPlayingCubit.get(context).changeCurrentPage();
                                          print(currentPage);
                                          GetNowPlayingCubit.get(context).getNowPlayingData(currentPage);
                                        }
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width/2.8,
                                        height: 50,
                                        color: defaultColor,
                                        child:const Center(child: Text('Next',style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator(),),

                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
