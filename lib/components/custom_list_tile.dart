import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget customListTile(
    {required String title,
    required String singer,
    required String cover,
    onTap}) {
  //void onTap;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(cover))),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                singer,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              )
            ],
          )
        ],
      ),
    ),
  );
}
