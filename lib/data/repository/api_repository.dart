import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/data/service/api_service.dart';

class ApiRepository {
  final ApiService apiService;

  ApiRepository({required this.apiService});

  Future<AudiobookModel> getAudiobooks() async {
    return apiService.getAudiobooks();
  }

  Future<AudiobookModel> fetchAudiobooksFromApi() async {
    return apiService.fetchAudiobooksFromApi();
  }
}
