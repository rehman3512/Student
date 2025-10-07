import 'package:get/get.dart';
import 'package:student/Views/AuthViews/SigninView/signinview.dart';
import 'package:student/Views/AuthViews/SignupView/signupview.dart';
import 'package:student/Views/HomeView/EnrolledSubjects/enrolledsubjects.dart';
import 'package:student/Views/HomeView/FeeSubmit/feesubmit.dart';
import 'package:student/Views/HomeView/ProfileView/profileview.dart';
import 'package:student/Views/HomeView/homeview.dart';
import 'package:student/Views/StartingViews/SplashView/splashview.dart';
import 'package:student/Widgets/BottomBar/bottombar.dart';
import 'package:student/Widgets/EnrollForm/enrollform.dart';
import 'package:student/Widgets/SubjectDetail/subjectdetail.dart';

class AppRoutes{
  static String splashScreen = "/";
  static String signupScreen = "/SignupView";
  static String signinScreen = "/SigninView";
  static String homeScreen = "/HomeView";
  static String subjectDetail = "/SubjectDetail";
  static String enrollForm = "/EnrollForm";
  static String bottomBar = "/BottomBar";
  static String profileScreen = "/ProfileView";
  static String enrolledSubjects = "/EnrolledSubjects";
  static String feeSubmit = "/FeeSubmit";

  static final routes = [
    GetPage(name: splashScreen, page: ()=> SplashView()),
    GetPage(name: signupScreen, page: ()=> SignupView()),
    GetPage(name: signinScreen, page: ()=> SigninView()),
    GetPage(name: homeScreen, page: ()=> HomeView()),
    GetPage(name: subjectDetail, page: ()=> SubjectDetail()),
    GetPage(name: enrollForm, page: ()=> EnrollForm()),
    GetPage(name: bottomBar, page: ()=> BottomBar()),
    GetPage(name: profileScreen, page: ()=> ProfileView()),
    GetPage(name: enrolledSubjects, page: ()=> EnrolledSubjects()),
    GetPage(name: feeSubmit, page: ()=> FeeSubmit()),

  ];

}