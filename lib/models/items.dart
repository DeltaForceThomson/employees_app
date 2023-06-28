import 'package:cloud_firestore/cloud_firestore.dart';

class Items
{
  String? optionID;
  String? itemID;
  String? itemInfo;
  String? itemTitle;
  String? longDescription;
  String? tax;
  Timestamp? publishedDate;
  String? employeeName;
  String? employeeUID;
  String? status;
  String? thumbnailUrl;

  Items({
    this.optionID,
    this.itemID,
    this.itemInfo,
    this.itemTitle,
    this.longDescription,
    this.tax,
    this.publishedDate,
    this.employeeName,
    this.employeeUID,
    this.status,
    this.thumbnailUrl,
  });

  Items.fromJson(Map<String, dynamic> json)
  {
    optionID = json["optionID"];
    itemID = json["itemID"];
    itemInfo = json["itemInfo"];
    itemTitle = json["itemTitle"];
    longDescription = json["longDescription"];
    tax = json["tax"];
    publishedDate = json["publishedDate"];
    employeeName = json["employeeName"];
    employeeUID = json["employeeUID"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}