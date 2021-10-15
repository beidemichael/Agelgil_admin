import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Loungess {
  String phone;
  String loungeUid;
  String documentUid;
  Loungess({this.loungeUid, this.documentUid, this.phone});
}

class Controller {
  String documentId;
  double deliveryFee;
  double sFStartsAt;
  double serviceCharge;
  bool referralCodeOrder;
  bool referralCodeLogin;
  Controller(
      {this.documentId,
      this.deliveryFee,
      this.sFStartsAt,
      this.serviceCharge,
      this.referralCodeLogin,
      this.referralCodeOrder});
}

class UserAuth {
  final String uid;
  UserAuth({this.uid});
}

class Lounges {
  List category;
  String name;
  String id;
  String images;
  double longitude;
  double latitude;
  String lounge;
  String documentId;
  bool active;
  bool weAreOpen;
  double deliveryRadius;
  bool eatThereAvailable;
  bool verification;
  Lounges({
    this.name,
    this.images,
    this.id,
    this.latitude,
    this.longitude,
    this.category,
    this.lounge,
    this.documentId,
    this.active,
    this.weAreOpen,
    this.deliveryRadius,
    this.eatThereAvailable,
    this.verification,
  });
}

class CarrierOrders {
  List food;
  List price;
  List quantity;
  double total;
  String loungeName;
  var created;
  bool isTaken;
  String orderCode;
  String userName;
  String userPhone;
  String carrierName;
  String carrierphone;
  String carrierUserUid;
  String documentId;
  double longitude;
  double latitude;
  String information;
  var delivered;

  CarrierOrders(
      {this.food,
      this.price,
      this.quantity,
      this.total,
      this.loungeName,
      this.created,
      this.isTaken,
      this.orderCode,
      this.userName,
      this.userPhone,
      this.carrierName,
      this.carrierUserUid,
      this.carrierphone,
      this.documentId,
      this.latitude,
      this.longitude,
      this.information,
      this.delivered});
}

class Orders {
  List food;
  List price;
  List quantity;
  num subTotal;
  int tip;
  num serviceCharge;
  double deliveryFee;
  String loungeName;
  var created;
  bool isTaken;
  String orderCode;
  String loungeOrderNumber;
  String userName;
  String userPhone;
  String carrierName;
  String carrierphone;
  String carrierUserUid;
  String documentId;
  String information;
  var delivered;
  String loungeId;
  double longitude;
  double latitude;
  double loungeLongitude;
  double loungeLatitude;
  String userToken;
  double distance;

  bool isPaid;

  Orders({
    this.food,
    this.price,
    this.quantity,
    this.loungeName,
    this.created,
    this.isTaken,
    this.orderCode,
    this.userName,
    this.userPhone,
    this.carrierName,
    this.carrierUserUid,
    this.carrierphone,
    this.documentId,
    this.loungeOrderNumber,
    this.serviceCharge,
    this.deliveryFee,
    this.subTotal,
    this.tip,
    this.information,
    this.delivered,
    this.distance,
    this.isPaid,
    this.latitude,
    this.longitude,
    this.loungeId,
    this.loungeLatitude,
    this.loungeLongitude,
    this.userToken
  });
}

class Cart3Items {
  String foodNameL;
  double foodPriceL;
  int foodQuantityL;
  Cart3Items({this.foodNameL, this.foodPriceL, this.foodQuantityL});
}

class Menu with ChangeNotifier {
  String name;
  double price;
  String id;
  String images;
  String category;
  bool isAvaliable;
  String documentId;
  Menu(
      {this.name,
      this.images,
      this.id,
      this.category,
      this.price,
      this.isAvaliable,
      this.documentId});
}

class UserUid {
  final String uid;
  UserUid({this.uid});
}

class UserInfo {
  String userName;
  String userPhone;
  String userPic;
  String documentUid;
  var created;
  UserInfo({
    this.userName,
    this.userPhone,
    this.userPic,
    this.documentUid,
    this.created,
  });
}

class Carriers {
  String carrierName;
  String carrierPhone;
  bool verified;
  String carrierUid;
  String loungeUid;
  String documentUid;

  Carriers(
      {this.carrierName,
      this.carrierPhone,
      this.carrierUid,
      this.loungeUid,
      this.verified,
      this.documentUid});
}
