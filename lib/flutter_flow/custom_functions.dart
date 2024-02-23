import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/auth/firebase_auth/auth_util.dart';

String? date(DateTime? input) {
  // convert date 13/2/2024 menjadi 13-2-2024
  if (input == null) return null;
  final formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(input);
}

String? waktuSholatsatu(String? waktu) {
  // buatkan fungsi jika waktu >= 05.00 and <= 11.00 tampilakan Dzuhur input seperti ini 2/13/2024 8:15
  if (waktu == null) return null;

  DateTime parsedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(waktu!);
  final jam = parsedDateTime.hour.toDouble();

  if (jam >= 05.00 && jam <= 11.00) {
    return "Dzuhur";
  } else if (jam >= 12.00 && jam <= 15.00) {
    return "Ashar";
  } else if (jam >= 15.00 && jam <= 18.00) {
    return "Maghrib";
  } else if (jam >= 18.00 && jam <= 19.00) {
    return "Isya";
  } else if ((jam >= 19.00 && jam <= 23.59) || (jam >= 0.00 && jam <= 5.00)) {
    return "Subuh";
  } else {
    return "tes";
  }

  return null;
}

String? dateyear(DateTime? date) {
  // convert date 13/2/2024 menjadi 2024/02/13
  if (date == null) return null;
  final formatter = DateFormat('yyyy/MM/dd');
  return formatter.format(date);
}

String? waktuSholatselanjutnya(String? waktu) {
  // buatkan fungsi jika waktu >= 05.00 and <= 11.00 tampilakan Dzuhur input seperti ini 2/13/2024 8:15
  if (waktu == null) return null;

  DateTime parsedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(waktu!);
  final jadwal = parsedDateTime.hour.toDouble();

  if (jadwal >= 05.00 && jadwal <= 11.00) {
    return "Ashar";
  } else if (jadwal >= 12.00 && jadwal <= 15.00) {
    return "Maghrib";
  } else if (jadwal >= 15.00 && jadwal <= 18.00) {
    return "Isya";
  } else if (jadwal >= 18.00 && jadwal <= 19.00) {
    return "Subuh";
  } else if ((jadwal >= 19.00 && jadwal <= 23.59) ||
      (jadwal >= 0.00 && jadwal <= 5.00)) {
    return "Dzuhur";
  } else {
    return "tes";
  }

  return null;
}

String? kotakecil(String? kota) {
  // ubah KAB. BANDUNG menjadi Kab.Bandung jadi hanya huruf pertama yang kapital
  if (kota == null || kota.isEmpty) {
    return kota;
  }
  final words = kota.split(' ');
  final capitalizedWords = words.map((word) {
    if (word.length <= 2) {
      return word.toUpperCase();
    } else {
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }
  });
  return capitalizedWords.join(' ');
}

String? convertToTitleCase(String? input) {
  // i waanna convert normal text to upper text
  if (input == null || input.isEmpty) {
    return input;
  }

  return input.toUpperCase();
}

String? convertlanguagelokasi(String? lokasi) {
  if (lokasi == null || lokasi.isEmpty) {
    return null;
  }

  // Pisahkan lokasi berdasarkan spasi
  List<String> words = lokasi.split(' ');

  // Cari indeks kata "City" dan "Regency" jika ada
  int cityIndex = words.indexWhere((word) => word.toLowerCase() == 'city');
  int regencyIndex =
      words.indexWhere((word) => word.toLowerCase() == 'regency');

  // Jika ditemukan, pindahkan kata "City" ke posisi paling depan
  if (cityIndex != -1) {
    String city = words.removeAt(cityIndex);
    words.insert(0, city.toUpperCase());
  }

  // Jika ditemukan, pindahkan kata "Regency" ke posisi paling depan
  if (regencyIndex != -1) {
    String regency = words.removeAt(regencyIndex);
    words.insert(0, regency.toUpperCase());
  }

  // Ubah "Regency" menjadi "KAB." jika ada
  for (int i = 0; i < words.length; i++) {
    if (words[i].toLowerCase() == 'regency') {
      words[i] = 'KAB.';
    } else if (words[i].toLowerCase() == 'city') {
      words[i] = 'KOTA';
    }
  }

  // Simpan arah mata angin dalam daftar terpisah
  List<String> windDirections = [];

  // Ubah arah mata angin
  for (int i = 0; i < words.length; i++) {
    if (words[i].toLowerCase() == 'north') {
      windDirections.add('UTARA');
    } else if (words[i].toLowerCase() == 'south') {
      windDirections.add('SELATAN');
    } else if (words[i].toLowerCase() == 'east') {
      windDirections.add('TIMUR');
    } else if (words[i].toLowerCase() == 'west') {
      windDirections.add('BARAT');
    }
  }

  // Hapus arah mata angin dari kata-kata utama
  words.removeWhere((word) =>
      word.toLowerCase() == 'north' ||
      word.toLowerCase() == 'south' ||
      word.toLowerCase() == 'east' ||
      word.toLowerCase() == 'west');

  // Gabungkan kata-kata utama dan arah mata angin
  words.addAll(windDirections);

  // Gabungkan kembali kata-kata menjadi satu string dan ubah menjadi huruf besar
  String hasil = words.join(' ').toUpperCase();

  return hasil;
}

String? convertlokasi(LatLng? kota) {
  if (kota != null) {
    String lat = kota.latitude.toString();
    String lon = kota.longitude.toString();

    String output = 'lat=$lat&lon=$lon';
    return output;
  }

  return null; // Return null if LatLng object is null
}

String? sisawaktusholat(
  DateTime? waktusekarang,
  String? waktusholat,
) {
  // convert hasil waktusekarang dan waktu sholat menjadi integer
  if (waktusekarang == null || waktusholat == null) {
    return null;
  }

  // Ambil hanya jam dan menit dari waktusekarang
  final nowHour = waktusekarang.hour;
  final nowMinute = waktusekarang.minute;

  // Parse jam dan menit dari waktusholat
  final prayerTimeParts = waktusholat.split(':');
  final prayerHour = int.parse(prayerTimeParts[0]);
  final prayerMinute = int.parse(prayerTimeParts[1]);

  // Kalkulasi waktu yang tersisa hingga waktu sholat
  final nowInMinutes = nowHour * 60 + nowMinute;
  final prayerInMinutes = prayerHour * 60 + prayerMinute;
  final difference = prayerInMinutes - nowInMinutes;

  // Handle jika selisih waktu lebih dari atau sama dengan 60 menit
  if (difference >= 60) {
    final hours = difference ~/ 60;
    final minutes = difference % 60;
    return '$hours jam $minutes menit';
  } else {
    return '$difference menit';
  }
}
