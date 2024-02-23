import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class TanggalHijriahCall {
  static Future<ApiCallResponse> call({
    String? tanggal = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'tanggal hijriah',
      apiUrl: 'https://api.aladhan.com/v1/gToH/${tanggal}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? data(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.hijri.date''',
      ));
  static String? bulan(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.hijri.month.en''',
      ));
  static String? tanggal(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.hijri.day''',
      ));
  static String? tahun(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data.hijri.year''',
      ));
}

class PilihKotaCall {
  static Future<ApiCallResponse> call({
    String? kota = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'pilih kota',
      apiUrl: 'https://api.myquran.com/v2/sholat/kota/cari/${kota}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? namalokasi(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.data[:].lokasi''',
      ));
  static List? all(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  static String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
}

class JadwalSholatCall {
  static Future<ApiCallResponse> call({
    String? idkota = '',
    String? tanggal = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'jadwal sholat ',
      apiUrl: 'https://api.myquran.com/v2/sholat/jadwal/${idkota}/${tanggal}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AmbilGeolokasiCall {
  static Future<ApiCallResponse> call({
    String? kordinat = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'ambil geolokasi',
      apiUrl: 'https://geocode.maps.co/reverse?${kordinat}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.city''',
      ));
  static String? lokasi(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address.county''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
