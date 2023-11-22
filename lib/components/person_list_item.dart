import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:interview_flutter/src/controllers/person_controller.dart';
import 'package:interview_flutter/src/models/response/person.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({required this.person, super.key});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          onTap: () {
            Get.find<PersonController>().goToDetail(person);
          },
          leading: CachedNetworkImage(
            imageUrl: person.image!,
            placeholder: (context, url) => const CircularProgressIndicator(
              strokeWidth: 1,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(
            '${person.firstname!} ${person.lastname!}',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(person.email!),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          dense: true,
        ),
      ),
    );
  }
}
