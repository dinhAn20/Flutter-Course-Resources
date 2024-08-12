import 'dart:io';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  bool isWaiting = false;
  String selectedCurrency = 'AUD';
  Map<String, String> coinValues = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoList
                .map((crypto) => CryptoCard(
                      cryptoCurrency: crypto,
                      selectedCurrency: selectedCurrency,
                      value: isWaiting ? '?' : coinValues[crypto]!,
                    ))
                .toList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? CupertinoPicker.builder(
                    childCount: currenciesList.length,
                    backgroundColor: Colors.lightBlue,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedCurrency = currenciesList[index];
                        getData();
                      });
                    },
                    itemBuilder: (context, index) {
                      var element = currenciesList[index];
                      return Text(element);
                    },
                  )
                : DropdownButton<String>(
                    value: selectedCurrency,
                    items: currenciesList
                        .map((element) => DropdownMenuItem<String>(
                              child: Text(element),
                              value: element,
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null)
                        setState(() {
                          selectedCurrency = value;
                          getData();
                        });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });
  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
