class Results {
  late final bool adult;
  late final String backdropPath;
  late final List<num> genreIds;
  late final num id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final num voteAverage;
  late final num voteCount;

  Results.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath =  '${json['backdrop_path']}';
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = '${json['original_language']}';
    originalTitle = '${json['original_title']}';
    overview = '${json['overview']}';
    popularity = json['popularity'];
    posterPath = '${json['poster_path']}';
    releaseDate = '${json['release_date']}';
    title = '${json['title']}';
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}