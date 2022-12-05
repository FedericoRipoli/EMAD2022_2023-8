import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:photo_view/photo_view.dart';
import '../generali/Chips.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';

class CardEvento extends StatelessWidget {
  final String luogo, data, imgPath, nome;
  const CardEvento(
      {Key? key,
      required this.luogo,
      required this.data,
      required this.imgPath,
      required this.nome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 180.0,
        width: 290.0,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      nome,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Divider(),
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          luogo,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          data,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(3),
                    child: PhotoView(
                      imageProvider: AssetImage(imgPath),
                    ))),
          ],
        ),
      ),
    );
  }
}
