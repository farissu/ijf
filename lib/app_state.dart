import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _lokasi = 'Bandung';
  String get lokasi => _lokasi;
  set lokasi(String _value) {
    _lokasi = _value;
  }

  String _idlokasi = '1201';
  String get idlokasi => _idlokasi;
  set idlokasi(String _value) {
    _idlokasi = _value;
  }

  bool _hubungananak = false;
  bool get hubungananak => _hubungananak;
  set hubungananak(bool _value) {
    _hubungananak = _value;
  }
}
