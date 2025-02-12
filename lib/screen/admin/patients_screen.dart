import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';
import 'package:vipra_lap/screen/admin/patients_details_screen_ad.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients List"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching data: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Patients Found"));
          } else {
            var patients = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: Text(
                    "Total : ${patients.length}",
                    style: myTextStyle24(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4),
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      var patientData =
                      patients[index].data() as Map<String, dynamic>;
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          title: Text(
                            patientData['userName'] ?? 'Unknown',
                            style: myTextStyle18(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                          Text("${patientData['email'] ?? 'No Email'}"),
                          leading: patientData['profilePicture']
                              .toString()
                              .isNotEmpty
                              ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                  patientData['profilePicture'] ??
                                      "assets/icons/user.png"))
                              : Image.asset("assets/icons/user (5).png"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PatientsDetailsScreenAd(
                                  patientData: patientData,
                                  userId: patientData['uid'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}