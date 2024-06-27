import 'dart:convert';
import 'package:apiapiapi/PemetaanSuara/model/ListModel.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKabupaten.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKelurahan.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelProvinsi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelKecamatan.dart';
import 'package:apiapiapi/PemetaanSuara/model/modelProvinsi.dart';

class MYAPP extends StatelessWidget {
  const MYAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PemetaanSuara(title: 'Pemetaan Suara'),
    );
  }
}

void main() {
  runApp(MYAPP());
}

class PemetaanSuara extends StatefulWidget {
  const PemetaanSuara({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PemetaanSuara> createState() => _PemetaanSuaraState();
}

class _PemetaanSuaraState extends State<PemetaanSuara> {
  TextEditingController cariprov = TextEditingController();

  String selectedRegion = 'Pemetaan suara provinsi';
  String? selectedParent;
  final List<String> regions = [
    'Pemetaan suara kabupaten',
    'Pemetaan suara provinsi',
    'Pemetaan suara kelurahan',
    'Pemetaan suara kecamatan'
  ];

  final Map<String, List<String>> dataMap = {
    'Pemetaan suara provinsi': provinsiList.map((p) => p.nama!).toList(),
    'Pemetaan suara kabupaten': kabupatenList.map((k) => k.nama!).toList(),
    'Pemetaan suara kecamatan': kecamatanList.map((k) => k.nama!).toList(),
    'Pemetaan suara kelurahan': kelurahanList.map((k) => k.nama!).toList(),
  };

  final Map<String, int> suaraMap = {
    for (var p in provinsiList) p.id!: p.pemilihPotensialCount!,
    for (var k in kabupatenList) k.provinsiId!: k.pemilihPotensialCount!,
    for (var k in kecamatanList) k.kabupatenId!: k.pemilihPotensialCount!,
    for (var k in kelurahanList) k.kecamatanId!: k.pemilihPotensialCount!,
  };

  List<String> filteredData = [];
  Map<String, String> parentRegionMap = {};

  @override
  void initState() {
    super.initState();
    filteredData = dataMap[selectedRegion]!;
    cariprov.addListener(_searchData);

    // Populate parentRegionMap
    kabupatenList.forEach((k) {
      parentRegionMap[k.id!] = k.provinsiId!;
    });
    kecamatanList.forEach((k) {
      parentRegionMap[k.id!] = k.kabupatenId!;
    });
    kelurahanList.forEach((k) {
      parentRegionMap[k.id!] = k.kecamatanId!;
    });
  }

  @override
  void dispose() {
    cariprov.dispose();
    super.dispose();
  }

  void _searchData() {
    setState(() {
      filteredData = dataMap[selectedRegion]!
          .where((item) =>
              item.toLowerCase().contains(cariprov.text.toLowerCase()) &&
              (selectedParent == null ||
                  parentRegionMap[item] == selectedParent))
          .toList();
    });
  }

  void _handleDoubleTap(String data) {
    setState(() {
      if (selectedRegion == 'Pemetaan suara provinsi') {
        selectedRegion = 'Pemetaan suara kabupaten';
        selectedParent = data;
      } else if (selectedRegion == 'Pemetaan suara kabupaten') {
        selectedRegion = 'Pemetaan suara kecamatan';
        selectedParent = data;
      } else if (selectedRegion == 'Pemetaan suara kecamatan') {
        selectedRegion = 'Pemetaan suara kelurahan';
        selectedParent = data;
      }
      filteredData = dataMap[selectedRegion]!
          .where((item) => parentRegionMap[item] == selectedParent)
          .toList();
      cariprov.clear();
    });
  }

  List<Widget> buildDataContainers() {
    return filteredData.map((data) {
      return GestureDetector(
        onDoubleTap: () => _handleDoubleTap(data),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 168, 227, 221),
            border: Border.all(
              color: Color.fromARGB(166, 214, 214, 214),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ],
          ),
          margin: EdgeInsets.fromLTRB(11, 5, 11, 0),
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              data,
              style: GoogleFonts.getFont(
                'Nunito',
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: Text(
              '${suaraMap[data]} Suara',
              style: GoogleFonts.getFont(
                'Nunito',
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  String getPlaceholderText() {
    switch (selectedRegion) {
      case 'Pemetaan suara provinsi':
        return 'Cari Provinsi';
      case 'Pemetaan suara kabupaten':
        return 'Cari Kabupaten';
      case 'Pemetaan suara kecamatan':
        return 'Cari Kecamatan';
      case 'Pemetaan suara kelurahan':
        return 'Cari Kelurahan';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color.fromARGB(255, 48, 48, 48),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
                  padding: EdgeInsets.fromLTRB(10, 0, 12, 0),
                  child: DropdownButton<String>(
                    value: selectedRegion,
                    icon: Icon(Icons.ads_click_rounded),
                    iconSize: 20,
                    elevation: 16,
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Color(0xFF3E3E3E),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRegion = newValue!;
                        filteredData = dataMap[selectedRegion]!;
                        selectedParent = null;
                        cariprov.clear();
                      });
                    },
                    items:
                        regions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          if (selectedRegion != 'Pemetaan suara provinsi')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(11, 5, 11, 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 128, 221, 206),
                  border: Border.all(
                    color: Color.fromARGB(166, 214, 214, 214),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 63, 63, 63).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: cariprov,
                    decoration: InputDecoration(
                      hintText: getPlaceholderText(),
                      hintStyle: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search_sharp),
                        iconSize: 20,
                      ),
                    ),
                    style: GoogleFonts.getFont('Nunito'),
                  ),
                ),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildDataContainers(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
