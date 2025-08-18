import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ReportAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final RxList<Map<String, dynamic>> reportRaces = <Map<String, dynamic>>[].obs;

  Future<void> fetchRaceReport() async {
    try {
      final querySnapshot = await _firestore.collection('report').get();
      reportRaces.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: ${e.toString()}');
    }
  }

  void setupRealTimeUpdates() {
    _firestore.collection('report').snapshots().listen((snapshot) {
      reportRaces.assignAll(snapshot.docs.map((doc) => doc.data()));
    });
  }


  @override
  void onInit() {
    fetchRaceReport();
    super.onInit();
  }
}
