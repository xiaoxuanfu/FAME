import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../detailspage.dart';


class amazonnews extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<amazonnews> {
  List data = [];
  bool isPressed = false;
  Color _iconColor = Colors.white;
  @override
  void initState() {
    super.initState();
    fetch_data_from_api();
  }

  Future<String> fetch_data_from_api() async {
    var jsondata = await http.get(Uri.parse(
        "http://newsapi.org/v2/everything?q=amazon&apiKey=0b0b712f35b54dae9b147f3105cf60cc"));
    var fetchdata = jsonDecode(jsondata.body);
    setState(() {
      data = fetchdata["articles"];
    });
    return "Success";
  }
  _launchURL(Uri url) async{
    //const Uri url = 'https://flutter.io';
    if (!await launchUrl(url, mode: LaunchMode.externalApplication,)){
      throw 'Could not launch website';

    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch = Uri(scheme: 'https', host: 'www.citigroup.com', path: 'citi/contact.html');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fame News",
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Amazon News"),
              actions: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.only(right: 20.0),
                  child: IconButton(
                      icon: Icon(Icons.favorite,
                        color: _iconColor,),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed;
                          if (isPressed) {
                            _iconColor = Colors.redAccent;
                          }
                          else {
                            _iconColor = Colors.white;
                          }
                        });
                      }
                  ),
                )
              ],
              /*   leading: IconButton(
                icon: Icon(Icons.favorite,
                color: _iconColor,),
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                    if (isPressed) {
                      _iconColor = Colors.redAccent;
                    }
                    else {
                      _iconColor = Colors.black;
                    }
                  });
                }
                ),
*/
            ),
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
                      TextButton(onPressed: () => setState(() {
                        _launchURL(toLaunch);

                      }), child: const Text('Launch in Browser'),),
                      TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: const Text('Cancel'),),
                    ],
                  ),
                );
              },


            ),
            body: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Swiper(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                author: data[index]["author"],
                                title: data[index]["title"],
                                description: data[index]["description"],
                                urlToImage: data[index]["urlToImage"],
                                publishedAt: data[index]["publishedAt"],
                              )));
                    },
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.0),
                              topRight: Radius.circular(35.0),
                            ),
                            child: Image.network(
                              data[index]["urlToImage"],
                              fit: BoxFit.cover,
                              height: 400.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 300.0, 0.0, 0.0),
                          child: Container(
                            height: 200.0,
                            width: 400.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(35.0),
                              elevation: 10.0,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 10.0, 20.0),
                                    child: Text(
                                      data[index]["title"],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: data == null ? 0 : data.length,
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.9,
              ),
            )));
  }
}