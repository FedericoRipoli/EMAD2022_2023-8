import 'package:flutter/material.dart';
import 'package:frontend_sws/components/AllPageLoad.dart';
import 'package:frontend_sws/services/AreeService.dart';
import '../services/entity/Area.dart';
import '../theme/theme.dart';

class CardListAmbiti extends StatefulWidget {
  static String id = 'it.unisa.emad.comunesalerno.sws.ipageutil.CardListAmbiti';
  CardListAmbiti({Key? key}) : super(key: key);

  @override
  State<CardListAmbiti> createState() => _CardListAmbitiState();
}

class _CardListAmbitiState extends State<CardListAmbiti> {
  AreeService areeService = AreeService();

  Future<List<Area>?> _fetchData() async {
    try {
      var aree = await areeService.areeList(null);
      return aree;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 6),
                child: const Text(
                  "Visualizza per Area di riferimento",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder<List<Area>?>(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ChipAmbito(
                        label: snapshot.data![index].nome.toString(),
                        icon: Icons.accessibility);
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const AllPageLoad();
            },
          ),
        ),
      ],
    );
  }
}

/*
*
*
*
* */

class ChipAmbito extends StatelessWidget {
  final String label;
  final IconData icon;
  const ChipAmbito({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: 104,
        height: 62,
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.only(left: 10, bottom: 3, top: 3, right: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, offset: Offset(0.1, 0.1), blurRadius: 0.4),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.logoBlue,
              size: 36,
            ),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
