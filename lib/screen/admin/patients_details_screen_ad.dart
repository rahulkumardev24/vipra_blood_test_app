import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/colors.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/widgets/my_navigation_button.dart';
import 'package:vipra_lap/widgets/my_outline_button.dart';

class PatientsDetailsScreenAd extends StatefulWidget {
  final Map<String, dynamic> patientData;
  final dynamic userId;

  const PatientsDetailsScreenAd({super.key, required this.patientData, required this.userId});

  @override
  State<PatientsDetailsScreenAd> createState() => _PatientsDetailsScreenAdState();
}

class _PatientsDetailsScreenAdState extends State<PatientsDetailsScreenAd> {
  List<File> selectedFiles = [];
  bool isLoading = false;

  /// Function to Pick Files
  Future<void> pickFiles() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (filePickerResult != null) {
      setState(() {
        selectedFiles = filePickerResult.paths.map((path) => File(path!)).toList();
      });
    }
  }

  /// Function to Upload Files
  Future<void> uploadFiles() async {
    setState(() {
      isLoading = true;
    });

    for (var file in selectedFiles) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child("reports/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}");
        await storageRef.putFile(file);
      } catch (e) {
        print("Error uploading file: $e");
      }
    }

    setState(() {
      isLoading = false;
    });

    // Optionally, you can update the patient's reports in Firestore here
  }

  @override
  Widget build(BuildContext context) {
    final patient = widget.patientData;

    return Scaffold(
      appBar: AppBar(
        title: Text(patient['userName'] ?? "Patient Details", style: myTextStyle24()),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: MyNavigationButton(
            btnIcon: Icons.arrow_back,
            iconSize: 27,
            btnBackground: Colors.white54,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// Profile Picture
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.deepPurple, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: patient['profilePicture'] != null &&
                            patient['profilePicture'].toString().isNotEmpty
                            ? Image.network(
                          patient['profilePicture'],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/icons/user (5).png"),
                        )
                            : Image.asset("assets/icons/user (5).png"),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Name
                  Text(
                    patient['userName'] ?? 'Unknown',
                    style: myTextStyle24(),
                  ),

                  const SizedBox(height: 15),

                  /// Patient Information
                  _buildInfoCard("Age", patient['age'] ?? 'N/A', Icons.cake),
                  _buildInfoCard("Email", patient['email'] ?? 'N/A', Icons.email),
                  _buildInfoCard("Phone", patient['mobileNumber'] ?? 'N/A', Icons.phone),
                  _buildInfoCard("Gender", patient['gender'] ?? 'N/A', Icons.person),
                  _buildInfoCard("Location", patient['location'] ?? 'N/A', Icons.location_on),

                  const SizedBox(height: 10),

                  /// Reports Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Patient Reports", style: myTextStyle18()),
                      ],
                    ),
                  ),
                  const Divider(),

                  _buildReportsSection(patient),

                  const SizedBox(height: 10),

                  /// **Display Selected Files**
                  if (selectedFiles.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child: ListTile(
                            leading: const Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                            title: Text(selectedFiles[index].path.split('/').last), // Show file name
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),

          /// Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                MyOutlineButton(
                  btnText: "Upload",
                  onPressed: uploadFiles,
                ),
                FilledButton(
                  onPressed: pickFiles,
                  child: Text("Select File", style: myTextStyle24()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ----------------- WIDGETS ------------------////

  /// Widget to Display Information Cards
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  /// Reports Section
  Widget _buildReportsSection(Map<String, dynamic> patient) {
    final reports = patient['reports'] ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// If reports exist, show list
          if (reports.isNotEmpty)
            Column(
              children: reports.map<Widget>((report) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.file_present, color: Colors.deepPurple),
                    title: Text("Report: $report"),
                    trailing: const Icon(Icons.download, color: Colors.deepPurple),
                    onTap: () {
                      // Handle download logic here
                    },
                  ),
                );
              }).toList(),
            )
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("No older reports available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ),
            ),
        ],
      ),
    );
  }
}