import 'package:flutter/material.dart';
import 'package:frontend_sws/theme/theme.dart';

import '../../screens/AddDefibrillatoreForm.dart';

class AddDefCard extends StatelessWidget {
  const AddDefCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(16),
      color: AppColors.detailBlue,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddDefibrillatoreForm()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Aggiungi un nuovo defibrillatore",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.monitor_heart_outlined,
          color: AppColors.logoCadmiumOrange,
          size: 24,
        ),
      ),
    );
  }
}
