import 'package:clear_architecture_practise/feature/domain/entities/person_entity.dart';
import 'package:clear_architecture_practise/feature/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_cololrs.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              person.name,
              style: const TextStyle(
                  fontSize: 28, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 12,
            ),
            PersonCacheImage(
              width: 260,
              height: 260,
              imageUrl: person.image,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ...detailInfo('Gender:', person.gender),

            ...detailInfo('Number of episodes:', person.episode.length.toString()),

            ...detailInfo('Species:', person.species),

            ...detailInfo('Last known location: ', person.location.name),

            ...detailInfo('Origin:', person.origin.name),

            ...detailInfo('Was created:', person.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> detailInfo(String key, String value) {
    return [
      Text(
        key,
        style: const TextStyle(color: AppColors.greyColor),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
      const SizedBox(
        height: 16,
      ),
    ];
  }
}
