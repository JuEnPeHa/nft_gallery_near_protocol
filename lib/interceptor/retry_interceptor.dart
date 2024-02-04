import 'dart:io';

import 'package:nft_gallery/interceptor/dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        return e;
      }
    }
    return err;
    // if (err.type == DioErrorType.CONNECT_TIMEOUT ||
    //     err.type == DioErrorType.SEND_TIMEOUT ||
    //     err.type == DioErrorType.RECEIVE_TIMEOUT) {
    //   await requestRetrier.retry(err);
    // }
    // return super.onError(err);
  }

  bool _shouldRetry(DioError err) {
    return (err.type == DioErrorType.other && err.error != null) ||
        (err.error is SocketException && err.error != null);
  }
}
