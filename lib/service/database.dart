import 'package:agelgil_admin_end/model/Models.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class DatabaseService {
  String phoneNumber;
  String userUid;
  String userPhoneNumber;
  String loungeId;
  String id;
  int index;

  DatabaseService(
      {this.phoneNumber,
      this.userPhoneNumber,
      this.userUid,
      this.loungeId,
      this.id,
      this.index});
  List category = [];
//collecton reference
  final CollectionReference loungesCollection =
      FirebaseFirestore.instance.collection('Lounges');
  final CollectionReference tempLoungesCollection =
      FirebaseFirestore.instance.collection('TempLounges');
  final CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('Menu');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference carrierUsersCollection =
      FirebaseFirestore.instance.collection('Carriers');
  final CollectionReference controllerCollection =
      FirebaseFirestore.instance.collection('Controller');
  final CollectionReference broadcastCollection =
      FirebaseFirestore.instance.collection('Broadcasts');

  //******************************************************************************************** */

  List<Loungess> _tempLoungesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Loungess(
        phone: doc.data()['phoneNumber'] ?? '',
        loungeUid: doc.data()['loungeUid'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  //get lounges stream
  Stream<List<Loungess>> get tempLounges {
    return tempLoungesCollection
        .where('phoneNumber', isEqualTo: phoneNumber)
        .snapshots()
        .map(_tempLoungesListFromSnapshot);
  }

  Future addNewLounge(
    String loungeUid,
    String loungePhone,
    GeoFirePoint myLocation,
    List<String> category,
  ) async {
    loungesCollection.where('id', isEqualTo: loungeUid).get().then((document) {
      if (document.docs.isEmpty) {
        return loungesCollection
            .doc(loungeUid)
            .set({
              'id': loungeUid,
              'loungePhone': loungePhone,
              'Location': myLocation.data,
              'created': Timestamp.now(),
              'name': null,
              'image': null,
              'category': category,
              'lounge': 'eatery',
              'active': true,
              'weAreOpen': true,
              'rating': 0,
              'deliveryRadius': 25000,
              'eatThere': false
            })
            .then((value) => print('written'))
            .catchError((error) => print("Failed to add Lounge: $error"));
      }
    });
  }

  List<Lounges> _loungesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lounges(
        name: doc.data()['name'] ?? '',
        images: doc.data()['image'] ?? '',
        id: doc.data()['id'] ?? '',
        longitude: doc.data()['Location']['geopoint'].longitude ?? 0.0,
        latitude: doc.data()['Location']['geopoint'].latitude ?? 0.0,
        category: doc.data()['category'] ?? [],
        lounge: doc.data()['lounge'] ?? '',
        active: doc.data()['active'] ?? false,
        weAreOpen: doc.data()['weAreOpen'] ?? false,
        deliveryRadius: doc.data()['deliveryRadius'].toDouble() ?? 0.0,
        eatThereAvailable: doc.data()['eatThere'] ?? false,
        verification: doc.data()['needsVerification'] ?? false,
        documentId: doc.reference.id ?? '',
      );
    }).toList();
  }

  Stream<List<Lounges>> get lounges {
    return loungesCollection
        .where('id', isEqualTo: userUid)
        .snapshots()
        .map(_loungesListFromSnapshot);
  }

  Stream<List<Lounges>> get lounge {
    return loungesCollection
        .where('id', isEqualTo: userUid)
        .snapshots()
        .map(_loungesListFromSnapshot);
  }

  //*************************************Carrier User related******************************************* */
  //*************************************Carrier User write******************************************* */
  Future newCarrierUserData(
    String profilePic,
    String name,
    String userUid,
  ) async {
    carrierUsersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((document) {
      if (document.docs.isEmpty) {
        return carrierUsersCollection
            .doc(userUid)
            .set({
              'created': Timestamp.now(),
              'profilePic': profilePic,
              'name': name,
              'phoneNumber': userPhoneNumber,
              'userUid': userUid
            })
            .then((value) => print('checked from data base'))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  Future updateCurrentUser(
    String profilePic,
    String name,
    String userPhone,
  ) async {
    return await carrierUsersCollection.doc(userUid).set({
      'profilePic': profilePic,
      'name': name,
      'phoneNumber': userPhone,
      'userUid': userUid
    });
  }

  Future userInfo() async {
    carrierUsersCollection
        .where('userUid', isEqualTo: userUid)
        .get()
        .then((docs) async {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          return UserInfo(
            userName: docs.docs[i].get('name') ?? '',
            userPhone: docs.docs[i].get('phoneNumber') ?? '',
            userPic: docs.docs[i].get('profilePic') ?? '',
          );
        }
      }
    });
  }

  Stream<List<UserInfo>> get allUsers {
    return usersCollection
        .orderBy('created', descending: true)
        .snapshots()
        .map(_userListFromSnapshot);
  }

  List<UserInfo> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInfo(
        userPhone: doc.data()['phoneNumber'] ?? '',
        userPic: doc.data()['profilePic'] ?? '',
        userName: doc.data()['name'] ?? '',
        created: doc.data()['created'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  Stream<List<Controller>> get allController {
    return controllerCollection.snapshots().map(_controllerListFromSnapshot);
  }

  List<Controller> _controllerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Controller(
        deliveryFee: doc.data()['DeliveryFee'].toDouble() ?? 0.0,
        sFStartsAt: doc.data()['SFStartsAt'].toDouble() ?? 0.0,
        serviceCharge: doc.data()['ServiceCharge'].toDouble() ?? 0.0,
        referralCodeLogin: doc.data()['referralCodeLogin'] ?? false,
        referralCodeOrder: doc.data()['referralCodeOrder'] ?? false,
        documentId: doc.reference.id ?? '',
      );
    }).toList();
  }

  Future updateController(
    double deliveryFee,
    double sFStartsAt,
    double serviceCharge,
    bool referralCodeOrder,
    bool referralCodeLogin,
  ) async {
    controllerCollection.doc(id).update({
      'DeliveryFee': deliveryFee,
      'SFStartsAt': sFStartsAt,
      'ServiceCharge': serviceCharge,
      'referralCodeLogin': referralCodeLogin,
      'referralCodeOrder': referralCodeOrder,
    });
  }

  Future postBroadcast(
    String title,
    String body,
    String type,
    String userToken,
  ) async {
    broadcastCollection.add({
      'Title': title,
      'Body': body,
      'Type': type,
      'created': Timestamp.now(),
      'UserToken':userToken,
    });
  }

  Future updateCarrierUserToCarrierLounge(
    String loungeUid,
  ) async {
    carrierUsersCollection.doc(id).update({
      'loungeUid': loungeUid,
    });
  }

  Future removeCarrierFromLounge() async {
    carrierUsersCollection.doc(id).update({
      'loungeUid': null,
    });
  }

  Future unverifyCarrier() async {
    carrierUsersCollection.doc(id).update({
      'verified': false,
    });
  }
   Future unauthorizeCarrier() async {
    carrierUsersCollection.doc(id).update({
      'taker': false,
    });
  }

  Future verifyCarrier() async {
    carrierUsersCollection.doc(id).update({
      'verified': true,
    });
  }

  Future authoriseCarrier() async {
    carrierUsersCollection.doc(id).update({
      'taker': true,
    });
  }

  //*************************************Carrier User write******************************************* */
  //*************************************Carrier User read******************************************* */
  List<Carriers> _verifyNewAdrashListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  //get lounges stream
  Stream<List<Carriers>> get verifyNewAdrash {
    return carrierUsersCollection
        .where('phoneNumber', isEqualTo: phoneNumber)
        .snapshots()
        .map(_verifyNewAdrashListFromSnapshot);
  }

  Stream<List<Orders>> get adrashProgress {
    return orderCollection
        .where('isDelivered', isEqualTo: true)
        .where('isTaken', isEqualTo: true)
        // .where('isPaid', isEqualTo: false)
        .where('carrierUserUid', isEqualTo: userUid)
        .orderBy('created', descending: true)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  Stream<List<Carriers>> get verifiedAdrashed {
    return carrierUsersCollection
        .where('verified', isEqualTo: true)
        .snapshots()
        .map(_verifiedAdrashListFromSnapshot);
  }

  Stream<List<Carriers>> get authorizedAdrashed {
    return carrierUsersCollection
        .where('taker', isEqualTo: true)
        .snapshots()
        .map(_authorizedAdrashListFromSnapshot);
  }

  List<Carriers> _verifiedAdrashListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  List<Carriers> _authorizedAdrashListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  List<Carriers> _carriersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        loungeUid: doc.data()['loungeUid'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  //get lounges stream
  Stream<List<Carriers>> get carriers {
    return carrierUsersCollection
        .where('phoneNumber', isEqualTo: userPhoneNumber)
        .snapshots()
        .map(_carriersListFromSnapshot);
  }

  List<Carriers> _loungeCarriersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        loungeUid: doc.data()['loungeUid'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  //get lounges stream
  Stream<List<Carriers>> get loungeCarriers {
    return carrierUsersCollection
        .where('loungeUid', isEqualTo: loungeId)
        .snapshots()
        .map(_loungeCarriersListFromSnapshot);
  }

  List<Carriers> _carreirUserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Carriers(
        carrierName: doc.data()['name'] ?? '',
        carrierUid: doc.data()['userUid'] ?? '',
        carrierPhone: doc.data()['phoneNumber'] ?? '',
        loungeUid: doc.data()['loungeUid'] ?? '',
        documentUid: doc.reference.id ?? '',
      );
    }).toList();
  }

  //get lounges stream
  Stream<List<Carriers>> get carrierUser {
    return carrierUsersCollection
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map(_carreirUserListFromSnapshot);
  }

  Future updateCarrierUser(
    String name,
  ) async {
    return await carrierUsersCollection.doc(id).update({
      'name': name,
    });
  }

  //*************************************Carrier User read******************************************* */
  //******************************************Carrier User related************************************************** */

//******************************************menu related************************************************** */
//******************************************menu write************************************************** */
  Future updateMenuItem(
      String name, double price, bool isAvaliable, String newImage) async {
    menuCollection.doc(id).update({
      'name': name,
      'price': price,
      'isAvaliable': isAvaliable,
      'images': newImage,
    });
  }

  Future createNewMenuItem(
    String name,
    double price,
    String id,
    String category,
  ) async {
    menuCollection.add({
      'name': name,
      'price': price,
      'isAvaliable': true,
      'id': id,
      'images': null,
      'category': category,
    });
  }

  Future removeMenu() async {
    return menuCollection.doc(id).delete();
  }

  //******************************************menu write************************************************** */
  //******************************************menu read************************************************** */
  List<Menu> _menuListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Menu(
          name: doc.data()['name'] ?? '',
          id: doc.data()['id'] ?? '',
          price: doc.data()['price'] ?? '',
          images: doc.data()['images'] ?? '',
          category: doc.data()['category'] ?? '',
          isAvaliable: doc.data()['isAvaliable'] ?? '',
          documentId: doc.reference.id ?? '');
    }).toList();
  }

  //menu  stream
  Stream<List<Menu>> get menu {
    return menuCollection
        .where('id', isEqualTo: userUid)
        .snapshots()
        .map(_menuListFromSnapshot);
  }
  //******************************************menu read************************************************** */
