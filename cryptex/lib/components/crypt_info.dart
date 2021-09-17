import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptex/data/user.dart';

class CryptInfo extends StatelessWidget {
  const CryptInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12,left: 12,top: 12,bottom: 6),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.watch<UserData>().symbol,
                        style: TextStyle(
                            color: Color.fromRGBO(111, 0, 255, 1),
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      Text(
                        context.watch<UserData>().name,
                        style: TextStyle(
                            color: Color.fromRGBO(111, 0, 255, 1),
                            fontSize: 22,
                            height: 0.5),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Actual price:\n',
                              style: TextStyle(
                                  color: Color.fromRGBO(111, 0, 255, 1),
                                  fontSize: 22,
                                  height: 1,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text:
                                  '${context.watch<UserData>().priceUsd.toStringAsFixed(6)} USD',
                              style: TextStyle(
                                  color: Color.fromRGBO(111, 0, 255, 1),
                                  fontSize: 22,
                                  height: 1),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Price change in 24 hours:\n',
                                  style: TextStyle(
                                      color: Color.fromRGBO(111, 0, 255, 1),
                                      fontSize: 22,
                                      height: 1,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                  text:
                                      '${context.watch<UserData>().changePercent24Hr.toStringAsFixed(6)}%',
                                  style: TextStyle(
                                      color: Color.fromRGBO(111, 0, 255, 1),
                                      fontSize: 22,
                                      height: 1),
                                ),
                              ],
                            ),
                          ),
                          context.watch<UserData>().changePercent24Hr > 0
                              ? Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 36,
                                )
                              : Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red[400],
                                  size: 36,
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
