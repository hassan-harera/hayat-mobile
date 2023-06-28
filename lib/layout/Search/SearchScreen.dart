import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hayat_eg/models/Medicine/medicine_unit.dart';

import '../../models/Medicine/medicineModel.dart';
import '../../services/getRequest/medicine/medicine-search.dart';
import '../../services/getRequest/medicine/medicine-api-get.dart';
import '../../styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var typeController = TextEditingController();
  var searchController = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.amber,
                size: 30,
              ),
            ),
          ),
        ),
        title: Text(
          'search screen'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FutureBuilder<List<MedicineModel>>(
              future: MedicineServices().getListMedicineName(),
              builder: ( context , snapshot ) {
                if (snapshot.hasData) {
                  List<MedicineModel> listOfMedicine = snapshot.data!;

                  return  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                      title: Text('${listOfMedicine[index].englishName}'),
                    ),
                    itemCount: listOfMedicine.length,

                    ),
                  );
                } else {
                  return const Center(child: Text('..............'));
                }
              },

            ),
          ],
        ),
      ),
    );
  }
}

// class imageProvidor => Container(
// width: 140,
// decoration: BoxDecoration(
// borderRadius: BorderRadiusDirectional.circular(10)
// ,     color: Colors.white,
// ),
//
// child:Column(
// children: [
// Image.asset('assets/addImage.png',width: 130,height:140 ,color:Colors.cyanAccent ),
// Padding(
// padding: const EdgeInsetsDirectional.only(bottom: 8),
//
// ),
//
// ],
// ),
//);
