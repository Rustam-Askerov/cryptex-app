import 'package:cryptex/data/cryptocurrency.dart';
import 'package:cryptex/data/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinCard extends StatefulWidget {
  final Cryptocurrency data;
  CoinCard({required Cryptocurrency data}) : this.data = data;

  @override
  _CoinCardState createState() => _CoinCardState(data);
}

class _CoinCardState extends State<CoinCard> {
  final Cryptocurrency data;
  _CoinCardState(this.data);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.symbol,
              style: TextStyle(
                  color: Color.fromRGBO(111, 0, 255, 1),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${data.priceUsd.toStringAsFixed(6)} USD",
              style: TextStyle(color: Color.fromRGBO(111, 0, 255, 1)),
            ),
          ],
        ),
      ),
      onTap: () {
        context.read<UserData>().setId = data.id;
        context.read<UserData>().setRank = data.rank;
        context.read<UserData>().setSymbol = data.symbol;
        context.read<UserData>().setName = data.name;
        context.read<UserData>().setPriceUsd = data.priceUsd;
        context.read<UserData>().setChangePercent24Hr = data.changePercent24Hr;
      },
    );
  }
}
