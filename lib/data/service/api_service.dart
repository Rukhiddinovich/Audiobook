import 'package:dio/dio.dart';
import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/utils/constants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: mainBaseUrl,
      headers: {
        'Content-Type': 'application/json',
        'x-rapidapi-key': '30594dab10mshc46d27ffca40c79p1fcf71jsn1c313ee34c07',
      },
      // Uncomment the following lines if you need to set timeout durations
      // connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      // sendTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      // receiveTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  void _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, handler) {
          myPrint("ERROR GA KIRDI ------> : ${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (RequestOptions requestOptions, handler) {
          myPrint("SO'ROV JO'NATILDI ------> : ${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (Response response, handler) {
          myPrint("RESPONSE QABUL QILINDI ------> : ${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<AudiobookModel> getAudiobooks() async {
    try {
      final response = await _dio.get("https://deezerdevs-deezer.p.rapidapi.com/search?q=eminem");
      myPrint("Response -----------> $response.data");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AudiobookModel.fromJson(response.data);
      } else {
        throw Exception("Error: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      String errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = "Connection Timeout Error: ${e.message}";
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = "Send Timeout Error: ${e.message}";
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = "Receive Timeout Error: ${e.message}";
          break;
        case DioExceptionType.badResponse:
          errorMessage = "Bad Response - Status: ${e.response?.statusCode}, Data: ${e.response?.data}";
          break;
        case DioExceptionType.cancel:
          errorMessage = "Request Cancelled: ${e.message}";
          break;
        case DioExceptionType.unknown:
          errorMessage = "Unknown Error: ${e.message}";
          break;
        default:
          errorMessage = "Unexpected Dio Error: ${e.message}";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}
