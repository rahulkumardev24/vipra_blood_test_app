import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/widgets/my_filled_button.dart';
import 'package:vipra_lap/widgets/my_navigation_button.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';
import 'package:vipra_lap/widgets/my_text_field.dart';

import '../domain/colors.dart';

class OrderTestScreen extends StatefulWidget {
  const OrderTestScreen({super.key});

  @override
  State<OrderTestScreen> createState() => _OrderTestScreenState();
}

class _OrderTestScreenState extends State<OrderTestScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController flatNumController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  PermissionStatus? locationPermissionStatus;

  List<String> testList = [
    "Blood test",
    "Complete Blood Count (CBC)",
    "Lipid Panel",
    "Liver Function Test (LFT)",
    "Thyroid Function Test",
    "Hemoglobin A1c (HbA1c)",
    "Blood Typing",
    "Vitamin D Test",
    "C-Reactive Protein (CRP)",
    "Iron Studies",
    "Prothrombin Time (PT/INR)"
  ];

  String selectedTest = "Blood test";

  @override
  void initState() {
    super.initState();
    _checkPermission();
    // _currentLocation();
  }

  /// check permission

  /// Check location permission and fetch location
  Future<void> _checkPermission() async {
    locationPermissionStatus = await Permission.location.request();
    if (locationPermissionStatus!.isGranted) {
      await _currentLocation();
    } else if (locationPermissionStatus!.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Permission is permanently denied"),
        action: SnackBarAction(
          label: "Settings",
          onPressed: () async {
            await openAppSettings();
          },
        ),
      ));
    } else if (locationPermissionStatus!.isDenied) {
      locationPermissionStatus = await Permission.location.request();
    }
  }

  /// fetch current location
  Future<void> _currentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placeMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMark[0];

      String location = "${place.locality}";
      addressController.text = location;
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to get location: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// _____________________________Appbar__________________________________________///
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order test",
          style: myTextStyle24(fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: MyNavigationButton(
              btnIcon: Icons.backspace_outlined,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),

      ///_________________________BODY__________________________________________///
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// name
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: nameController,
                  prefixIcon: Icons.person,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Enter Your Name",
                  labelText: "Name",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                ),
              ),
              // email
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: emailController,
                  prefixIcon: Icons.email,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Enter email",
                  labelText: "Email",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                ),
              ),

              /// number
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: numberController,
                  prefixIcon: Icons.phone_android,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Enter number",
                  labelText: "Number",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                ),
              ),

              /// ______________________DROP DOWN list_________________________///
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryLight.withOpacity(0.8)),
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(20),
                    value: selectedTest,
                    items: testList.map((test) {
                      return DropdownMenuItem<String>(
                        value: test,
                        child: Text(test),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTest = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Select a Blood Test",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: AppColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ),

              /// Date
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: dateController,
                  prefixIcon: Icons.phone_android,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Select Date",
                  labelText: "Date",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                  suffixIcon: Icons.date_range,
                  suffixIconOnPress: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2025),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(2030));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('y MMM d').format(pickedDate);
                      dateController.text = formattedDate;
                      setState(() {});
                    }
                  },
                ),
              ),

              /// Time
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: timeController,
                  prefixIcon: Icons.phone_android,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Select time",
                  labelText: "Time",
                  suffixIcon: Icons.watch_later_outlined,
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                  suffixIconOnPress: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (pickedTime != null) {
                      String formattedTime = pickedTime.format(context);
                      timeController.text = formattedTime;
                    }
                    setState(() {});
                  },
                ),
              ),

              /// Address
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: addressController,
                  prefixIcon: Icons.location_on,
                  sufAndFixIconColor: Colors.red,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Enter address",
                  labelText: "Address",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                  suffixIcon: Icons.location_searching_rounded,
                  suffixIconColor: Colors.black54,
                  suffixIconOnPress: () {
                    _currentLocation();
                  },
                ),
              ),

              /// Flat no...........
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: MyTextField(
                  textEditingController: flatNumController,
                  prefixIcon: Icons.home,
                  filled: true,
                  borderRadius: 8,
                  hintText: "Enter Flat no ",
                  labelText: "Flat-No",
                  filledColor: AppColors.primaryLight.withOpacity(0.8),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              /// __________________________________ BUTTON _______________________________________///

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// cancel Button
                  MyOutlineButton(
                      btnText: "Cancel",
                      btnTextColor: Colors.red,
                      textWeight: FontWeight.bold,
                      btnBackground: Colors.white,
                      borderColor: Colors.red,
                      borderRadius: 8,
                      onPressed: () {
                        Navigator.pop(context);
                      }),

                  /// Order Button
                  MyFilledButton(
                      btnText: "Order",
                      textWeight: FontWeight.bold,
                      borderRadius: 8,
                      onPressed: () {
                        if (nameController.text.isEmpty &&
                            emailController.text.isEmpty &&
                            numberController.text.isEmpty &&
                            dateController.text.isEmpty &&
                            timeController.text.isEmpty &&
                            addressController.text.isEmpty &&
                            flatNumController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColors.errorColor,
                              content: Text(
                                "Plz enter all details",
                                style: myTextStyle18(fontColor: Colors.white),
                              )));
                        }else {
                          /// here we perform task
                        }
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
