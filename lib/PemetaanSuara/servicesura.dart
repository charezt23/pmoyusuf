import 'dart:convert';
import 'package:apiapiapi/PemetaanSuara/model/ListModel.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKabupaten.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKecamatan.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKelurahan.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelProvinsi.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://7612-149-113-199-178.ngrok-free.app/api";

class PemetaanSuaraService {
  Future<void> showProvinsi(id) async {
    try {
      var request = http.Request(
          'GET', Uri.parse(BASE_URL + '/pemetaanSuara-provinsi/$id'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        provinsiList.clear();
        for (var element in data) {
          provinsiList.add(ModelProvinsi.fromJson(element));
        }

        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKabupaten(idProvinsi, id) async {
    try {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + '/pemetaanSuara-kabupaten/$idProvinsi/$id'));

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kabupatenList.clear();
        for (var element in data) {
          kabupatenList.add(modelKabupaten.fromJson(element));
        }
        print(kabupatenList[0]);
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKecamatan(kabuptenID, id) async {
    try {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + 'pemetaanSuara-kecamatan/$kabuptenID/$id'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kecamatanList.clear();
        for (var element in data) {
          kecamatanList.add(modelKecamatan.fromJson(element));
        }
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('$e');
    }
  }

  Future<void> showKelurahan(kecamatanID, id) async {
    {
      var request = http.Request('GET',
          Uri.parse(BASE_URL + 'pemetaanSuara-kelurahan/$kecamatanID/$id'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        Map<String, dynamic> responseData = jsonDecode(responseString);
        List<dynamic> data = responseData['data'];
        kelurahanList.clear();
        for (var element in data) {
          kelurahanList.add(modelKelurahan.fromJson(element));
        }
        print(responseData['message']);
      } else {
        print(response.reasonPhrase);
      }
    }
  }
}
