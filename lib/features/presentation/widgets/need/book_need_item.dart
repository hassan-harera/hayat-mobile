import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hayat_eg/features/data/model/need/book/book_need_response.dart';
import 'package:hayat_eg/layout/LayoutScreens/ItemScreen/ItemScreen.dart';
import 'package:hayat_eg/shared/component/constants.dart';

Widget bookNeedItem(BuildContext context, BookNeedResponse needResponse) {
  final size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      myNavigator(context, ItemScreen(titleName: 'k'));
    },
    child: Container(
      height: 155,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 155,
            width: size.width / 3,
            decoration: BoxDecoration(
                color: Color(0xffE3EAF2),
                border: Border.all(
                  color: Color(0xffE3EAF2),
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.image_outlined,
              color: Colors.black,
              size: 40,
            ),
          ),
          SizedBox(
            width: size.width / 20,
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    needResponse.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    width: size.height / 25,
                  ),
                  Text(
                    '${needResponse.user!.firstName!} ${needResponse.user!.lastName!}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: size.height / 25,
                  ),
                  Text(
                    'Description food  food Donation Description food  food Donation Description food  food Donation',
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffE3EAF2),
                          border: Border.all(color: Color(0xff20ADDC)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: size.height / 20,
                        width: size.width / 3,
                      ),
                      Spacer(),
                      Text('2 days lift'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
