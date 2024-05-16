import 'package:fluro/fluro.dart';
import 'package:web_dashboard/ui/views/dashboard_view.dart';



class DashboardHandlers {

  static Handler dashboard = Handler (
    handlerFunc: (context, params) {
      return const DashboardView();
    }
  );


}