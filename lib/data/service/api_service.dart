import 'package:dio/dio.dart';
import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/utils/constants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: mainBaseUrl,
      headers: {
        'Content-Type': 'application/json',
        'x-rapidapi-key':'30594dab10mshc46d27ffca40c79p1fcf71jsn1c313ee34c07',
      },
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
        onError: (error, handler) {
          print("ERROR GA KIRDI ------> : ${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) {
          print("SO'ROV JO'NATILDI ------> : ${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          print("RESPONSE JO'NATILDI ------> : ${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<AudiobookModel> getAudiobooks() async {
    try {
      final response = await _dio.get("https://deezerdevs-deezer.p.rapidapi.com/search?q=eminem");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AudiobookModel.fromJson(response.data);
      } else {
        throw Exception("Error: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            "Dio Error - Status: ${e.response?.statusCode}, Data: ${e.response?.data}");
      } else {
        throw Exception("Dio Error - Message: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  // Future<AudiobookModel> getAudiobooks({int offset = 0, int limit = 10}) async {
  //   try {
  //     final response = await _dio.get(
  //       "$mainBaseUrl/search/",
  //       queryParameters: {
  //         'q': 'Travis+Scot',
  //         'type': 'multi',
  //         'offset': offset,
  //         'limit': limit,
  //         'numberOfTopResults': 5,
  //       },
  //     );
  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return AudiobookModel.fromJson(response.data);
  //     } else {
  //       throw Exception("Error: ${response.statusCode} - ${response.data}");
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       throw Exception(
  //           "Dio Error - Status: ${e.response?.statusCode}, Data: ${e.response?.data}");
  //     } else {
  //       throw Exception("Dio Error - Message: ${e.message}");
  //     }
  //   } catch (e) {
  //     throw Exception("Unexpected Error: $e");
  //   }
  // }
}
