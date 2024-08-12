class Service {
  final int id;
  final int serviceManagerID;
  final int? parentServiceID;
  final int serviceYearAndSpecializationID;
  final String serviceName;
  final String serviceDescription;
  final String serviceType;
  final int minimumNumberOfGroupMembers;
  final int maximumNumberOfGroupMembers;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<Service> children;

  Service({
    required this.id,
    required this.serviceManagerID,
    this.parentServiceID,
    required this.serviceYearAndSpecializationID,
    required this.serviceName,
    required this.serviceDescription,
    required this.serviceType,
    required this.minimumNumberOfGroupMembers,
    required this.maximumNumberOfGroupMembers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.children = const [],
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List<dynamic>? ?? [];
    var childrenList = childrenJson.map((childJson) => Service.fromJson(childJson)).toList();

    return Service(
      id: json['id'] ?? 0,
      serviceManagerID: json['serviceManagerID'] ?? 0,
      parentServiceID: json['parentServiceID'],
      serviceYearAndSpecializationID: json['serviceYearAndSpecializationID'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      serviceDescription: json['serviceDescription'] ?? '',
      serviceType: json['serviceType'] ?? '',
      minimumNumberOfGroupMembers: json['minimumNumberOfGroupMembers'] ?? 0,
      maximumNumberOfGroupMembers: json['maximumNumberOfGroupMembers'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      children: childrenList,
    );
  }
}