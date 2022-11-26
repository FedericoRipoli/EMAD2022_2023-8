import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/getwidget.dart';
import 'package:frontend_sws/theme/theme.dart';

class InfoServizio extends StatelessWidget {
  const InfoServizio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: GFAppBar(
          title: const Text("Info Servizio"),
          leading: GFIconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            type: GFButtonType.transparent,
          ),
          searchBar: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.logoBlue,
        ),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 8,
          hoverElevation: 8,
          onPressed: () {},
          backgroundColor: Colors.green.shade700,
          label: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Icon(
                  Icons.call,
                  size: 18,
                ),
              ),
              Text(
                "Contatta",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: WaveClipperOne(flip: true),
                      child: Container(
                        height: 80, //400
                        color: AppColors.logoBlue,
                      ),
                    ),
                  ],
                ),
                GFListTile(
                  avatar: const GFAvatar(
                    shape: GFAvatarShape.standard,
                    child: Text("EA"),
                  ),
                  color: Colors.white,
                  title: GFTypography(
                    text: 'Nome Servizio',
                    type: GFTypographyType.typo2,
                    showDivider: false,
                    textColor: AppColors.logoBlue,
                  ),
                  subTitle: GFTypography(
                    text: 'Nome Ente',
                    type: GFTypographyType.typo4,
                    icon: Icon(
                      Icons.home_work_rounded,
                      color: AppColors.logoBlue,
                    ),
                    dividerColor: AppColors.logoBlue,
                    textColor: AppColors.logoBlue,
                    fontWeight: FontWeight.normal,
                    dividerWidth: 130.0,
                  ),
                ),
                const SizedBox(height: 20),
                GFListTile(
                  description: GFTypography(
                    text: "descrizione",
                    type: GFTypographyType.typo4,
                    fontWeight: FontWeight.normal,
                    showDivider: false,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Chip(
                      elevation: 6,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black,
                      avatar: Icon(
                        Icons.access_time,
                        color: AppColors.logoBlue,
                      ),
                      label: const Text(
                        '12:00 - 15:00',
                        style: TextStyle(fontSize: 20),
                      ), //Text
                    ),
                    Chip(
                      elevation: 8,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black,
                      avatar: Icon(
                        Icons.calendar_month,
                        color: AppColors.logoBlue,
                      ),
                      label: const Text(
                        'dal 22 Dicembre',
                        style: TextStyle(fontSize: 20),
                      ), //Text
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "Ambito",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "Tipologia",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        "#TAGS",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Chip(
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.green.shade700,
                      label: Text(
                        "Active",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const GFListTile(
                  title: GFTypography(
                    text: 'Dove puoi usufruire del servizio?',
                    type: GFTypographyType.typo2,
                    showDivider: false,
                    textColor: AppColors.logoBlue,
                  ),
                  icon: Icon(
                    Icons.location_on,
                    color: AppColors.logoBlue,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
