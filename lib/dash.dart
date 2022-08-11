import 'package:fame/company.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './news page/amazonnews.dart';
import './news page/applenews.dart';
import './news page/intelnews.dart';
import './news page/nikenews.dart';
import './news page/nintendonews.dart';
import './news page/spotifynews.dart';
import './news page/starbucksnews.dart';
import './news page/ubernews.dart';
import 'package:flutter/material.dart';
import './side.dart';
import 'news page/teslanews.dart';
import 'package:url_launcher/url_launcher.dart';

/*
void main() {
  runApp(
      MaterialApp(
        home: Dashboard(),
      )
  );
} */


List co_list = ['Amazon','Tesla','Spotify','Nintendo','Intel'];

class Dashboard extends StatelessWidget {
  @override
  _launchURL(Uri url) async{
    //const Uri url = 'https://flutter.io';
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,)){
      throw 'Could not launch website';

    }
  }

  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.blue,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => new AlertDialog(
            title: Text("Contact Us"),
                content: Text("Do you wish to continue?"),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, 'Yes'), child: const Text('Yes'),),
                  TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('Cancel'),),
                ],
          ),
          );
        },


      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: Colors.black, size: 50.0),
                      Image.asset("assets/images/logo.png", width: 50.0)
                    ],
                  )
              ),
              Padding(padding: const EdgeInsets.all(18.0),
                child: Text("For You", style: TextStyle(color: Colors.blue,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        if (co_list.contains('Tesla'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => teslanews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),

                                          child: Column(
                                              children: [
                                                Image.asset("assets/tesla.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Tesla", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),
                          ),
                        if (co_list.contains('Amazon'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => amazonnews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/amazon.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Amazon", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Intel'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => intelnews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),

                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/intel.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Intel", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Nintendo'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => nintendonews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/nin.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Nintendo", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Spotify'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => spotifynews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/spotify.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Spotify", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Uber'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => ubernews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/uber.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Uber", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Starbucks'))
                          SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: ElevatedButton(
                              onPressed:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => starbucksnews()));},
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              children: [
                                                Image.asset("assets/starbucks.png", width: 64.0),
                                                SizedBox(height: 10.0),
                                                Text("Starbucks", style: TextStyle(
                                                    color: Colors.black, fontWeight: FontWeight.bold,
                                                    fontSize: 20.0
                                                )),
                                              ]
                                          )
                                      )
                                  )
                              ),
                            ),),
                        if (co_list.contains('Nike'))
                          SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child: ElevatedButton(
                                onPressed:(){
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => nikenews()));},
                                style: ElevatedButton.styleFrom(primary: Colors.white),
                                child: Card(
                                    color: Colors.white,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0)
                                    ),
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                children: [
                                                  Image.asset("assets/Nike.png", width: 64.0),
                                                  SizedBox(height: 10.0),
                                                  Text("Nike", style: TextStyle(
                                                      color: Colors.black, fontWeight: FontWeight.bold,
                                                      fontSize: 20.0
                                                  )),
                                                ]
                                            )
                                        )
                                    )
                                ),
                              )
                          )],

                    ),
                  )
              )
            ]
        ),
      ),
    );
  }
}



