import 'dart:convert';
import 'dart:io';
import 'package:contador_pessoas/choices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';


class HomePager extends StatefulWidget {
  @override
  _HomePagerState createState() => _HomePagerState();
}

class _HomePagerState extends State<HomePager> {

  var sum=0;
  List valores = [0,0,0,0,0,0,0,0,0,0,0,0];

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData() async {
    String data = json.encode(valores);
    final file = await  getFile();
    return file.writeAsString(data);
  }

  Future<String> readData() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }



  /* void addDia ( int value, int index){
    setState(() {
      Map<String, dynamic> novoDia = Map();
      novoDia["dia"] = 0;
      novoDia["mes"] = index;
      valores.add(novoDia);
      _saveData();
    });
  }*/

  @override
  void initState() {
    super.initState();

    readData().then((data){
      setState(() {
        valores = json.decode(data);
        valores.forEach((e) => sum += e);
      });
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: choices.length,
        child: FutureBuilder(
          future: readData(),
           builder: (context, index){
            return NestedScrollView(
              headerSliverBuilder: (context, value) {

                return [
                  SliverAppBar(
                      backgroundColor: Colors.purple,
                      bottom: TabBar(
                          indicatorColor: Colors.white,
                          indicatorWeight: 5,
                          isScrollable: true,
                          tabs: choices.map<Widget>((Choice choice) {
                            return Tab(
                              text: choice.tittle,
                            );
                          }).toList()),
                      expandedHeight: 250,
                      floating: true,
                      elevation: 0,
                      stretch: true,
                      snap: true,
                      shadowColor: Colors.transparent,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${sum.toString()} dias",
                            style: GoogleFonts.montserrat(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                          Text(
                            "estudando flutter",
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      )),
                ];
              },
              body: TabBarView(
                children: [
                  func(0, setState),
                  func(1, setState),
                  func(2,  setState),
                  func(3, setState),
                  func(4, setState),
                  func(5, setState),
                  func(6,  setState),
                  func(7,  setState),
                  func(8,  setState),
                  func(9, setState),
                  func(10, setState),
                  func(11, setState),
                ],
              ),
            );
           },
        ),
      ),
    );
  }


  Widget func(int index, Function setState) {

    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(valores[index].toString(), style: GoogleFonts.montserrat(
                fontSize: 80, color: Colors.purple),),
            SizedBox(height: 20,),
            // ignore: deprecated_member_use
            Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(25)
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  if (valores[index] < 30 && valores[index] >= 0) {
                    setState(() {
                      valores[index]++;
                      sum++;
                      saveData();
                    });
                  }
                },
                child: Text("Adicionar",
                  style: GoogleFonts.montserrat(color: Colors.white),),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(25)
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  if (valores[index] <= 30 && valores[index] > 0) {
                    setState(() {
                      valores[index]--;
                      sum--;
                      saveData();
                    });
                  }
                },
                child: Text("Remover",
                  style: GoogleFonts.montserrat(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

}
