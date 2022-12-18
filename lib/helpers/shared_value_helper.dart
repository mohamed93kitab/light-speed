import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: false, // initial value
  key: "is_logged_in", // disk storage key for shared_preferences
);

final SharedValue<String> token = SharedValue(
  value: "", // initial value
  key: "token", // disk storage key for shared_preferences
);
final SharedValue<int> user_id = SharedValue(
  value: 0, // initial value
  key: "user_id", // disk storage key for shared_preferences
);

final SharedValue<String> avatar = SharedValue(
  value: "", // initial value
  key: "avatar", // disk storage key for shared_preferences
);

final SharedValue<String> user_name = SharedValue(
  value: "", // initial value
  key: "user_name", // disk storage key for shared_preferences
);

final SharedValue<String> user_email = SharedValue(
  value: "", // initial value
  key: "user_email", // disk storage key for shared_preferences
);

final SharedValue<String> user_phone = SharedValue(
  value: "", // initial value
  key: "user_phone", // disk storage key for shared_preferences
);