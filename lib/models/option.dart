import 'package:cloud_firestore/cloud_firestore.dart';

class Options
{
  String? optionID;
  String? optionInfo;
  String? optionTitle;
  Timestamp? publishedDate;
  String? employeeUID;
  String? status;
  String? thumbnailUrl;

  Options({
    this.optionID,
    this.optionInfo,
    this.optionTitle,
    this.publishedDate,
    this.employeeUID,
    this.status,
    this.thumbnailUrl,
  });

  Options.fromJson(Map<String, dynamic> json)
  {
    optionID = json["optionID"];
    optionInfo = json["optionInfo"];
    optionTitle = json["optionTitle"];
    publishedDate = json["publishedDate"];
    employeeUID = json["employeeUID"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}