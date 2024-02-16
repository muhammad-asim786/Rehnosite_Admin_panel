class ContactModel {
  String? name;
  String? email;
  String? phone;
  String? jobTitle;
  String? companyName;

  ContactModel(
      {this.name, this.email, this.phone, this.jobTitle, this.companyName});

  ContactModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    jobTitle = json['jobTitle'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'jobTitle': jobTitle,
        'companyName': companyName,
      };
}

class HubContactModel {
  String? name;
  String? email;
  String? phone;
  String? jobTitle;
  String? companyName;

  HubContactModel(
      {this.name, this.email, this.phone, this.jobTitle, this.companyName});

  HubContactModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['Email'];
    phone = json['Phone Number'];
    companyName = json['Associated Company'];
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Email': email,
        'Phone Number': phone,
        'Associated Company': companyName,
      };
}
