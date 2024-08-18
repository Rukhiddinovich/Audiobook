import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityStatus.disconnected) {
    _init();
  }

  Future<void> _init() async {
    connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result);
    });

    var connectivityResult = await connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      emit(ConnectivityStatus.connected);
    } else {
      emit(ConnectivityStatus.disconnected);
    }
  }
}
