import 'package:get/get.dart';

import '../modules/bottom_navigation_bar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../modules/create_event_dashboard/bindings/create_event_dashboard_binding.dart';
import '../modules/create_event_dashboard/views/create_event_dashboard_view.dart';
import '../modules/edit_event_dashboard/bindings/edit_event_dashboard_binding.dart';
import '../modules/edit_event_dashboard/views/edit_event_dashboard_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/event_view.dart';
import '../modules/event_dashboard/bindings/event_dashboard_binding.dart';
import '../modules/event_dashboard/views/event_dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/racing_details/bindings/racing_details_binding.dart';
import '../modules/racing_details/views/racing_details_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNUP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => const EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.RACING_DETAILS,
      page: () => const RacingDetailsView(),
      binding: RacingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION_BAR,
      page: () => const BottomNavigationBarView(),
      binding: BottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.EVENT_DASHBOARD,
      page: () => const EventDashboardView(),
      binding: EventDashboardBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EVENT_DASHBOARD,
      page: () => const EditEventDashboardView(),
      binding: EditEventDashboardBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EVENT_DASHBOARD,
      page: () => const CreateEventDashboardView(),
      binding: CreateEventDashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
  ];
}
