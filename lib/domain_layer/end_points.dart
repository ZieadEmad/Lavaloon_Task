import 'package:lavaloon/data_layer/local/shared_preferences.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const apikey = '31521ab741626851b73c684539c33b5a';


const createTokenEndPoint = 'authentication/token/new';
const createSessionEndPoint = 'authentication/session/new';
const loginEndPoint = 'authentication/token/validate_with_login';
const getUserDataEndPoint = 'account';

const getNowPlayingEndPoint = 'movie/now_playing';
var addRemoveFromWatchListEndPoint = 'account/${getUserId().toString()}/watchlist';
var getWatchListEndPoint = 'account/${getUserId().toString()}/watchlist/movies';



