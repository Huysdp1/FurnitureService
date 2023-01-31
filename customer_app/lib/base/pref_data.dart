import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.home_service_provider";

  static String introAvailable = "${prefName}isIntroAvailable";
  static String isLoggedIn = "${prefName}isLoggedIn";
  static String getTheme = "${prefName}isSelectedTheme";
  static String getDefaultCode = "${prefName}code";
  static String getDefaultCountry = "${prefName}country";
  static String defIndexVal = "${prefName}index";
  static String cusIdVal = "${prefName}customerId";
  static String accIdVal = "${prefName}accountId";
  static String modelOrder = "${prefName}orderModel";
  static String modelAccount = "${prefName}accountModel";
  static String modelCategory = "${prefName}categoryModel";
  static String modelAddress = "${prefName}addressModel";
  static String defCountryName = "vietnam.png";
  static String apiUrl = 'http://furniturecompany-001-site1.btempurl.com';
  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static setLogIn(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(isLoggedIn, avail);
  }


  static setOrderModel(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(modelOrder, avail);
  }

  static setAccountModel(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(modelAccount, avail);
  }

  static setCategoryModel(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(modelCategory, avail);
  }
  static setAddressModel(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(modelAddress, avail);
  }

  static setDefIndex(int avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setInt(defIndexVal, avail);
  }

  static setCusId(int avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setInt(cusIdVal, avail);
  }
  static setAccId(int avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setInt(accIdVal, avail);
  }
  static setDefCode(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(getDefaultCode, avail);
  }

  static setCountryName(String avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setString(getDefaultCountry, avail);
  }

  static Future<bool> isLogIn() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isIntroAvailable = preferences.getBool(isLoggedIn) ?? false;
    return isIntroAvailable;
  }

  static Future<String> getCategoryModel() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(modelCategory) ?? "";
    return isIntroAvailable;
  }
  static Future<String> getAddressModel() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(modelAddress) ?? "";
    return isIntroAvailable;
  }

  static Future<String> getAccountModel() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(modelAccount) ?? "";
    return isIntroAvailable;
  }

  static Future<String> getOrderModel() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(modelOrder) ?? "";
    return isIntroAvailable;
  }

  static Future<int> getDefIndex() async {
    SharedPreferences preferences = await getPrefInstance();
    int isIntroAvailable = preferences.getInt(defIndexVal) ?? 0;
    return isIntroAvailable;
  }

  static Future<int> getCusId() async {
    SharedPreferences preferences = await getPrefInstance();
    int isIntroAvailable = preferences.getInt(cusIdVal) ?? -1;
    return isIntroAvailable;
  }
  static Future<int> getAccId() async {
    SharedPreferences preferences = await getPrefInstance();
    int isIntroAvailable = preferences.getInt(accIdVal) ?? -1;
    return isIntroAvailable;
  }
  static Future<String> getDefCode() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable = preferences.getString(getDefaultCode) ?? "+84";
    return isIntroAvailable;
  }

  static Future<String> getDefCountry() async {
    SharedPreferences preferences = await getPrefInstance();
    String isIntroAvailable =
        preferences.getString(getDefaultCountry) ?? defCountryName;
    return isIntroAvailable;
  }
}
