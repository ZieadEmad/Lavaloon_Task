import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/cubit.dart';
import 'package:lavaloon/business_layer/add_remove_watch_list/states.dart';
import 'package:lavaloon/business_layer/layout_cubit/cubit.dart';
import 'package:lavaloon/business_layer/watch_list_cubit/cubit.dart';
import 'package:lavaloon/business_layer/watch_list_cubit/states.dart';
import 'package:lavaloon/data_layer/local/shared_preferences.dart';
import 'package:lavaloon/data_layer/models/now_playing_model/main_model.dart';
import 'package:lavaloon/data_layer/models/watch_list_model/main_model.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';
import 'package:lavaloon/ui_layer/shared_widgets/build_app_bar/build_app_bar.dart';
import 'package:lavaloon/ui_layer/shared_widgets/build_toast/build_toast.dart';
import 'package:lavaloon/ui_layer/widgets/now_playing_widgets/now_playing_item.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(appBarTitle: 'Watch List',),
      body: BlocProvider(
        create: (context) => GetWatchListCubit()..getWatchListData(1),
        child: BlocConsumer<GetWatchListCubit, GetWatchListStates>(
          listener: (context, state) {},
          builder: (context, state) {
            int currentPage = GetWatchListCubit.get(context).currentPage;
            int totalPages = GetWatchListCubit.get(context).totalPages;
            late WatchListModel watchListModel =  GetWatchListCubit.get(context).watchListModel;
            return ConditionalBuilder(
              condition: getUserId() == null || getUserToken() == null || getUserId()!.isEmpty || getUserId()!.isEmpty  ,
              builder: (context)=>const Center(
                child: Text('Please Login First'),
              ),
              fallback: (context)=> ConditionalBuilder(
                condition: state is GetWatchListStateLoading,
                builder: (context)=>const Center(child: CircularProgressIndicator(),),
                fallback:(context)=> ConditionalBuilder(
                  condition: state is GetWatchListStateError,
                  builder: (context)=>const Center(child: Text('ERROR'),),
                  fallback: (context)=> ConditionalBuilder(
                    condition: watchListModel != null || state is GetWatchListStateSuccess || state is ChangePageIndexState,
                    builder: (context)=> ConditionalBuilder(
                      condition: watchListModel.results.isEmpty ,
                      builder: (context)=>const Center(child: Text('No Movies Yet...'),) ,
                      fallback: (context)=> SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child:  BlocConsumer<AddRemoveFromWatchListCubit,AddRemoveFromWatchListStates>(
                            listener: (context,state){
                              if(state is  AddRemoveFromWatchListStateSuccess){
                                showToast(text: state.successMessage, error: false);
                                LayoutCubit.get(context).changeIndex(0);
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
                                              mediaId: watchListModel.results[index].id,
                                              watchList: false,
                                            );
                                          }
                                        },
                                        imagePath: '${watchListModel.results[index].backdropPath}',
                                        details: '${watchListModel.results[index].title}',
                                        description: '${watchListModel.results[index].overview}',
                                      ),
                                      separatorBuilder: (context,state)=> SizedBox(height: MediaQuery.of(context).size.height/250,),
                                      itemCount: watchListModel.results.length,
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
                                              GetWatchListCubit.get(context).changeCurrentPageDown();
                                              GetWatchListCubit.get(context).getWatchListData(currentPage);
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
                                              GetWatchListCubit.get(context).changeCurrentPage();
                                              print(currentPage);
                                              GetWatchListCubit.get(context).getWatchListData(currentPage);
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
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator(),),

                  ),
                ),
              ),

            );
          },
        ),
      ),
    );
  }
}
