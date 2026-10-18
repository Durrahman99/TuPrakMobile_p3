import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController =TextEditingController();
  final _tbController =TextEditingController();

  double? _hasilBMI;
  String _keterangan = "Masukkan Data Anda!!!";

  void _hitungBMI(){
    final double bb =double.tryParse(_bbController.text) ?? 0;
    final double tb =double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if(bb > 0 && tb > 0){
        final double tbM = tb / 100;
        final double hasil = bb / (tbM * tbM);

        _hasilBMI = hasil;

        if(hasil < 18.5){
          _keterangan = "Kekurangan Berat Badan";
        }else if(hasil < 25){
          _keterangan = "Berat Badan Ideal";
        }else if(hasil < 30){
          _keterangan = "Kelebihan Berat Badan";
        }else {
          _keterangan = "Obesitas";
        }
      }else {
        _hasilBMI = null;
        _keterangan = 'Data Tidak Valid';
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
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 5
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,       
        leading: Icon(Icons.accessibility,color: const Color.fromARGB(255, 15, 15, 15),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(//untuk scroll
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _bbController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                icon: Icon(Icons.monitor_weight, size: 30,),
                labelText: 'Berat Badan',
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),

            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: _hitungBMI,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              ), 
              child: Text(
                'Hitung BMI'
              ),
            ),

            SizedBox(height: 15,),
            Text(
              'Hasil : ',
              style: TextStyle(letterSpacing: 5),
            ),

            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.all(100),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Text(
                    _hasilBMI?.toStringAsFixed(1) ?? '--',
                  ),
                  SizedBox(height: 15,),
                  Text(
                    _keterangan,
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}