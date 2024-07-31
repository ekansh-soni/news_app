import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../Utils/strings.dart';
import 'api_exception.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout:  const Duration(milliseconds: AppConstants.connectionTimeout),
    receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
    responseType: ResponseType.json,
  );

  // dio instance
  final Dio _dio = Dio(_options)
    //..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true));

  // GET request
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
