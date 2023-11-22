import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_flutter/src/models/response/person.dart';

class PersonDetailScreen extends StatelessWidget {
  const PersonDetailScreen({super.key, required this.data});
  final Person data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.fullName()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            key: ValueKey(data.id),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40.sp,
                    child: CachedNetworkImage(
                      imageUrl: data.image!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _boxItem(title: 'Birthday', content: data.birthday!),
                      _boxItem(title: 'Gender', content: data.gender!),
                      _boxItem(title: 'Email', content: data.email!),
                      _boxItem(title: 'Phone', content: data.phone!),
                      _boxItem(title: 'Website', content: data.website!),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: data.fullName(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "'s address information!",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    key: ValueKey(data.address?.id),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _boxItem(
                          title: 'Country', content: data.address!.country!),
                      _boxItem(title: 'City', content: data.address!.city!),
                      _boxItem(title: 'Street', content: data.address!.street!),
                      _boxItem(
                        title: 'Street Name',
                        content: data.address!.streetName!,
                      ),
                      _boxItem(
                        title: 'Country Code',
                        content: data.address!.countyCode!,
                      ),
                      _boxItem(
                          title: 'Zipcode', content: data.address!.zipcode!),
                      _boxItem(
                        title: 'Building Number',
                        content: data.address!.buildingNumber!,
                      ),
                      _boxItem(
                        title: 'Location',
                        content: data.location(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RichText _boxItem({String? title, String? content}) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      height: 2.h,
    );
    return RichText(
      text: TextSpan(
        text: '$title:  ',
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: content ?? '',
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
