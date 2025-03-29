import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  VoidCallback? onConnectedCallback; // Callback for when connected

  ConnectivityProvider() {
    _checkConnection();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      bool previousState = _isConnected;
      _isConnected =
          results.isNotEmpty && results.first != ConnectivityResult.none;

      if (!_isConnected) {
        debugPrint("No Internet!");
      } else if (!_isConnected && previousState) {
        debugPrint("Reconnected to Internet!");
        if (onConnectedCallback != null) {
          onConnectedCallback!(); 
        }
      }

      notifyListeners();
    });
  }

  bool get isConnected => _isConnected;

  Future<void> _checkConnection() async {
    var results = await _connectivity.checkConnectivity();
    _isConnected =
        results.isNotEmpty && results.first != ConnectivityResult.none;
    notifyListeners();
  }

  void setOnConnectedCallback(VoidCallback callback) {
    onConnectedCallback = callback;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
