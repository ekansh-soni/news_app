class AppConstants{
  AppConstants._();


  static const String apiSecret = "f4a3347aee364384802774820d6f9866";
  static const String baseUrl = "https://newsapi.org/v2/everything?q=keyword&apiKey=$apiSecret";
  static const bool progress_dismissiable = false;
  static const String noDataError = "No Data Found";

  static const int connectionTimeout = 300000;
  static const int receiveTimeout = 300000;

}