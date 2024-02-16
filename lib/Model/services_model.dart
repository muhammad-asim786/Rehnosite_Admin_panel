class ServiceModel {
  String serviceName;
  String serviceProviderEmail;
  String serviceProviderName;
  String serviceProviderPhone;
  String id;
  int index;
  ServiceModel({
    required this.id,
    required this.serviceName,
    required this.serviceProviderEmail,
    required this.serviceProviderName,
    required this.serviceProviderPhone,
    required this.index,
  });

  // Convert ServiceModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'Service name': serviceName,
      'Service provider email': serviceProviderEmail,
      'Service provider name': serviceProviderName,
      'Service provider phone': serviceProviderPhone,
      'id': id,
    };
  }

  // Create a ServiceModel object from a JSON map
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      index: json['index'],
      id: json['id'],
      serviceName: json['Service name'],
      serviceProviderEmail: json['Service provider email'],
      serviceProviderName: json['Service provider name'],
      serviceProviderPhone: json['Service provider phone'],
    );
  }
}
