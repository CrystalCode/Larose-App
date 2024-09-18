import 'package:crystal_code/common/models/order_model.dart';
import 'package:crystal_code/common/models/userinfo_model.dart';

class PaginatedUserListingModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Data>? data;

  PaginatedUserListingModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.data,
  });

  PaginatedUserListingModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? deliveryManId;
  double? karat;
  double? weight;
  double? proposedPrice;
  double? buyingPrice;
  String? status;
  String? pending;
  String? accepted;
  String? assignedDm;
  String? pickedUp;
  String? collected;
  int? isItemStocked;
  String? createdAt;
  String? updatedAt;
  DeliveryMan? deliveryMan;
  UserInfoModel? customer;
  List<Image>? images;

  Data(
      {this.id,
      this.userId,
      this.deliveryManId,
      this.karat,
      this.weight,
      this.proposedPrice,
      this.buyingPrice,
      this.status,
      this.pending,
      this.accepted,
      this.assignedDm,
      this.pickedUp,
      this.collected,
      this.isItemStocked,
      this.createdAt,
      this.updatedAt,
      this.deliveryMan,
      this.customer,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deliveryManId = json['delivery_man_id'];
    karat = double.tryParse(json['karat'].toString());
    weight = double.tryParse(json['weight'].toString());
    proposedPrice = double.tryParse(json['proposed_price'].toString());
    buyingPrice = double.tryParse(json['buying_price'].toString());
    status = json['status'];
    pending = json['pending'];
    accepted = json['accepted'];
    assignedDm = json['assigned_dm'];
    pickedUp = json['picked_up'];
    collected = json['collected'];
    isItemStocked = json['is_item_stocked'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['delivery_man'] != null) {
      deliveryMan = DeliveryMan.fromJson(json['delivery_man']);
    }
    if (json['customer'] != null) {
      customer = UserInfoModel.fromJson(json['customer']);
    }
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['delivery_man_id'] = deliveryManId;
    data['karat'] = karat;
    data['weight'] = weight;
    data['proposed_price'] = proposedPrice;
    data['buying_price'] = buyingPrice;
    data['status'] = status;
    data['pending'] = pending;
    data['accepted'] = accepted;
    data['assigned_dm'] = assignedDm;
    data['picked_up'] = pickedUp;
    data['collected'] = collected;
    data['is_item_stocked'] = isItemStocked;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan;
    }
    if (deliveryMan != null) {
      data['customer'] = customer;
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? image;
  Image({this.image});

  Image.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}
