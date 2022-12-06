import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class DetailPageService extends StatelessWidget{

  final String title, ente, area;
  final String? descrizione, posizione, data;

  DetailPageService(
      {Key? key,
        required this.title,
        required this.ente,
        required this.area,
        this.descrizione,
        this.posizione,
        this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      image: Image.asset(
        'lib/assets/cup.jpg',
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      showImage: true,
      title: GFListTile(
        avatar: GFAvatar(
          backgroundImage: AssetImage('your asset image'),
        ),
        titleText: '$title',
        subTitleText: 'PlayStation 4',
      ),
      content: Text("Some quick example text to build on the card"),
      buttonBar: GFButtonBar(
        children: <Widget>[
          GFAvatar(
            backgroundColor: GFColors.SUCCESS,
            child: Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

}