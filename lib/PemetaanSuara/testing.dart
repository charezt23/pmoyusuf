import 'package:apiapiapi/PemetaanSuara/model/modelProvinsi.dart';
import 'package:apiapiapi/PemetaanSuara/servicesura.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemetaan Suara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelProvinsi> provinsiList = [];
  bool isLoading = false;
  PemetaanSuaraService service = PemetaanSuaraService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemetaan Suara'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await service.showProvinsi(1);
            },
            child: Text('Tampilkan Provinsi'),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: provinsiList.length,
                    itemBuilder: (context, index) {
                      final provinsi = provinsiList[index];
                      return ListTile(
                        title: Text(provinsi.nama ?? 'Unknown'),
                        subtitle: Text(
                            'Pemilih Potensial: ${provinsi.pemilihPotensialCount ?? 0}'),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
