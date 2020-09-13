import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/models/currency_exchange.dart';
import 'package:learning_flutter/services/currency_service.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  String rate = "";

  Widget getDropdown(Function(String) handler) {
    List<DropdownMenuItem> getDropdownItems() {
      return currenciesList.map((e) {
        return DropdownMenuItem(
          child: Text(e),
          value: e,
        );
      }).toList();
    }

    List<Widget> getPickerItems() {
      return currenciesList.map((e) {
        return Text(
          e,
          style: TextStyle(color: Colors.white),
        );
      }).toList();
    }

    if (Platform.isAndroid) {
      return DropdownButton<String>(
        items: getDropdownItems(),
        value: selectedCurrency,
        onChanged: handler,
      );
    } else {
      return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (index) => handler(currenciesList[index]),
        children: getPickerItems(),
      );
    }
  }

  void requestExchange() async {
    final exchange = await CurrencyService.convert(selectedCurrency);

    if(exchange != null) {
      rate = exchange.rate;
    } else{
      rate = "No rate available";
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
          Padding(
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
                  '1 USD = ? $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(child: Text(rate, style: TextStyle(color: Colors.black, fontSize: 44),)),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropdown((currency) {
              setState(() {
                selectedCurrency = currency;
                requestExchange();
              });
            }),
          ),
        ],
      ),
    );
  }
}
