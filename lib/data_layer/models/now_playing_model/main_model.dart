import 'package:lavaloon/data_layer/models/now_playing_model/dates_model.dart';
import 'package:lavaloon/data_layer/models/now_playing_model/results_model.dart';

class NowPlayingModel {
  late final Dates dates;
  late final int page;
  late final List<Results> results;
  late final int totalPages;
  late final int totalResults;
  NowPlayingModel.fromJson(Map<String, dynamic> json){
    dates = Dates.fromJson(json['dates']);
    page = json['page'];
    if(json['results'] != null){
      results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}



