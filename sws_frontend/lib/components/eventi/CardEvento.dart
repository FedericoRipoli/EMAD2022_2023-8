import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import 'package:photo_view/photo_view.dart';
import '../generali/ChipGenerale.dart';
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
        height: 200.0,
        width: 110.0,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: AppColors.logoBlue,
                spreadRadius: 0,
                blurRadius: 1.5,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      nome,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          luogo,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 16,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          data,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.logoCadmiumOrange,
                        ),
                        Text(
                          data,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(3), child: Text("Immagine"))),
          ],
        ),
      ),
    );
  }
}
