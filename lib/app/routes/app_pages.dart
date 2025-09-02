import 'package:get/get.dart';

import '../modules/bottom_navigation_bar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/bottom_navigation_bar/views/bottom_navigation_bar_view.dart';
import '../modules/create_event_dashboard/bindings/create_event_dashboard_binding.dart';
import '../modules/create_event_dashboard/views/create_event_dashboard_view.dart';
import '../modules/create_race_admin/bindings/create_race_admin_binding.dart';
import '../modules/create_race_admin/views/create_race_admin_view.dart';
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
import '../modules/login_dashboard/bindings/login_dashboard_binding.dart';
import '../modules/login_dashboard/views/login_dashboard_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notify_dashboard/bindings/notify_dashboard_binding.dart';
import '../modules/notify_dashboard/views/notify_dashboard_view.dart';
import '../modules/race_admin/bindings/race_admin_binding.dart';
import '../modules/race_admin/views/race_admin_view.dart';
import '../modules/racing_details/bindings/racing_details_binding.dart';
import '../modules/racing_details/views/racing_details_view.dart';
import '../modules/report_admin/bindings/report_admin_binding.dart';
import '../modules/report_admin/views/report_admin_view.dart';
import '../modules/request_admin/bindings/request_admin_binding.dart';
import '../modules/request_admin/views/request_admin_view.dart';
import '../modules/request_race/bindings/request_race_binding.dart';
import '../modules/request_race/views/request_race_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/single_race_event_dashboard/bindings/single_race_event_dashboard_binding.dart';
import '../modules/single_race_event_dashboard/views/single_race_event_dashboard_view.dart';
import '../modules/update_race_dashboard/bindings/update_race_dashboard_binding.dart';
import '../modules/update_race_dashboard/views/update_race_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNUP;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
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
      name: "${_Paths.RACING_DETAILS}/:raceId/:raceName",
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
      name: "${_Paths.EDIT_EVENT_DASHBOARD}/:raceId/:eventId",
      page: () => const EditEventDashboardView(),
      binding: EditEventDashboardBinding(),
    ),
    GetPage(
      name: "${_Paths.CREATE_EVENT_DASHBOARD}/:raceId",
      page: () {
        return CreateEventDashboardView();
      },
      binding: CreateEventDashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RACE_ADMIN,
      page: () => const RaceAdminView(),
      binding: RaceAdminBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_RACE_ADMIN,
      page: () => const CreateRaceAdminView(),
      binding: CreateRaceAdminBinding(),
    ),
    GetPage(
      name: "${_Paths.SINGLE_RACE_EVENT_DASHBOARD}/:raceId",
      page: () {
        return SingleRaceEventDashboardView();
      },
      binding: SingleRaceEventDashboardBinding(),
    ),
    GetPage(
      name: "${_Paths.UPDATE_RACE_DASHBOARD}/:raceId",
      page: () => UpdateRaceDashboardView(),
      binding: UpdateRaceDashboardBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_RACE,
      page: () => RequestRaceView(),
      binding: RequestRaceBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_ADMIN,
      page: () => RequestAdminView(),
      binding: RequestAdminBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_ADMIN,
      page: () => ReportAdminView(),
      binding: ReportAdminBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_DASHBOARD,
      page: () => const LoginDashboardView(),
      binding: LoginDashboardBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFY_DASHBOARD,
      page: () => const NotifyDashboardView(),
      binding: NotifyDashboardBinding(),
    ),
  ];
}
