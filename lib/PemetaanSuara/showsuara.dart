import 'package:apiapiapi/PemetaanSuara/model/ListModel.dart';
import 'package:apiapiapi/PemetaanSuara/pemtaansuaraaaa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'servicesura.dart';

class PemetaanSuara extends StatefulWidget {
  const PemetaanSuara({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PemetaanSuara> createState() => _PemetaanSuaraState();
}

class _PemetaanSuaraState extends State<PemetaanSuara> {
  String judul = 'Provinsi';
  PemetaanSuaraService service = PemetaanSuaraService();
  TextEditingController cariprov = TextEditingController();
  String Pageaktifasaatini = "Provinsi";
  List<dynamic> DataPage = [];

  @override
  void initState() {
    super.initState();
    pageProvinsi(loginData['userID']);
  }

  void pageProvinsi(id) async {
    await service.showProvinsi(id);
    setState(() {
      Pageaktifasaatini = "Provinsi";
      DataPage = provinsiList;
      judul = "Provinsi";
    });
  }

  void pageKabupaten(String provinsiID, id) async {
    await service.showKabupaten(provinsiID, id);
    setState(() {
      Pageaktifasaatini = "Kabupaten";
      DataPage = kabupatenList;
      judul = "Kabupaten";
    });
  }

  void pageKecamatan(String kabupatenID, id) async {
    await service.showKecamatan(kabupatenID, id);
    setState(() {
      Pageaktifasaatini = "Kecamatan";
      DataPage = kecamatanList;
      judul = "Kecamatan";
    });
  }

  void pageKelurahan(String kecamatanID, id) async {
    await service.showKelurahan(kecamatanID, id);
    setState(() {
      Pageaktifasaatini = "Kelurahan";
      DataPage = kelurahanList;
      judul = "Kelurahan";
    });
  }

  void searchList(String query) {
    List<dynamic> results = [];
    if (Pageaktifasaatini == 'Provinsi') {
      results = provinsiList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kabupaten') {
      results = kabupatenList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kecamatan') {
      results = kecamatanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else if (Pageaktifasaatini == 'Kelurahan') {
      results = kelurahanList
          .where(
              (item) => item.nama!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      DataPage = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bar pencarian dan widget lainnya bisa ditambahkan di sini
          Expanded(
            child: FutureBuilder(
              future: service.showProvinsi(loginData['userID']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: DataPage.length,
                    itemBuilder: (context, index) {
                      var item = DataPage[index];
                      return GestureDetector(
                        onTap: () {
                          if (Pageaktifasaatini == 'Provinsi') {
                            pageKabupaten(item.id, loginData['userID']);
                          } else if (Pageaktifasaatini == 'Kabupaten') {
                            pageKecamatan(item.id, loginData['userID']);
                          } else if (Pageaktifasaatini == 'Kecamatan') {
                            pageKelurahan(item.id, loginData['userID']);
                          }
                        },
                        child: _buildInfoContainer(
                            item.nama!, item.pemilihPotensialCount!),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String text, int suara) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                width: 80,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 189, 247, 247),
                  borderRadius: BorderRadiusDirectional.circular(5),
                ),
                child: Center(
                  child: Text(
                    suara.toString(),
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemetaan Suara App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PemetaanSuara(title: 'Pemetaan Suara'),
    );
  }
}
