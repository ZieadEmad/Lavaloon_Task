
import 'package:lavaloon/data_layer/models/watch_list_model/results_model.dart';

class WatchListModel {

  late final int page;
  late final List<Results> results;
  late final int totalPages;
  late final int totalResults;
  WatchListModel.fromJson(Map<String, dynamic> json){
    page = json['page'];
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}