//******************************************menu related************************************************** */

  //********************************************Lounge related************************************************ */
  //******************************************Lounge read************************************************** */

  //******************************************Lounge read************************************************** */
  //******************************************Lounge write************************************************** */
  Future newLoungeUserData(
    String userUid,
  ) async {
    tempLoungesCollection
        .where('loungeUid', isEqualTo: userUid)
        .get()
        .then((document) {
      if (document.docs.isEmpty) {
        return tempLoungesCollection
            .doc(userUid)
            .set({
              'phoneNumber': userPhoneNumber,
              'loungeUid': userUid,
              'created': Timestamp.now(),
            })
            .then((value) => print('checked from data base'))
            .catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  Future updateLoungeName(
    String name,
    String newImage,
  ) async {
    loungesCollection.doc(id).update({
      'name': name,
      'image': newImage,
    });
  }

  Future updateLoungeWeAreOpen(
    bool weAreOpen,
  ) async {
    loungesCollection.doc(id).update({
      'weAreOpen': weAreOpen,
    });
  }

  Future updateLoungeActive(
    bool active,
  ) async {
    loungesCollection.doc(id).update({
      'active': active,
    });
  }

  Future updateLoungeEatThereAvailable(
    bool eatThereAvailable,
  ) async {
    loungesCollection.doc(id).update({
      'eatThere': eatThereAvailable,
    });
  }
  Future updateLoungeVerification(
    bool verification,
  ) async {
    loungesCollection.doc(id).update({
      'needsVerification': verification,
    });
  }

  Future updateCategory(
    String name,
  ) async {
    loungesCollection.doc(id).get().then((document) {
      category = document.data()['category'] ?? '';

      category[index] = name;

      loungesCollection.doc(id).update({
        'category': category,
      });
    });
  }

  Future addNewCategory(
    String name,
  ) async {
    loungesCollection.doc(id).get().then((document) {
      category = document.data()['category'] ?? '';

      category.add(name);

      loungesCollection.doc(id).update({
        'category': category,
      });
    });
  }

  Future removeCategory(
    String name,
  ) async {
    loungesCollection.doc(id).get().then((document) {
      category = document.data()['category'] ?? '';

      category.remove(name);

      loungesCollection.doc(id).update({
        'category': category,
      });
    });
  }

  Future updateRadius(
    double radius,
  ) async {
    loungesCollection.doc(id).update({
      'deliveryRadius': radius,
    });
  }

  //******************************************Lounge write************************************************** */
  //***********************************************Lounge related********************************************* */

  //********************************************Order related************************************************ */
  //********************************************Order read************************************************ */

  List<CarrierOrders> _carrierOrdersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CarrierOrders(
        food: doc.data()['food'] ?? '',
        quantity: doc.data()['quantity'] ?? '',
        price: doc.data()['price'] ?? '',
        total: doc.data()['total'] ?? '',
        loungeName: doc.data()['loungeName'] ?? '',
        created: doc.data()['created'] ?? '',
        isTaken: doc.data()['isTaken'] ?? '',
        orderCode: doc.data()['orderCode'] ?? '',
        userName: doc.data()['userName'] ?? '',
        userPhone: doc.data()['userPhone'] ?? '',
        carrierName: doc.data()['carrierName'] ?? '',
        carrierphone: doc.data()['carrierphone'] ?? '',
        carrierUserUid: doc.data()['carrierUserUid'] ?? '',
        documentId: doc.reference.id ?? '',
        longitude: doc.data()['Longitude'] ?? 0,
        latitude: doc.data()['Latitude'] ?? 0,
        information: doc.data()['information'] ?? '',
        delivered: doc.data()['deliveryTime'] ?? Timestamp.now(),
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<CarrierOrders>> get carrierOrders {
    return orderCollection
        .where('isDelivered', isEqualTo: false)
        .where('carrierUserUid', isEqualTo: userUid)
        .orderBy('created', descending: true)
        .snapshots()
        .map(_carrierOrdersListFromSnapshot);
  }
 List<Orders> _completeOrdersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Orders(
          food: doc.data()['food'] ?? '',
          quantity: doc.data()['quantity'] ?? '',
          price: doc.data()['price'] ?? '',
          loungeName: doc.data()['loungeName'] ?? '',
          loungeId: doc.data()['loungeId'] ?? '',
          created: doc.data()['created'] ?? '',
          isTaken: doc.data()['isTaken'] ?? '',
          orderCode: doc.data()['orderCode'] ?? '',
          userName: doc.data()['userName'] ?? '',
          information: doc.data()['information'] ?? '',
          userPhone: doc.data()['userPhone'] ?? '',
          latitude: doc.data()['Latitude'].toDouble() ?? 0.0,
          longitude: doc.data()['Longitude'].toDouble() ?? 0.0,
          loungeLatitude:
              doc.data()['LoungeLocation']['geopoint'].latitude.toDouble() ?? 0.0,
          loungeLongitude:
              doc.data()['LoungeLocation']['geopoint'].longitude.toDouble() ?? 0.0,
          distance: doc.data()['distance'].toDouble() ?? 0.0,
          deliveryFee: doc.data()['deliveryFee'].toDouble() ?? 0.0,
          serviceCharge: doc.data()['serviceCharge'].toDouble() ?? 0.0,
          tip: doc.data()['tip'].toInt() ?? 0,
          subTotal: doc.data()['subTotal'].toDouble() ?? 0.0,
          loungeOrderNumber: doc.data()['loungeOrderNumber'] ?? '',
          documentId: doc.reference.id ?? ''
          
          );
    }).toList();
  }
//orders list from a snapshot
  List<Orders> _ordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Orders(
        food: doc.data()['food'] ?? '',
        quantity: doc.data()['quantity'] ?? '',
        price: doc.data()['price'] ?? '',
        deliveryFee: doc.data()['deliveryFee'].toDouble() ?? 0.0,
        serviceCharge: doc.data()['serviceCharge'].toDouble() ?? 0.0,
        tip: doc.data()['tip'].toInt() ?? 0,
        subTotal: doc.data()['subTotal'] ?? '',
        loungeName: doc.data()['loungeName'] ?? '',
        created: doc.data()['created'] ?? '',
        delivered: doc.data()['deliveryTime'] ?? Timestamp.now(),
        isTaken: doc.data()['isTaken'] ?? '',
        orderCode: doc.data()['orderCode'] ?? '',
        loungeOrderNumber: doc.data()['loungeOrderNumber'] ?? '',
        userName: doc.data()['userName'] ?? '',
        userPhone: doc.data()['userPhone'] ?? '',
        carrierName: doc.data()['carrierName'] ?? '',
        carrierphone: doc.data()['carrierphone'] ?? '',
        carrierUserUid: doc.data()['carrierUserUid'] ?? '',
        information: doc.data()['information'] ?? '',
        userToken: doc.data()['userMessagingToken'] ?? '',
        documentId: doc.reference.id ?? '',
      );
    }).toList();
  }

  Future removeOrder() async {
    return orderCollection.doc(id).delete();
  }

  //orders lounges stream
  Stream<List<Orders>> get orders {
    return orderCollection
        .where('isDelivered', isEqualTo: false)
        .where('loungeId', isEqualTo: loungeId)
        .orderBy('created', descending: true)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  Stream<List<Orders>> get completeOrders {
    return orderCollection
        .where('isDelivered', isEqualTo: true)
        .where('isPaid', isEqualTo: false)
        .where('loungeId', isEqualTo: loungeId)
        .orderBy('created', descending: true)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  Stream<List<Orders>> get allorders {
    return orderCollection
        .where('isDelivered', isEqualTo: true)
        .where('isTaken', isEqualTo: true)
        .where('isPaid', isEqualTo: false)
        .orderBy('created', descending: true)
        .snapshots()
        .map(_ordersListFromSnapshot);
  }

  Future updateOrderWithCarriers(
    String carrierName,
    String carrierphone,
    String carrierUserUid,
  ) async {
    orderCollection.doc(id).update({
      'carrierName': carrierName,
      'carrierphone': carrierphone,
      'carrierUserUid': carrierUserUid,
      'isTaken': true
    });
  }

  Future updateOrderIsDelivered() async {
    orderCollection.doc(id).update({
      'isDelivered': true,
      'deliveryTime': Timestamp.now(),
    });
  }
  //********************************************Order read************************************************ */
  //************************************************Order related******************************************** */

}
