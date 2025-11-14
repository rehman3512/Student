// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:student/Controllers/AuthController/authcontroller.dart';
// import 'package:student/Models/EnrollModel/enrollmodel.dart';
// import 'package:student/Models/SubjectModel/subjectmodel.dart';
// import 'package:student/Widgets/ShowMessage/showmessage.dart';
//
// class StudentController extends GetxController {
//   TextEditingController subjectController = TextEditingController();
//   TextEditingController subjectIdController = TextEditingController();
//   TextEditingController teacherController = TextEditingController();
//   TextEditingController classController = TextEditingController();
//   TextEditingController durationController = TextEditingController();
//   TextEditingController registrationController = TextEditingController();
//   TextEditingController fatherNameController = TextEditingController();
//   TextEditingController trackIdController = TextEditingController();
//   TextEditingController transactionController = TextEditingController();
//   TextEditingController accountHolderController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//
//
//   var isLoading = false.obs;
//   var isLogin = false.obs;
//   var isDelete = false.obs;
//   var currentIndex = 0.obs;
//   var age = " ".obs;
//   var gender = " ".obs;
//   var enrollList = <EnrollModel>[].obs;
//   var subjectList = <SubjectModel>[].obs;
//
//   final authController = Get.find<AuthController>();
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     Future.delayed(Duration.zero, () {
//       fetchSubject();
//     });
//   }
//
//   getUid() {
//     return FirebaseAuth.instance.currentUser!.uid;
//   }
//
//   changeTab(int index){
//     currentIndex.value = index;
//   }
//
//
//   fetchSubject() async {
//     try {
//       isLoading.value = true;
//       var snapshot = await FirebaseFirestore.instance
//           .collection("subjectForm")
//           .get();
//
//       subjectList.clear();
//
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         subjectList.add(
//           SubjectModel(
//             subject: data["subjectName"] ?? "",
//             id: doc.id,
//             subjectId: data["subjectId"] ?? "",
//             duration: data["duration"] ?? "",
//             classTime: data["classTime"] ?? "",
//             registration: data["registration"] ?? "",
//             teacher: data["teacherName"] ?? "",
//           ),
//         );
//       }
//     } catch (e) {
//       ShowMessage.errorMessage("Error: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   fetchEnrollments() async {
//     try {
//       isLoading.value = true;
//       enrollList.clear();
//       subjectList.clear(); // optional, agar enrolled subjects ko subjectList me show karna hai
//
//       var subjectsSnapshot = await FirebaseFirestore.instance.collection("subjectForm").get();
//
//       for (var subjectDoc in subjectsSnapshot.docs) {
//         // Check if current user is enrolled in this subject
//         var enrollSnapshot = await subjectDoc.reference
//             .collection("enrollForm")
//             .doc(getUid())
//             .get();
//
//         if (enrollSnapshot.exists) {
//           var data = enrollSnapshot.data() as Map<String, dynamic>;
//           if (data['status'] == "Approved") {
//             // ✅ Add subject to enrolled list
//             subjectList.add(
//               SubjectModel(
//                 subject: subjectDoc['subjectName'] ?? '',
//                 id: subjectDoc.id,
//                 subjectId: subjectDoc['subjectId'] ?? '',
//                 duration: subjectDoc['duration'] ?? '',
//                 classTime: subjectDoc['classTime'] ?? '',
//                 registration: subjectDoc['registration'] ?? '',
//                 teacher: subjectDoc['teacherName'] ?? '',
//               ),
//             );
//           }
//         }
//       }
//
//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       print("Error fetching enrolled subjects: $e");
//     }
//   }
//
//   submitEnroll(SubjectModel subject) async {
//     try {
//       isLoading.value = true;
//       if (subjectController.text.isEmpty ||
//           authController.userController.text.isEmpty ||
//           fatherNameController.text.isEmpty ||
//           trackIdController.text.isEmpty ||
//           transactionController.text.isEmpty) {
//         ShowMessage.errorMessage("All fields are required");
//       } else {
//         final docRef = await FirebaseFirestore.instance
//             .collection("subjectForm").doc(subject.id)
//             .collection("enrollForm")
//             .doc(getUid());
//
//         final docSnapshot = await docRef.get();
//
//         if (docSnapshot.exists) {
//           final data = docSnapshot.data() as Map<String, dynamic>;
//           final status = data["status"] ?? "";
//
//           if (status == "Pending") {
//             ShowMessage.errorMessage(
//               "Your request is already pending approval.",
//             );
//             return;
//           } else if (status == "Approved") {
//             ShowMessage.errorMessage("You are already enrolled");
//             return;
//           } else if (status == "Rejected") {
//             await docRef.set({
//               "userName": authController.userController.text,
//               "userFatherName": fatherNameController.text,
//               "trackId": trackIdController.text,
//               "transactionName": transactionController.text,
//               "status": "Pending",
//               "feesStatus": "notPaid",
//             });
//
//             ShowMessage.successMessage("Re-submitted successfully.");
//             clearAllFields();
//             Get.back();
//             return;
//           }
//         }
//
//         await docRef.set({
//           "userName": authController.userController.text,
//           "userFatherName": fatherNameController.text,
//           "trackId": trackIdController.text,
//           "transactionName": transactionController.text,
//           "status": "Pending",
//           "feesStatus": "notPaid",
//           "submittedAt": FieldValue.serverTimestamp(),
//           "userEmail": FirebaseAuth.instance.currentUser!.email,
//
//         });
//         enrollList.add(
//           EnrollModel(
//             name: authController.userController.text,
//             id: subject.id,
//             fatherName: fatherNameController.text,
//             trackId: trackIdController.text,
//             transaction: transactionController.text,
//             status: "Pending",
//             feesStatus: "notPaid",
//           ),
//         );
//         ShowMessage.successMessage("Enroll Successfully");
//         clearAllFields();
//         Get.back();
//       }
//     } catch (e) {
//       ShowMessage.errorMessage("Error: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   clearAllFields() {
//     authController.userController.clear();
//     fatherNameController.clear();
//     trackIdController.clear();
//     transactionController.clear();
//   }
//
//
//   // ✅ Fee Submit Function
//   // Future<void> submitFee(SubjectModel subject) async {
//   //   if (authController.userController.text.isEmpty ||
//   //       fatherNameController.text.isEmpty ||
//   //       accountHolderController.text.isEmpty ||
//   //       trackIdController.text.isEmpty ||
//   //       transactionController.text.isEmpty) {
//   //     Get.snackbar(
//   //       "Error",
//   //       "All fields are required",
//   //       backgroundColor: Colors.red,
//   //       colorText: Colors.white,
//   //     );
//   //     return;
//   //   }
//   //
//   //   try {
//   //     isLoading.value = true;
//   //
//   //     // ✅ Check if a pending request exists for this subject
//   //     final docRef = FirebaseFirestore.instance
//   //         .collection("subjectForm")
//   //         .doc(subject.id)
//   //         .collection("feeRequests")
//   //         .doc(getUid());
//   //
//   //     final docSnapshot = await docRef.get();
//   //
//   //     if (docSnapshot.exists) {
//   //       final data = docSnapshot.data() as Map<String, dynamic>;
//   //       final status = data["status"] ?? "";
//   //
//   //       if (status == "Pending") {
//   //         Get.snackbar(
//   //           "Error",
//   //           "You already have a pending fee request for this subject.",
//   //           backgroundColor: Colors.red,
//   //           colorText: Colors.white,
//   //         );
//   //         return; // ✅ Stop here
//   //       }
//   //     }
//   //
//   //     // ✅ If no pending request, submit fee
//   //     await docRef.set({
//   //       "userName": authController.userController.text,
//   //       "userFatherName": fatherNameController.text,
//   //       "subjectId": subject.subjectId, // admin-created subjectId
//   //       "accountHolder": accountHolderController.text,
//   //       "trackId": trackIdController.text,
//   //       "transactionMethod": transactionController.text,
//   //       "status": "Pending",
//   //       "submittedAt": FieldValue.serverTimestamp(),
//   //     });
//   //
//   //     Get.snackbar(
//   //       "Success",
//   //       "Fee request submitted successfully",
//   //       backgroundColor: Colors.green,
//   //       colorText: Colors.white,
//   //     );
//   //
//   //     // Clear fields
//   //     authController.userController.clear();
//   //     fatherNameController.clear();
//   //     accountHolderController.clear();
//   //     trackIdController.clear();
//   //     transactionController.clear();
//   //
//   //     Get.back();
//   //   } catch (e) {
//   //     Get.snackbar(
//   //       "Error",
//   //       "Failed to submit fee: $e",
//   //       backgroundColor: Colors.red,
//   //       colorText: Colors.white,
//   //     );
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
//
//   Future<void> submitFee(SubjectModel subject) async {
//     if (authController.userController.text.isEmpty ||
//         fatherNameController.text.isEmpty ||
//         accountHolderController.text.isEmpty ||
//         trackIdController.text.isEmpty ||
//         transactionController.text.isEmpty ||
//         subjectIdController.text.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "All fields are required",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     // ✅ Check if entered Subject ID is valid and enrolled
//     bool isValidId = subjectList.any((s) => s.subjectId == subjectIdController.text);
//     if (!isValidId) {
//       Get.snackbar(
//         "Error",
//         "Wrong Subject ID or you are not enrolled in this subject",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//
//       final docRef = FirebaseFirestore.instance
//           .collection("subjectForm")
//           .doc(subject.id)
//           .collection("feeRequests")
//           .doc(getUid());
//
//       final docSnapshot = await docRef.get();
//
//       if (docSnapshot.exists) {
//         final data = docSnapshot.data() as Map<String, dynamic>;
//         final status = data["status"] ?? "";
//         if (status == "Pending") {
//           Get.snackbar(
//             "Error",
//             "Fee request already submitted and pending approval",
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       await docRef.set({
//         "userName": authController.userController.text,
//         "userFatherName": fatherNameController.text,
//         "subjectId": subjectIdController.text,
//         "accountHolder": accountHolderController.text,
//         "trackId": trackIdController.text,
//         "transactionMethod": transactionController.text,
//         "status": "Pending",
//         "submittedAt": FieldValue.serverTimestamp(),
//         "userEmail": FirebaseAuth.instance.currentUser!.email,
//         "userFatherName": fatherNameController.text,
//       });
//
//       Get.snackbar(
//         "Success",
//         "Fee request submitted successfully",
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//
//       // Clear fields
//       fatherNameController.clear();
//       accountHolderController.clear();
//       trackIdController.clear();
//       transactionController.clear();
//       subjectIdController.clear();
//
//       Get.back();
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to submit fee: $e",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   insertProfile()async{
//     try{
//       isLoading.value = true;
//       await FirebaseFirestore.instance.collection("users").doc(getUid())
//           .set({
//         "userName" : authController.userController.text,
//         "userEmail" : await FirebaseAuth.instance.currentUser!.email,
//         "userAge" : int.tryParse(ageController.text)??0,
//         "userGender" : genderController.text,
//       });
//       ShowMessage.successMessage("Your profile has been updated");
//     }catch(e){
//       ShowMessage.errorMessage("Error: ${e.toString()}");
//     }finally{
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchProfile() async {
//     try {
//       isLoading.value = true;
//
//       final doc = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(getUid())
//           .get();
//
//       if (doc.exists) {
//         final data = doc.data() as Map<String, dynamic>;
//
//         // Controllers me data set kar rahe hain
//         authController.userController.text = data["userName"] ?? "";
//         authController.emailController.text = data["userEmail"] ?? "";
//         ageController.text = (data["userAge"] ?? "").toString();
//         genderController.text = data["userGender"] ?? "";
//       } else {
//         // 🔥 Profile document nai hai → kam se kam FirebaseAuth ka email show karwao
//         authController.emailController.text =
//             FirebaseAuth.instance.currentUser?.email ?? "";
//       }
//     } catch (e) {
//       ShowMessage.errorMessage("Error fetching profile: ${e.toString()}");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   deleteProfile()async{
//     try{
//       isDelete.value = true;
//       await FirebaseFirestore.instance.collection("users").doc(getUid()).delete();
//
//       authController.userController.clear();
//       ageController.clear();
//       genderController.clear();
//
//       ShowMessage.successMessage("Profile deleted successfully ");
//     }catch(e){
//       ShowMessage.errorMessage("Error: ${e.toString()}");
//     }finally{
//       isDelete.value = false;
//     }
//   }
//
//
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student/Controllers/AuthController/authcontroller.dart';
import 'package:student/Models/EnrollModel/enrollmodel.dart';
import 'package:student/Models/SubjectModel/subjectmodel.dart';
import 'package:student/Widgets/ShowMessage/showmessage.dart';

class StudentController extends GetxController {
  TextEditingController subjectController = TextEditingController();
  TextEditingController subjectIdController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController trackIdController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();


  var isLoading = false.obs;
  var isLogin = false.obs;
  var isDelete = false.obs;
  var currentIndex = 0.obs;
  var age = " ".obs;
  var gender = " ".obs;
  var enrollList = <EnrollModel>[].obs;
  var subjectList = <SubjectModel>[].obs;

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration.zero, () {
      fetchSubject();
    });
  }

  getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  changeTab(int index){
    currentIndex.value = index;
  }


  fetchSubject() async {
    try {
      isLoading.value = true;
      var snapshot = await FirebaseFirestore.instance
          .collection("subjectForm")
          .get();

      subjectList.clear();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        subjectList.add(
          SubjectModel(
            subject: data["subjectName"] ?? "",
            id: doc.id,
            subjectId: data["subjectId"] ?? "",
            duration: data["duration"] ?? "",
            classTime: data["classTime"] ?? "",
            registration: data["registration"] ?? "",
            teacher: data["teacherName"] ?? "",
          ),
        );
      }
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  fetchEnrollments() async {
    try {
      isLoading.value = true;
      enrollList.clear();
      subjectList.clear(); // optional, agar enrolled subjects ko subjectList me show karna hai

      var subjectsSnapshot = await FirebaseFirestore.instance.collection("subjectForm").get();

      for (var subjectDoc in subjectsSnapshot.docs) {
        // Check if current user is enrolled in this subject
        var enrollSnapshot = await subjectDoc.reference
            .collection("enrollForm")
            .doc(getUid())
            .get();

        if (enrollSnapshot.exists) {
          var data = enrollSnapshot.data() as Map<String, dynamic>;
          if (data['status'] == "Approved") {
            // ✅ Add subject to enrolled list
            subjectList.add(
              SubjectModel(
                subject: subjectDoc['subjectName'] ?? '',
                id: subjectDoc.id,
                subjectId: subjectDoc['subjectId'] ?? '',
                duration: subjectDoc['duration'] ?? '',
                classTime: subjectDoc['classTime'] ?? '',
                registration: subjectDoc['registration'] ?? '',
                teacher: subjectDoc['teacherName'] ?? '',
              ),
            );
          }
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print("Error fetching enrolled subjects: $e");
    }
  }

  submitEnroll(SubjectModel subject) async {
    try {
      isLoading.value = true;
      if (subjectController.text.isEmpty ||
          authController.userController.text.isEmpty ||
          fatherNameController.text.isEmpty ||
          trackIdController.text.isEmpty ||
          transactionController.text.isEmpty) {
        ShowMessage.errorMessage("All fields are required");
      } else {
        final docRef = await FirebaseFirestore.instance
            .collection("subjectForm").doc(subject.id)
            .collection("enrollForm")
            .doc(getUid());

        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          final status = data["status"] ?? "";

          if (status == "Pending") {
            ShowMessage.errorMessage(
              "Your request is already pending approval.",
            );
            return;
          } else if (status == "Approved") {
            ShowMessage.errorMessage("You are already enrolled");
            return;
          } else if (status == "Rejected") {
            await docRef.set({
              "userName": authController.userController.text,
              "userFatherName": fatherNameController.text,
              "trackId": trackIdController.text,
              "transactionName": transactionController.text,
              "status": "Pending",
              "feesStatus": "notPaid",
            });

            ShowMessage.successMessage("Re-submitted successfully.");
            clearAllFields();
            Get.back();
            return;
          }
        }

        await docRef.set({
          "userName": authController.userController.text,
          "userFatherName": fatherNameController.text,
          "trackId": trackIdController.text,
          "transactionName": transactionController.text,
          "status": "Pending",
          "feesStatus": "notPaid",
          "submittedAt": FieldValue.serverTimestamp(),
          "userEmail": FirebaseAuth.instance.currentUser!.email,

        });
        enrollList.add(
          EnrollModel(
            name: authController.userController.text,
            id: subject.id,
            fatherName: fatherNameController.text,
            trackId: trackIdController.text,
            transaction: transactionController.text,
            status: "Pending",
            feesStatus: "notPaid",
          ),
        );
        ShowMessage.successMessage("Enroll Successfully");
        clearAllFields();
        Get.back();
      }
    } catch (e) {
      ShowMessage.errorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  clearAllFields() {
    authController.userController.clear();
    fatherNameController.clear();
    trackIdController.clear();
    transactionController.clear();
  }


  // ✅ Fee Submit Function
  // Future<void> submitFee(SubjectModel subject) async {
  //   if (authController.userController.text.isEmpty ||
  //       fatherNameController.text.isEmpty ||
  //       accountHolderController.text.isEmpty ||
  //       trackIdController.text.isEmpty ||
  //       transactionController.text.isEmpty) {
  //     Get.snackbar(
  //       "Error",
  //       "All fields are required",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //
  //     // ✅ Check if a pending request exists for this subject
  //     final docRef = FirebaseFirestore.instance
  //         .collection("subjectForm")
  //         .doc(subject.id)
  //         .collection("feeRequests")
  //         .doc(getUid());
  //
  //     final docSnapshot = await docRef.get();
  //
  //     if (docSnapshot.exists) {
  //       final data = docSnapshot.data() as Map<String, dynamic>;
  //       final status = data["status"] ?? "";
  //
  //       if (status == "Pending") {
  //         Get.snackbar(
  //           "Error",
  //           "You already have a pending fee request for this subject.",
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white,
  //         );
  //         return; // ✅ Stop here
  //       }
  //     }
  //
  //     // ✅ If no pending request, submit fee
  //     await docRef.set({
  //       "userName": authController.userController.text,
  //       "userFatherName": fatherNameController.text,
  //       "subjectId": subject.subjectId, // admin-created subjectId
  //       "accountHolder": accountHolderController.text,
  //       "trackId": trackIdController.text,
  //       "transactionMethod": transactionController.text,
  //       "status": "Pending",
  //       "submittedAt": FieldValue.serverTimestamp(),
  //     });
  //
  //     Get.snackbar(
  //       "Success",
  //       "Fee request submitted successfully",
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //
  //     // Clear fields
  //     authController.userController.clear();
  //     fatherNameController.clear();
  //     accountHolderController.clear();
  //     trackIdController.clear();
  //     transactionController.clear();
  //
  //     Get.back();
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       "Failed to submit fee: $e",
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> submitFee(SubjectModel subject) async {
    if (authController.userController.text.isEmpty ||
        fatherNameController.text.isEmpty ||
        accountHolderController.text.isEmpty ||
        trackIdController.text.isEmpty ||
        transactionController.text.isEmpty ||
        subjectIdController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // ✅ Check if entered Subject ID is valid and enrolled
    bool isValidId = subjectList.any((s) => s.subjectId == subjectIdController.text);
    if (!isValidId) {
      Get.snackbar(
        "Error",
        "Wrong Subject ID or you are not enrolled in this subject",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final docRef = FirebaseFirestore.instance
          .collection("subjectForm")
          .doc(subject.id)
          .collection("feeRequests")
          .doc(getUid());

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final status = data["status"] ?? "";
        if (status == "Pending") {
          Get.snackbar(
            "Error",
            "Fee request already submitted and pending approval",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      await docRef.set({
        "userName": authController.userController.text,
        "userFatherName": fatherNameController.text,
        "subjectId": subjectIdController.text,
        "accountHolder": accountHolderController.text,
        "trackId": trackIdController.text,
        "transactionMethod": transactionController.text,
        "status": "Pending",
        "submittedAt": FieldValue.serverTimestamp(),
        "userEmail": FirebaseAuth.instance.currentUser!.email,
        "userFatherName": fatherNameController.text,
      });

      Get.snackbar(
        "Success",
        "Fee request submitted successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear fields
      fatherNameController.clear();
      accountHolderController.clear();
      trackIdController.clear();
      transactionController.clear();
      subjectIdController.clear();

      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to submit fee: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  insertProfile()async{
    try{
      isLoading.value = true;
      await FirebaseFirestore.instance.collection("users").doc(getUid())
          .set({
        "userName" : authController.userController.text,
        "userEmail" : await FirebaseAuth.instance.currentUser!.email,
        "userAge" : int.tryParse(ageController.text)??0,
        "userGender" : genderController.text,
      });
      ShowMessage.successMessage("Your profile has been updated");
    }catch(e){
      ShowMessage.errorMessage("Error: ${e.toString()}");
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(getUid())
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        // Controllers me data set kar rahe hain
        authController.userController.text = data["userName"] ?? "";
        authController.emailController.text = data["userEmail"] ?? "";
        ageController.text = (data["userAge"] ?? "").toString();
        genderController.text = data["userGender"] ?? "";
      } else {
        // 🔥 Profile document nai hai → kam se kam FirebaseAuth ka email show karwao
        authController.emailController.text =
            FirebaseAuth.instance.currentUser?.email ?? "";
      }
    } catch (e) {
      ShowMessage.errorMessage("Error fetching profile: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  deleteProfile()async{
    try{
      isDelete.value = true;
      await FirebaseFirestore.instance.collection("users").doc(getUid()).delete();

      authController.userController.clear();
      ageController.clear();
      genderController.clear();

      ShowMessage.successMessage("Profile deleted successfully ");
    }catch(e){
      ShowMessage.errorMessage("Error: ${e.toString()}");
    }finally{
      isDelete.value = false;
    }
  }


}
