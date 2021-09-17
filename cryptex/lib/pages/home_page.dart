import 'dart:convert';
import 'package:cryptex/components/coin_card.dart';
import 'package:cryptex/components/crypt_info.dart';
import 'package:cryptex/data/cryptocurrency.dart';
import 'package:cryptex/data/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var dataList = <Cryptocurrency>[];
  late TextEditingController _controller;
  getData() async {
    try {
      var response = await http.get(Uri.https('api.coincap.io', '/v2/assets'));
      if (response.statusCode == 200) {
        //запрос с API
        final jsonData = (jsonDecode(response.body))['data'] as List;
        print(response.statusCode);
        //распарсили JSON-данные
        var data = <Cryptocurrency>[];
        jsonData.forEach((element) {
          //заполнили список данными и криптовалютах
          var temp = Cryptocurrency(
            id: element['id'],
            rank: int.parse(element['rank']),
            priceUsd: double.parse(element['priceUsd']),
            symbol: element['symbol'],
            name: element['name'],
            changePercent24Hr: double.parse(element['changePercent24Hr']),
          );
          data.add(temp);
        });
        setState(() {
          dataList = data;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Service is not avalible now. Please,try later.",
                  style: TextStyle(color: Color.fromRGBO(111, 0, 255, 1)),
                ),
              );
            });
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    getData();
    for (int i = 0; i < dataList.length; i++) {
      print(dataList[i].symbol);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 6),
              child: ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text("Update data"),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(111, 0, 255, 1),
                  shadowColor: Colors.deepPurple.withOpacity(0.3),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            CryptInfo(),
            Padding(
              padding:
                  const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(111, 0, 255, 1),
                    ),
                    border: InputBorder.none,
                  ),
                  controller: _controller,
                  onSubmitted: (String value) async {
                    try {
                      var response = await http.get(Uri.https('api.coincap.io',
                          '/v2/assets/${value.toLowerCase()}'));
                      if (response.statusCode == 200) {
                        final jsonData =
                            (jsonDecode(response.body))['data'] as Map;
                        context.read<UserData>().setId = jsonData['id'];
                        context.read<UserData>().setRank =
                            int.parse(jsonData['rank']);
                        context.read<UserData>().setSymbol = jsonData['symbol'];
                        context.read<UserData>().setName = jsonData['name'];
                        context.read<UserData>().setPriceUsd =
                            double.parse(jsonData['priceUsd']);
                        context.read<UserData>().setChangePercent24Hr =
                            double.parse(jsonData['changePercent24Hr']);
                      } else {
                        if (response.body.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "There is no such cryptocurrency.",
                                    style: TextStyle(
                                        color: Color.fromRGBO(111, 0, 255, 1)),
                                  ),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Service is not avalible now. Please,try later.",
                                    style: TextStyle(
                                        color: Color.fromRGBO(111, 0, 255, 1)),
                                  ),
                                );
                              });
                        }
                      }
                    } catch (error) {
                      print("Error: $error");
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
              child: Container(
                width: double.infinity,
                height: 530,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.separated(
                    itemCount: dataList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: CoinCard(data: dataList[index]),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
