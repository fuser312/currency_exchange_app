import 'package:currency_exchange/network_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CurrencyExchange(),
  ));
}
Map <String, dynamic> exchanegeRateData;
class CurrencyExchange extends StatefulWidget {
  @override
  _CurrencyExchangeState createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  String selected = "USD";
  String converted = "CAD";
  double converter = 1.31;
  @override
  Widget build(BuildContext context) {

    void getExchangeRateData(currency) async {
      NetworkHelper networkHelper = NetworkHelper('https://api.exchangeratesapi.io/latest?base=$currency');
      exchanegeRateData = await networkHelper.getExchangeRates();
      converter = exchanegeRateData["rates"][converted];
      setState(() {
        
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Exchange Rates"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Text("1 $selected", style: TextStyle(fontSize: 48, color: Colors.red),)),
                      Center(child: Text("=", style: TextStyle(fontSize: 48, color: Colors.red,),)),
                      Center(child: Text(converter.toStringAsFixed(2) + "$converted", style: TextStyle(fontSize: 48, color: Colors.red),))
                    ],),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: SizedBox(

              ),
            ),
              //child: Center(child: Text('1 $selected ' + converter.toStringAsFixed(2) + ' $converted ',style: TextStyle(fontSize: 60),))),
            Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: Text("From", style: TextStyle(fontSize: 24, color: Colors.grey),),
                      ),
                      Center(
                        child: Text("To", style: TextStyle(fontSize: 24, color: Colors.grey),),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black)
                          ),
                          child: DropdownButton<String>(
                            value: selected,
                            elevation: 16,
                            style: TextStyle(
                            fontSize: 32,
                            color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              selected = newValue;
                              getExchangeRateData(selected);

                            },
                            items: <String>['USD', 'CAD', 'HKD', 'ISK', 'DKK']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value),
                                ),
                              );
                            })
                                .toList(),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black)
                          ),
                          child: DropdownButton<String>(
                            value: converted,
                            elevation: 16,
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.grey,
                            ),
                            onChanged: (String newCurrency) {
                              converted = newCurrency;
                              getExchangeRateData(selected);
                            },
                            items: <String>['USD', 'CAD', 'HKD', 'ISK', 'DKK']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value),
                                ),
                              );
                            })
                                .toList(),
                          ),
                        ),
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