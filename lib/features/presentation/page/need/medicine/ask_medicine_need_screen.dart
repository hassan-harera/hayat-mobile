import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hayat_eg/core/error/exceptions.dart';
import 'package:hayat_eg/features/data/model/city/city.dart';
import 'package:hayat_eg/features/data/model/donation/medicine/medicine_donation_request.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine.dart';
import 'package:hayat_eg/features/data/model/medicine/medicine_unit.dart';
import 'package:hayat_eg/features/data/repository/CityRepository.dart';
import 'package:hayat_eg/features/data/repository/donation/medicine/medicine_donation_repository.dart';
import 'package:hayat_eg/features/data/repository/medicine/medicine_repository.dart';
import 'package:hayat_eg/injection_container.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../layout/HayatLayout/LayOutCubit/HayatLayoutCubit.dart';
import '../../../../../../layout/HayatLayout/LayOutCubit/LayoutState.dart';
import '../../../../../../shared/Utils/Utils.dart';
import '../../../../../../shared/component/component.dart';
import '../../../../../../shared/component/constants.dart';

class AskMedicineNeedScreen extends StatefulWidget {
  const AskMedicineNeedScreen({super.key});

  @override
  State<AskMedicineNeedScreen> createState() => _AskMedicineNeedScreenState();
}

