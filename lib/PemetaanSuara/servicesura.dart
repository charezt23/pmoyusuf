import 'dart:convert';
import 'package:apiapiapi/PemetaanSuara/model/ListModel.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKabupaten.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelProvinsi.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://26f9-139-195-255-99.ngrok-free.app/api";

class PemetaanSuaraService {
  Future<void> showProvinsi(id) async {
    try {
      var request = http.Request(
          'GET', Uri.parse(BASE_URL + '/pemetaanSuara-provinsi/1'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        provinsiList.clear();
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKabupaten(id) async {
    try {
      var request = http.Request(
          'GET', Uri.parse(BASE_URL + '/pemetaanSuara-kabupaten/1'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kabupatenList.clear();
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> howKecamatan(id) async {
    try {
      var request = http.Request(
          'GET', Uri.parse(BASE_URL + 'pemetaanSuara-kecamatan/1'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kecamatanList.clear();
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> howKelurahan(id) async {
    {
      var request =
          http.Request('GET', Uri.parse(BASE_URL + 'pemetaanSuara-kelurahan'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();

        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kecamatanList.clear();
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
