import '../../base/color_data.dart';
import '../models/model_address.dart';
import '../models/model_booking.dart';
import '../models/model_card.dart';
import '../models/model_cart.dart';
import '../models/model_category.dart';
import '../models/model_color.dart';
import '../models/model_country.dart';
import '../models/model_intro.dart';
import '../models/model_notification.dart';
import '../models/model_other.dart';
import '../models/model_popular_service.dart';
import '../models/model_salon.dart';

class DataFile {
  static List<ModelIntro> introList = [
    ModelIntro(
        1,
        "Best Services For Your Home ",
        "Homecare is health care provided by a professional caregiver in the individual home.",
        "intro1.png",
        intro1Color),
    ModelIntro(
        2,
        "Care Your Home With Us",
        "Some nurses travel to multiple homes per day and provide short visits to multiple patients.",
        "intro2.png",
        intro2Color),
    ModelIntro(
        3,
        "Using Smart Gadgets ",
        "Homecare is also known as domiciliary care, social care or in-home care.",
        "intro3.png",
        intro3Color),
  ];

  static List<ModelCountry> countryList = [
    ModelCountry("vietnam.png", "Việt Nam (VN)", "+84"),
  ];

  static List<ModelCategory> categoryList = [
    ModelCategory("cleaning.svg", "Vệ sinh"),
    ModelCategory("wrench.svg", "Sữa chữa"),
    ModelCategory("paint_roller.svg", "Bảo trì"),
    // ModelCategory("sloon.svg", "Salon"),
    // ModelCategory("iron.svg", "Ironing"),
    // ModelCategory("laundry.svg", "Washing"),
    // ModelCategory("perfume.svg", "Beauty"),
    // ModelCategory("car_toy.svg", "Vehicle Wash"),
    // ModelCategory("pipe.svg", "Plumbing"),
    // ModelCategory("health_insurance.svg", "Health"),
    // ModelCategory("grill.svg", "Cooking Shef"),
    // ModelCategory("pipe.svg", "Plumbing"),
    // ModelCategory("dump_truck.svg", "Transport"),
    // ModelCategory("watering_plants.svg", "Gardening"),
    // ModelCategory("plastic_bin.svg", "Trashing")
  ];

  static List<ModelSalon> salonProductList = [
    ModelSalon("hair1.png", "Haircut", "Men’s Haircut", "4.5", 10.00, 0),
    ModelSalon("shaving.png", "Shaving", "Men’s Beard Shave", "4.4", 8.00, 0),
    ModelSalon("facecare.png", "Face Care", "Men’s Face Care", "4.4", 12.00, 0),
    ModelSalon(
        "haircolor.png", "Hair Color", "Men’s Hair Color", "4.4", 8.00, 0),
  ];

  static List<ModelColor> hairColorList = [
    ModelColor("blackhair.png", "Black", "Black Hair Color", "4.5", 6.00, 0),
    ModelColor("brownhair.png", "Brown", "Brown Hair Color", "4.5", 10.00, 0),
  ];

  static Map<String, ModelCart> cartList = {};

  static List<ModelOther> otherProductList = [
    ModelOther("beard_shape.png", "Beard Shaping", 13.00, 0),
    ModelOther("head_massage.png", "Head Massage", 16.00, 0),
  ];

  static List<String> timeList = [
    "08:00 - 10:00",
    "10:00 - 12:00",
    "13:00 - 15:00",
    "15:00 - 17:00",
  ];

  static List<ModelCard> cardList = [
    ModelCard("paypal.svg", "Paypal", "xxxx xxxx xxxx 5416"),
    ModelCard("mastercard.svg", "Master Card", "xxxx xxxx xxxx 8624"),
    ModelCard("visa.svg", "Visa", "xxxx xxxx xxxx 4565")
  ];

  static List<ModelBooking> bookingList = [
    ModelBooking("booking1.png", "Cleaning", "23 April, 2022, 11:00 am", "4.3",
        20.00, "By Mendy Wilson", "Active", 0xFFEEFCF0, success),
    ModelBooking("booking2.png", "Painting", "22 April, 2022, 08:00 am", "4.2",
        50.00, "By Jenny Winget", "Completed", 0xFFF0F8FF, completed),
    ModelBooking("booking3.png", "Cleaning", "20 April, 2022, 06:00 pm", "4.3",
        18.00, "By Jacob Jones", "Cancelled", 0xFFFFF3F3, error),
    ModelBooking("booking4.png", "Repairing", "20 April, 2022, 06:00 pm", "4.3",
        18.00, "By Jacob Jones", "Completed", 0xFFF0F8FF, completed),
  ];
  static List<ModelBooking> scheduleList = [
    ModelBooking("booking1.png", "Cleaning", "23 April, 2022, 11:00 am", "4.3",
        20.00, "By Mendy Wilson", "Active", 0xFFEEFCF0, success),
    ModelBooking("booking2.png", "Painting", "22 April, 2022, 08:00 am", "4.2",
        50.00, "By Jenny Winget", "Completed", 0xFFF0F8FF, completed),
  ];

  static List<ModelAddress> addressList = [
    ModelAddress("Alena Gomez",
        "3891 Ranchview Dr. Richardson, California 62639", "(907) 555-0101"),
    ModelAddress("Romeo chaless", "4140 Parker Rd. Allentown, New Mexico 31134",
        "(907) 555-0101"),
  ];

  static List<ModelNotification> notificationList = [
    ModelNotification(
        "Lorem ipsum dolor",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "1 h ago",
        "Today"),
    ModelNotification(
        "Lorem ipsum dolor",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "1 h ago",
        "Today"),
    ModelNotification(
        "Lorem ipsum dolor",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "03:00 pm",
        "Yesterday"),
    ModelNotification(
        "Lorem ipsum dolor",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus congue rutrum. Morbi malesuada eleifend eros vel malesuada. Duis sed molestie purus.",
        "01:00 pm",
        "Yesterday"),
  ];

  static List<String> searchList = [];

  static List<String> popularSearchList = [
    "Sữa chữa",
    "Dọn dẹp",
    "painting",
    "salon",
    "health",
    "transport",
    "gardening",
    "beauty",
    "trashing",
    "plumbing"
  ];

  static List<ModelPopularService> popularServiceList = [
    ModelPopularService("wallpaper.png", "Sơn nhà", "Painter"),
    ModelPopularService("barber.png", "Sữa bàn", "Barber"),
    ModelPopularService("wallpaper.png", "Wall Painting", "Painter"),
    ModelPopularService("barber.png", "Salon For Men", "Barber"),
  ];
}
