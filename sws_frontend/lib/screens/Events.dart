import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/components/Clipper07.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Mensa', 'Potito', 'Akask'];

    return Scaffold(
      appBar: GFAppBar(
        elevation: 0,
        searchBar: true,
        backgroundColor: appTheme.primaryColor,
        title: const Text("Sezione Eventi"),
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: Clipper07(),
                  child: Container(
                    height: 100, //400
                    color: appTheme.primaryColor,
                    child: const Center(
                      child: Text(
                        "Filtra per",
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(14),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return GFCard(
                  color: Colors.white,
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  elevation: 10,
                  borderOnForeground: true,
                  image: Image.asset(
                    'assets/images/servizi-sociali.jpg',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  showImage: true,
                  title: GFListTile(
                    avatar: const GFAvatar(
                      shape: GFAvatarShape.standard,
                      child: Text("AB"),
                    ),
                    titleText: 'Evento ${entries[index]}',
                    subTitleText: 'Ente Mirò',
                  ),
                  content: const Text("Descrizione evento"),
                  buttonBar: const GFButtonBar(
                    children: <Widget>[
                      GFAvatar(
                        backgroundColor: GFColors.PRIMARY,
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.SECONDARY,
                        child: Icon(
                          Icons.info_outlined,
                          color: Colors.white,
                        ),
                      ),
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
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
