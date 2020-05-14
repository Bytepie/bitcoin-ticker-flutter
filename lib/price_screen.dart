import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'networking.dart';
import 'loading_spin.dart';
import 'style_constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var priceList;

  @override
  void initState() {
    getCurrencyPrice();
    super.initState();
  }

  DropdownButton<String> listWidgetAndroid() {
    List<DropdownMenuItem<String>> itemList = [];
    for (String currency in currenciesList) {
      itemList.add(DropdownMenuItem(child: Text(currency), value: currency));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      iconEnabledColor: Colors.white,
      iconSize: 50,
      isExpanded: false,
      style: TextStyle(
          color: Colors.white, letterSpacing: 1, fontWeight: FontWeight.bold),
      items: itemList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        print(selectedCurrency);
      },
    );
  }

  Future<void> getCurrencyPrice() async {
    setState((){priceList = null;});
    priceList = await updatePrice();
    setState((){});
  }

  CupertinoPicker pickerOnIOS() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(
        currency,
        style: TextStyle(color: Colors.white, fontSize: 32.0),
      ));
    }
    return CupertinoPicker(
        magnification: 1.2,
        backgroundColor: Colors.blueAccent.shade700,
        useMagnifier: true,
        itemExtent: 40.0,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedCurrency = currenciesList[index];
          });

        },
        children: pickerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BitCoin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0),
              child: Card(
                color: Colors.blueAccent.shade700,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: priceList == null
                    ? LoadingScreen()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('1 BTC',
                              textAlign: TextAlign.center, style: kHeading),
                          Text(
                              '${priceList[selectedCurrency]['symbol']}'
                                  '${priceList[selectedCurrency]['last']}',
                              textAlign: TextAlign.center,
                              style: kNormal),
                        ],
                      ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: getCurrencyPrice,
                  child: Container(
                    // width: 90.0,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white10, blurRadius: 8)
                        ]),
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Update Price',
                      textAlign: TextAlign.center,
                      style: kButton,
                    ),
                  ),
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 0.0),
                  color: Colors.blueAccent.shade700,
                  child: Platform.isIOS ? pickerOnIOS() : listWidgetAndroid(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
