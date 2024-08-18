import 'package:flutter/material.dart';

void myPrint(dynamic data) {
  debugPrint(data.toString());
}

class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

extension SizeExtension on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

const String mainBaseUrl = "https://spotify23.p.rapidapi.com";
const String mainBaseUrl2 = "https://www.deezer.com";


class AppConstants {
  AppConstants._();

  static const String kLastIndexKey = 'last_played_audio_index_key';
  static const String kLastPositionOfAudioKey = 'last_position_of_audio_key';
  static const String kDownloadedFilePathsKey = 'downloaded_file_paths_key';
  static const String kPlaylistOrderKey = 'playlist_order_key';
}
