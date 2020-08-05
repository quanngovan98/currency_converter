import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:currency_converter/models/app_sizes.dart';
import 'package:currency_converter/pages/countries_picker.dart';
import 'package:currency_converter/widgets/clipper.dart';
import 'package:currency_converter/widgets/keyboard/key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scaledownbutton/scaledownbutton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> currencies = ['',''];
  bool isNavigated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: AppSizes.hUnit * 100,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipPath(
                      child: Container(
                        color: Colors.lightBlue.withOpacity(0.95),
                        height: AppSizes.hUnit * 40,
                        width: AppSizes.wUnit * 100,
                      ),
                      clipper: CustomClipPath(),
                    ),
                    Spacer(),
                    buildKeyBoard()
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: AppSizes.hUnit * 15),
                  width: AppSizes.wUnit * 90,
                  height: AppSizes.hUnit * 30,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.wUnit * 3.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 15,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: AppSizes.hUnit * 4,
                      ),
                      buildCurrencyRow(0, context),
                      Container(
                        margin: EdgeInsets.only(
                            left: AppSizes.wUnit * 10, top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ScaleDownButton(
                              onTap: () {},
                              child: Icon(
                                Icons.swap_vert,
                                size: AppSizes.hUnit * 4,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(width: AppSizes.wUnit * 38.7,),
                            Icon(
                              Icons.arrow_drop_down,
                              size: AppSizes.hUnit * 4,
                              color: Colors.lightBlue,
                            ),
                          ],
                        ),
                      ),
                      buildCurrencyRow(1, context)
                    ],
                  ),
                ),
                Positioned(
                  top: AppSizes.hUnit * 42,
                  child: ScaleDownButton(
                    scale: 0.05,
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: AppSizes.wUnit * 30,
                      height: AppSizes.hUnit * 5,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            )
                          ]),
                      child: Text(
                        "CONVERT",
                        style: TextStyle(
                            fontSize: AppSizes.wUnit * 3.5, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Row buildCurrencyRow(int index, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ScaleDownButton(
          scale: 0.05,
          onTap: () async {
            if(!isNavigated) {
              isNavigated = true;
              bool result = await Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => CountriesPicker()));
              isNavigated = false;
            }
          },
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      )
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'icons/flags/png/az.png',
                    package: 'country_icons',
                    fit: BoxFit.fitWidth,
                    width: AppSizes.wUnit * 10,
                  ),
                ),
              ),
              Container(
                width: AppSizes.wUnit * 4,
                height: AppSizes.wUnit * 5,
                color: Colors.transparent,
              ),
              Text(
                'USD',
                style:
                TextStyle(fontSize: AppSizes.wUnit * 5, color: Colors.blue),
              ),
              Icon(Icons.keyboard_arrow_down,
                  size: AppSizes.wUnit * 5, color: Colors.blue)
            ],
          ),
        ),
        Container(
          color: Colors.blue.withOpacity(0.05),
          child: Material(
            child: InkWell(
              onTap: () {
                ClipboardManager.copyToClipBoard(currencies[index]).then((result) {
                  final snackBar = SnackBar(
                    content: Text("Copied '${currencies[index]}' to Clipboard"),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                });
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: AppSizes.wUnit * 1, right: AppSizes.wUnit * 1),
                alignment: Alignment.centerRight,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      currencies[index] == '' ? ' ' : currencies[index],
                      style: TextStyle(fontSize: AppSizes.wUnit * 5, fontWeight: FontWeight.bold, color: index==1?Colors.blue:Colors.black.withOpacity(0.6)),
                      maxLines: 1,
                    )),
                width: AppSizes.wUnit * 45,
                height: AppSizes.hUnit * 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.lightBlue.withOpacity(0.3),
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column buildKeyBoard() {
    TextStyle buttonStyle = TextStyle(fontSize: AppSizes.wUnit * 5);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='7';
                });
              },
              child: Text(
                '7',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='8';
                });
              },
              child: Text(
                '8',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='9';
                });
              },
              child: Text(
                '9',
                style: buttonStyle,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='4';
                });
              },
              child: Text(
                '4',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='5';
                });
              },
              child: Text(
                '5',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='6';
                });
              },
              child: Text(
                '6',
                style: buttonStyle,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='1';
                });
              },
              child: Text(
                '1',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='2';
                });
              },
              child: Text(
                '2',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='3';
                });
              },
              child: Text(
                '3',
                style: buttonStyle,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='0';
                });
              },
              child: Text(
                '0',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                setState(() {
                  currencies[0]+='.';
                });
              },
              child: Text(
                '.',
                style: buttonStyle,
              ),
            ),
            KeyboardButton(
              ontap: () {
                if(currencies[0].length>0) {
                  setState(() {
                    currencies[0] = currencies[0].substring(0, currencies[0].length-1);
                  });
                }
              },
              onLongPress: () {
                setState(() {
                  currencies[0] = '';
                });
              },
              child: Icon(
                Icons.backspace,
                color: Colors.lightBlue,
                size: AppSizes.wUnit * 7,
              ),
            )
          ],
        )
      ],
    );
  }
}
