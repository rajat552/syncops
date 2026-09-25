/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Task
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Task._({
    this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.severity,
    required this.status,
    required this.createdById,
    this.assignedToId,
    this.assignedResponderName,
    required this.createdAt,
    this.acceptedAt,
    this.startedAt,
    this.arrivedAt,
    this.completedAt,
    this.expiresAt,
    this.lastActivityAt,
    int? reassignmentCount,
    this.requiredSkill,
  }) : reassignmentCount = reassignmentCount ?? 0;

  factory Task({
    int? id,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required int createdById,
    int? assignedToId,
    String? assignedResponderName,
    required DateTime createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? arrivedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    DateTime? lastActivityAt,
    int? reassignmentCount,
    String? requiredSkill,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      severity: jsonSerialization['severity'] as String,
      status: jsonSerialization['status'] as String,
      createdById: jsonSerialization['createdById'] as int,
      assignedToId: jsonSerialization['assignedToId'] as int?,
      assignedResponderName:
          jsonSerialization['assignedResponderName'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['acceptedAt'],
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      arrivedAt: jsonSerialization['arrivedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['arrivedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      lastActivityAt: jsonSerialization['lastActivityAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActivityAt'],
            ),
      reassignmentCount: jsonSerialization['reassignmentCount'] as int?,
      requiredSkill: jsonSerialization['requiredSkill'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  double latitude;

  double longitude;

  String severity;

  String status;

  int createdById;

  int? assignedToId;

  String? assignedResponderName;

  DateTime createdAt;

  DateTime? acceptedAt;

  DateTime? startedAt;

  DateTime? arrivedAt;

  DateTime? completedAt;

  DateTime? expiresAt;

  DateTime? lastActivityAt;

  int reassignmentCount;

  String? requiredSkill;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Task copyWith({
    int? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    int? createdById,
    int? assignedToId,
    String? assignedResponderName,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? arrivedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    DateTime? lastActivityAt,
    int? reassignmentCount,
    String? requiredSkill,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdById': createdById,
      if (assignedToId != null) 'assignedToId': assignedToId,
      if (assignedResponderName != null)
        'assignedResponderName': assignedResponderName,
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (arrivedAt != null) 'arrivedAt': arrivedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (lastActivityAt != null) 'lastActivityAt': lastActivityAt?.toJson(),
      'reassignmentCount': reassignmentCount,
      if (requiredSkill != null) 'requiredSkill': requiredSkill,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'status': status,
      'createdById': createdById,
      if (assignedToId != null) 'assignedToId': assignedToId,
      if (assignedResponderName != null)
        'assignedResponderName': assignedResponderName,
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (arrivedAt != null) 'arrivedAt': arrivedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (lastActivityAt != null) 'lastActivityAt': lastActivityAt?.toJson(),
      'reassignmentCount': reassignmentCount,
      if (requiredSkill != null) 'requiredSkill': requiredSkill,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String severity,
    required String status,
    required int createdById,
    int? assignedToId,
    String? assignedResponderName,
    required DateTime createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? arrivedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    DateTime? lastActivityAt,
    int? reassignmentCount,
    String? requiredSkill,
  }) : super._(
         id: id,
         title: title,
         description: description,
         latitude: latitude,
         longitude: longitude,
         severity: severity,
         status: status,
         createdById: createdById,
         assignedToId: assignedToId,
         assignedResponderName: assignedResponderName,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
         startedAt: startedAt,
         arrivedAt: arrivedAt,
         completedAt: completedAt,
         expiresAt: expiresAt,
         lastActivityAt: lastActivityAt,
         reassignmentCount: reassignmentCount,
         requiredSkill: requiredSkill,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    String? severity,
    String? status,
    int? createdById,
    Object? assignedToId = _Undefined,
    Object? assignedResponderName = _Undefined,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? arrivedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? expiresAt = _Undefined,
    Object? lastActivityAt = _Undefined,
    int? reassignmentCount,
    Object? requiredSkill = _Undefined,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      assignedToId: assignedToId is int? ? assignedToId : this.assignedToId,
      assignedResponderName: assignedResponderName is String?
          ? assignedResponderName
          : this.assignedResponderName,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      arrivedAt: arrivedAt is DateTime? ? arrivedAt : this.arrivedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      lastActivityAt: lastActivityAt is DateTime?
          ? lastActivityAt
          : this.lastActivityAt,
      reassignmentCount: reassignmentCount ?? this.reassignmentCount,
      requiredSkill: requiredSkill is String?
          ? requiredSkill
          : this.requiredSkill,
    );
  }
}
