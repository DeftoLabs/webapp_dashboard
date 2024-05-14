

import 'package:fluro/fluro.dart';

import 'package:web_dashboard/ui/views/login_view.dart';
import 'package:web_dashboard/ui/views/register_view.dart';

class AdminHandlers {

  static Handler login = Handler (
    handlerFunc: (context, params) {
      return const LoginView();
    }
  );

    static Handler register = Handler (
    handlerFunc: (context, params) {
      return const RegisterView();
    }
  );

}