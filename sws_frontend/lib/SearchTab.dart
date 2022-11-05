import 'Service.dart';
import 'package:flutter/material.dart';
import 'main.dart';

final Color background = appTheme.primaryColor;
final Color chipBackground = appTheme.secondaryHeaderColor.withOpacity(.2);
final Color borderColor = appTheme.primaryColor.withAlpha(100);

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: const <Widget>[StackTop(), StackDown()],
          ),
        ));
  }
}

class StackDown extends StatelessWidget {
  const StackDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('Tutti i servizi trovati:',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: const <Widget>[
                Service(
                  image: "assets/images/servizi-sociali.jpg",
                  name: "Mensa",
                  monthyear: "19:00-21:00",
                  oldprice: "Gratis",
                  newprice: "Salerno",
                  discount: "SA",
                ),
                Service(
                  image: "assets/images/welfare.jpg",
                  name: "Taxi",
                  monthyear: "Prenota",
                  oldprice: "Gratis",
                  newprice: "Pellezzano",
                  discount: "SA",
                ),
                Service(
                  image: "assets/images/servizi-sociali.jpg",
                  name: "Mensa",
                  monthyear: "12:00-15:00",
                  oldprice: "Gratis",
                  newprice: "Salerno",
                  discount: "SA",
                ),
              ],
            )
          ],
        ));
  }
}

class StackTop extends StatelessWidget {
  const StackTop({super.key});

  @override
  Widget build(BuildContext context) {
    // Key from;
    // Key to;
    return Material(
      elevation: 0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Clipper08(),
            child: Container(
              height: height! * .272, //400
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appTheme.primaryColor, appTheme.primaryColor],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: height! * .04,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.symmetric(horizontal: height! * .035),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(height! * .035),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Hai cercato mensa a Salerno',
                              style: TextStyle(fontSize: 16.0),
                              // key: from,
                            ),
                            Divider(
                              color: Colors.black12,
                              height: height! * .04,
                            ),
                            const Text(
                              'Informazioni in più: #mensa #gratis',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                              // key: to,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: height! * .05,
                              ),
                              onPressed: () {}))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
