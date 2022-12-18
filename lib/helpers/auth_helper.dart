import 'package:flash/helpers/shared_value_helper.dart';
import '../repositories/login_repository.dart';

class AuthHelper {
  setUserData(loginResponse) {
    if (loginResponse.status == true) {
      is_logged_in.$ = true;
      is_logged_in.save();
      user_id.$ = loginResponse.data.id;
      user_id.save();
      token.$ = loginResponse.data.token;
      token.save();
      user_name.$ = loginResponse.data.name;
      user_name.save();
      user_email.$ = loginResponse.data.email;
      user_email.save();
      user_phone.$ = loginResponse.data.phone;
      user_phone.save();
      avatar.$ = loginResponse.data.avatar;
      avatar.save();
    }
  }

  clearUserData() {
    is_logged_in.$ = false;
    is_logged_in.save();
    user_id.$ = 0;
    user_id.save();
    token.$ = "";
    token.save();
    user_name.$ = "";
    user_name.save();
    user_email.$ = "";
    user_email.save();
    user_phone.$ = "";
    user_phone.save();
    avatar.$ = "";
    avatar.save();
  }


}
