import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class shadowsuara extends StatefulWidget {
  const shadowsuara({super.key});

  @override
  State<shadowsuara> createState() => _shadowsuaraState();
}

class _shadowsuaraState extends State<shadowsuara> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildInfoContainer("Bakwan", 100),
      ),
    );
  }
}

Widget _buildInfoContainer(String text, int suara) {
  return Center(
    child: Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
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

void main() {
  runApp(MaterialApp(
    home: shadowsuara(),
  ));
}