class _AskMedicineNeedScreenState extends State<AskMedicineNeedScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _city = TextEditingController();
  var communicationMethod = '';
  final telegramController = TextEditingController();
  final watsAppController = TextEditingController();
  final medicineController = TextEditingController();
  final _medicineExpirationDateController = TextEditingController();
  final quantityController = TextEditingController();
  final medicineUnitController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? medicineName;

  var formKey = GlobalKey<FormState>();
  Uint8List? _file;
  final CityRepository _cityRepository = sl();
  final MedicineRepository _medicineRepository = sl();
  final MedicineDonationRepository _medicineDonationRepository = sl();

  List<City>? _cities = [];
  List<Medicine>? _medicines = [];
  List<MedicineUnit> _medicineUnits = [];

  @override
  void initState() {
    super.initState();
    _medicineRepository.listUnits().then((value) {
      setState(() {
        _medicineUnits = value;
      });
    });

    _cityRepository.search('').then((value) {
      setState(() {
        _cities = value;
      });
    });

    _medicineRepository.listMedicines().then((value) {
      setState(() {
        _medicines = value;
      });
    });
  }

  _selectImage(BuildContext context) async {
    final size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create post '),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text(
                    'Take a photo from camera',
                  ),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.image),
                  SizedBox(
                    width: size.width / 30,
                  ),
                  const Text('chose from gallery '),
                ],
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LayoutCubit layoutCubit = LayoutCubit.get(context);
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Transform(
                    transform:
                        Matrix4.translationValues(size.width - 220, 0.0, 0.0),
                    child: const Text(
                      'Medicine Need',
                    ),
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        autovalidateMode: autoValidateMode,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => _selectImage(context),
                                  child: _file == null
                                      ? Image.asset(
                                          'assets/add-image.png',
                                          width: 100,
                                          height: 100,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: AspectRatio(
                                              aspectRatio: 478 / 451,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image:
                                                          MemoryImage(_file!),
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          FractionalOffset
                                                              .topCenter,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                // const Spacer(),
                                Expanded(
                                    child: requiredTextField(
                                  controller: titleController,
                                  hint: 'Title',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'please inter title';
                                    }
                                  },
                                )),
                              ],
                            ),
                            descriptionTextField(
                                controller: descriptionController),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                isFilterOnline: true,
                                fit: FlexFit.loose,
                                showSelectedItems: true,
                                showSearchBox: true,
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                ),
                              ),
                              items: _cities!.map((e) => e.arabicName).toList(),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  border: OutlineInputBorder(
                                    gapPadding: 10,
                                  ),
                                  hintText: "Select city",
                                ),
                              ),
                              onChanged: (value) => setState(() {
                                _city.text = _cities!
                                    .firstWhere((element) =>
                                        element.arabicName == value)
                                    .id
                                    .toString();
                              }),
                              selectedItem: null,
                              validator: (String? item) {
                                if (item == null) {
                                  return "City is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                isFilterOnline: true,
                                fit: FlexFit.loose,
                                showSelectedItems: true,
                                showSearchBox: true,
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                favoriteItemProps: FavoriteItemProps(
                                  showFavoriteItems: true,
                                ),
                              ),
                              items:
                                  _medicines!.map((e) => e.arabicName).toList(),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  border: OutlineInputBorder(
                                    gapPadding: 10,
                                  ),
                                  hintText: "Chose Medicine ",
                                ),
                              ),
                              onChanged: (value) => setState(() {
                                medicineController.text = _medicines!
                                    .firstWhere((element) =>
                                        element.arabicName == value)
                                    .id
                                    .toString();
                              }),
                              selectedItem: null,
                              validator: (String? item) {
                                if (item == null) {
                                  return "City is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                child: FutureBuilder<List<MedicineUnit>>(
                              future: _medicineRepository.listUnits(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<MedicineUnit> units = snapshot.data!;
                                  var selectedMedicineItem;
                                  return DropdownButtonFormField(
                                    hint: const Text('Medicine Unit'),
                                    iconEnabledColor: Colors.amber,
                                    validator: (sGenderItem) {
                                      if (sGenderItem == null) {
                                        return 'please Add Medicine Unit';
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                    ),
                                    value: selectedMedicineItem,
                                    items: units
                                        .map((item) => DropdownMenuItem(
                                            value: jsonEncode(
                                                item.englishName.toString()),
                                            child: Text(
                                              (item.englishName.toString()),
                                            )))
                                        .toList(),
                                    onChanged: (item) {
                                      selectedMedicineItem = item;
                                    },
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.amber),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: requiredTextField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please inter amount';
                                  }
                                },
                                hint: 'Medicine Amount',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Communication Method',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: RadioListTile(
                                        value: 'Chat',
                                        selectedTileColor: Colors.white,
                                        title: const Text(
                                          'Chat',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                    onTap: () {
                                      communicationMethod = 'CHAT';
                                    },
                                  ),
                                  GestureDetector(
                                    child: RadioListTile(
                                        value: 'Phone',
                                        activeColor: Colors.amber,
                                        hoverColor: Colors.amber,
                                        selectedTileColor: Colors.white,
                                        selected: true,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: const Text(
                                          'Phone',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                    onTap: () {
                                      setState(() {
                                        communicationMethod = 'PHONE';
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    excludeFromSemantics: true,
                                    child: RadioListTile(
                                        value: 'Phone & Chat',
                                        activeColor: Colors.amber,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        hoverColor: Colors.amber,
                                        title: const Text(
                                          'Phone & Chat',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        groupValue:
                                            layoutCubit.communicationTool,
                                        onChanged: (value) {
                                          layoutCubit.communicationTool = value;
                                          layoutCubit.changRadioValue();
                                        }),
                                    onTap: () {
                                      communicationMethod = 'CHAT_AND_PHONE';
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Social Media',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: watsAppController,
                                  keyboardType: TextInputType.phone,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'please add your watsApp number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Image.asset(
                                        'assets/watsAppImage.png',
                                        scale: 18,
                                        color: Colors.amber,
                                      ),
                                      hintText: 'Whatsapp',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.amber,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.amber))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'please add your telegram number';
                                    }
                                  },
                                  controller: telegramController,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.telegram_outlined,
                                        color: Colors.amber,
                                        size: 35,
                                      ),
                                      hintText: 'Telegram',
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.amber,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.amber))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            myButton(
                                text: 'Submit',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    onSubmit();
                                    setState(() {});
                                    autoValidateMode =
                                        AutovalidateMode.onUserInteraction;
                                  } else {
                                    autoValidateMode = AutovalidateMode.always;
                                  }
                                  //
                                },
                                radius: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  void onSubmit() async {
    final request = MedicineDonationRequest(
      title: titleController.text,
      description: descriptionController.text,
      cityId: _cities?[0].id,
      communicationMethod: 'CHAT',
      quantity: double.parse(quantityController.text),
      telegramLink: "https://t.me/${telegramController.text}",
      whatsappLink: "https://wa.me/${watsAppController.text}",
      medicineId: _medicines?[0].id,
      medicineUnitId: _medicineUnits?[0].id,
      medicineExpirationDate: _medicineExpirationDateController.text,
    );
    print(request.toJson());
    final response = _medicineDonationRepository.create(request);
    response.then((value) => {
          print(value),
        });
    response.onError((error, stackTrace) {
      if (error is BadRequestException) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Something Went Wrong'),
              content: Text(error.apiError.displayMessage.toString()),
              actions: <Widget>[
                TextButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      stackTrace.printError();
    });
  }
}
