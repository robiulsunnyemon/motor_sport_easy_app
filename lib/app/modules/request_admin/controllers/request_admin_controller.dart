import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RequestAdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final RxList<Map<String, dynamic>> raceRequests = <Map<String, dynamic>>[].obs;

  Future<void> fetchRaceRequests() async {
    try {
      final querySnapshot = await _firestore.collection('request_race').get();
      raceRequests.assignAll(querySnapshot.docs.map((doc) => doc.data()));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: ${e.toString()}');
    }
  }

  void setupRealTimeUpdates() {
    _firestore.collection('request_race').snapshots().listen((snapshot) {
      raceRequests.assignAll(snapshot.docs.map((doc) => doc.data()));
    });
  }


  @override
  void onInit() {
    fetchRaceRequests();
    super.onInit();
  }

}
