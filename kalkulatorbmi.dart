import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  String _Jeniskelamin = 'laki-laki';
  final _bbController = TextEditingController(); // _ = private
  final _tbController = TextEditingController();

  double? _hasilBMI; // ? apakah terisi atau tidak
  String _keterangan = "Masukkan Data Anda!!!";

  void _hapusBMI(){ // buat variable untuk hapus
    setState(() {
      _bbController.clear();
      _tbController.clear();

      _hasilBMI = null;
      _keterangan = "Masukan Data!!!";
    });

  }
  void _hitungBMI(){
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if(bb > 0 && tbCm > 0){
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);

        _hasilBMI = hasil;
        if(hasil < 18.5){
          _keterangan = "Kurang Gizi";
        }else if(hasil < 25){
          _keterangan = "Nah ini Ideal";
        }else if(hasil < 30){
          _keterangan = "Lebih teing atuh euy";
        }else {
          _keterangan = "Obesitas ajigg";
        }
      }else {
        _hasilBMI = null;
        _keterangan = "Data Tidak Valid!!!";
      }
    });
  }

  @override
  void dispose(){
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: GoogleFonts.poppins(
            fontWeight: .bold,
            letterSpacing: 5
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        leading: Icon(Icons.accessibility),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [


              Card(
                child: Column(
                children: [
                  Text(
                'Pilih Jenis Kelamin',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title : Text('laki-laki',),
                value: 'lakii-laki',
                groupValue: _Jeniskelamin,
                onChanged: (value) {
                  setState(() {
                    _Jeniskelamin = value!;
                  });
                },
              ),

              RadioListTile<String>(
                title : Text('perempuan'),
                value: 'perempuan',
                groupValue: _Jeniskelamin,
                onChanged: (value) {
                  setState(() {
                    _Jeniskelamin = value!;
                  });
                },
              ),

      
                ],
              ),
            ),
              

              SizedBox(height: 15,),

              Card(
                child: Column(
                  children: [
                    Text(
                      'masukan berat badan dan tinggi badan',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 15,),

              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.monitor_weight, size: 30,),
                  labelText: 'Berat Badan',
                  labelStyle: TextStyle(letterSpacing: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),

              SizedBox(height: 15,),
              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.height, size: 30,),
                  labelText: 'Tinggi Badan',
                  labelStyle: TextStyle(letterSpacing: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),

              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _hitungBMI,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Hitung BMI',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                  )
                )
              ),

              SizedBox(height: 15,),
              ElevatedButton(
                onPressed:  _hapusBMI,
                style: ElevatedButton.styleFrom(
                  padding : EdgeInsets.symmetric(vertical : 20),
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'Hapus DATA BMI',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    ),
                  )
                ),

              SizedBox(height: 15,),
              Text(
                'Hasil : ',
                textAlign: .center,
                style: GoogleFonts.roboto(

                ),
              ),

              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? 'Nilai Kosong',
                      style: GoogleFonts.poppins(
                        fontSize: 50,
                        fontWeight: .bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      _keterangan,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: .bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
