import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../data/model/event_model/event_model.dart';
import '../../../data/model/race_model/race_model.dart';
import '../../../data/model/race_with_event/race_with_event_model.dart';

class EventDashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final events = <EventModel>[].obs;
  final isLoading = false.obs;
  final error = Rxn<String>();


  @override
  void onInit() {
    // TODO: implement onInit
    fetchAllEvents();
    fetchAllRacesWithEvents();
    super.onInit();
  }


  Future<void> fetchAllEvents() async {
    try {
      isLoading(true);
      events.clear();
      error(null);

      final allEvents = await getAllEvents();
      events.assignAll(allEvents.map((doc) => EventModel.fromFirestore(doc)));

    } catch (e) {
      error('Failed to load events: $e');
      Get.snackbar('Error', 'Failed to load events',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }


  Future<List<QueryDocumentSnapshot>> getAllEvents() async {
    try {
      final racesSnapshot = await _firestore.collection('race').get();
      List<QueryDocumentSnapshot> allEvents = [];

      await Future.forEach(racesSnapshot.docs, (raceDoc) async {
        final eventsSnapshot = await _firestore
            .collection('race')
            .doc(raceDoc.id)
            .collection('events')
            .orderBy('createdAt', descending: true)
            .get();

        allEvents.addAll(eventsSnapshot.docs);
      });

      // তারিখ অনুযায়ী সর্টিং
      allEvents.sort((a, b) {
        final aDate = (a.data() as Map<String, dynamic>)['createdAt'] as Timestamp;
        final bDate = (b.data() as Map<String, dynamic>)['createdAt'] as Timestamp;
        return bDate.compareTo(aDate);
      });

      return allEvents;
    } catch (e) {
      throw Exception('Failed to get all events');
    }
  }


  //get all race and all event
  final RxList<RaceWithEvents> allRacesWithEvents = <RaceWithEvents>[].obs;

  Future<void> fetchAllRacesWithEvents() async {
    try {
      isLoading(true);

      // Step 1: Fetch all races
      final racesSnapshot = await _firestore.collection('race').get();
      final races = racesSnapshot.docs.map((doc) => RaceModel.fromFirestore(doc)).toList();

      // Step 2: Clear previous data
      allRacesWithEvents.clear();

      // Step 3: Fetch events for each race in parallel
      final results = await Future.wait(
        races.map((race) async {
          try {
            final eventsSnapshot = await _firestore
                .collection('race')
                .doc(race.id)
                .collection('events')
                .get();

            final events = eventsSnapshot.docs
                .map((doc) => EventModel.fromFirestore(doc))
                .toList();

            events.sort((a, b) => b.date.compareTo(a.date));

            return RaceWithEvents(race: race, events: events);
          } catch (e) {
            Get.log('Error loading events for race ${race.id}: $e');
            return RaceWithEvents(race: race, events: []);
          }
        }),
      );

      // Step 4: Add to controller's list
      allRacesWithEvents.addAll(results);

      // Step 5: Sort races by date
      allRacesWithEvents.sort((a, b) => b.race.createdAt.compareTo(a.race.createdAt));

    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }








}