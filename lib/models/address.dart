class Address
{
  String? name;
  String? phoneNumber;
  String? wardNumber;
  String? HouseNumber;
  String? rationcardNumber;
  String? completeAddress;


  Address({
    this.name,
    this.phoneNumber,
    this.wardNumber,
    this.HouseNumber,
    this.rationcardNumber,
    this.completeAddress,
  });

  Address.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    wardNumber = json['wardNumber'];
    HouseNumber = json['HouseNumber'];
    rationcardNumber = json['city'];
    completeAddress = json['completeAddress'];
  }
}