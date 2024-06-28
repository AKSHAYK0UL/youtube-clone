import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildListTile(
    {required BuildContext context,
    required String VideoName,
    required String VideoUrl,
    required String UploadedBy,
    required DateTime UploadedAt}) {
  return ListTile(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
    tileColor: Colors.black12,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    leading: CircleAvatar(
      backgroundColor: Colors.white,
      child: Text(UploadedBy[0]),
    ),
    title: Text(
      VideoName,
      style: Theme.of(context).textTheme.titleMedium,
    ),
    subtitle: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          UploadedBy,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          DateFormat("dd-MMM").format(UploadedAt),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    ),
  );
}
