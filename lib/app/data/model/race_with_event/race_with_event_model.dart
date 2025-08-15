import '../event_model/event_model.dart';
import '../race_model/race_model.dart';

class RaceWithEvents {
  final RaceModel race;
  final List<EventModel> events;

  RaceWithEvents({
    required this.race,
    required this.events,
  });
}