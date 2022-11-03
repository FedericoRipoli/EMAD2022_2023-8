import 'package:flutter/material.dart';
import 'main.dart';

class Service extends StatelessWidget {
  final String? image, monthyear, oldprice;
  final String? name, discount, newprice;

  const Service(
      {Key? key,
      this.image,
      this.monthyear,
      this.oldprice,
      this.name,
      this.discount,
      this.newprice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Column c = Column(children: [
      GestureDetector(
        onTap: () {},
        child: Container(
          width: 300,
          height: 220,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 335,
                  height: 110,
                  child: Image.asset(
                    image!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(children: [
                  Text(name!),
                  Text('Descrizione servizio'),
                  Text('Ente Responsabile')
                ])
              ],
            ),
          ),
        ),
      ),
    ]);

    return c;
  }
}

/*
* Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height! * .8 < 160 ? height! * .140 : 160,
                    width: width! * .8 < 250 ? width! * .8 : 250,
                    //   child:Image .asset(image,fit: BoxFit.cover,)
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 65,
                  width: width! * .8 < 250 ? width! * .8 : 250,
                  left: 5,
                  //right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 15,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              monthyear!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          discount!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ],
    );
* */
