import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/widgets/my_filled_button.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';
import 'package:vipra_lap/widgets/my_text_field.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  MediaQueryData? mqData;



  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Lab Tests",
          style: myTextStyle24(fontWeight: FontWeight.bold),
        ),
        actions: const [
          FaIcon(FontAwesomeIcons.cartShopping),
          SizedBox(
            width: 12,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Need Help
            ListTile(
              leading: Container(
                  width: 80,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(30),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset("assets/icons/doctor-consultation.png"),
                  )),
              title: Text(
                "Need Help?",
                style: myTextStyle18(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Request a call back",
                style: myTextStyle15(),
              ),

              /// Book Now Button
              /// ___________________________Dialog BOX______________________________________///
              trailing: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                              height: mqData!.size.height * 0.5,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      "Book Your Call",
                                      style: myTextStyle24(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8),
                                    child: MyTextField(
                                      textEditingController: nameController,
                                      hintText: "Enter Your Name ",
                                      labelText: "Name",
                                      prefixIcon: Icons.person,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8),
                                    child: MyTextField(
                                      textEditingController: mobController,
                                      hintText: "Enter mobile name ",
                                      labelText: "Mobile Number",
                                      prefixIcon: Icons.phone,
                                    ),
                                  ),



                                  /// Date Picker
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 6),
                                    child: MyTextField(
                                      textEditingController: dateController,
                                      suffixIcon: Icons.calendar_month_sharp,
                                      hintText: "Choose Date",
                                      suffixIconOnPress: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2025),
                                          lastDate: DateTime(2030),
                                        );
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('yMd')
                                                  .format(pickedDate);
                                          dateController.text = formattedDate;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ),

                                  /// Time Picker
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 6),
                                    child: MyTextField(
                                      textEditingController: timeController,
                                      suffixIcon: Icons.watch_later_outlined,
                                      hintText: "Select time",
                                      suffixIconOnPress: () async {
                                        TimeOfDay? time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                        if (time != null) {
                                          String timeFormat =
                                              time.format(context);
                                          timeController.text = timeFormat;
                                        }
                                      },
                                    ),
                                  ),

                                  /// cancel and boo button
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MyOutlineButton(
                                          btnText: "Cancel",
                                          borderRadius: 10,
                                          btnTextColor:
                                              AppColors.secondaryColor,
                                          borderColor: AppColors.secondaryColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      MyFilledButton(
                                          btnText: "Book",
                                          textWeight: FontWeight.bold,
                                          borderRadius: 10,
                                          onPressed: () {
                                            if (nameController.text.isEmpty &&
                                                mobController.text.isEmpty &&
                                                dateController.text.isEmpty &&
                                                timeController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          AppColors.errorColor,
                                                      content: Text(
                                                          "Plz Fill All The Details")));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content: Text(
                                                          "Successfully Booked")));
                                              Navigator.pop(context);
                                            }
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white),
                  child: Text(
                    "Book Now",
                    style: myTextStyle15(
                        fontWeight: FontWeight.w800, fontColor: Colors.white),
                  )),
            ),
            Text(
              "Blood Test",
              style: myTextStyle18(),
            )
          ],
        ),
      ),
    );
  }
}
