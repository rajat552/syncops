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
import 'package:serverpod/serverpod.dart' as _is;

abstract class LocationPing
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LocationPing._({
    required this.responderId,
    required this.responderName,
    required this.taskId,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.batteryLevel,
    this.speed,
  });

  factory LocationPing({
    required int responderId,
    required String responderName,
    required int taskId,
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    double? batteryLevel,
    double? speed,
  }) = _LocationPingImpl;

  factory LocationPing.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocationPing(
      responderId: jsonSerialization['responderId'] as int,
      responderName: jsonSerialization['responderName'] as String,
      taskId: jsonSerialization['taskId'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      batteryLevel: (jsonSerialization['batteryLevel'] as num?)?.toDouble(),
      speed: (jsonSerialization['speed'] as num?)?.toDouble(),
    );
  }

  int responderId;

  String responderName;

  int taskId;

  double latitude;

  double longitude;

  DateTime timestamp;

  double? batteryLevel;

  double? speed;

  /// Returns a shallow copy of this [LocationPing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LocationPing copyWith({
    int? responderId,
    String? responderName,
    int? taskId,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
    double? batteryLevel,
    double? speed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocationPing',
      'responderId': responderId,
      'responderName': responderName,
      'taskId': taskId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toJson(),
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      if (speed != null) 'speed': speed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocationPing',
      'responderId': responderId,
      'responderName': responderName,
      'taskId': taskId,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toJson(),
      if (batteryLevel != null) 'batteryLevel': batteryLevel,
      if (speed != null) 'speed': speed,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocationPingImpl extends LocationPing {
  _LocationPingImpl({
    required int responderId,
    required String responderName,
    required int taskId,
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    double? batteryLevel,
    double? speed,
  }) : super._(
         responderId: responderId,
         responderName: responderName,
         taskId: taskId,
         latitude: latitude,
         longitude: longitude,
         timestamp: timestamp,
         batteryLevel: batteryLevel,
         speed: speed,
       );

  /// Returns a shallow copy of this [LocationPing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LocationPing copyWith({
    int? responderId,
    String? responderName,
    int? taskId,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
    Object? batteryLevel = _Undefined,
    Object? speed = _Undefined,
  }) {
    return LocationPing(
      responderId: responderId ?? this.responderId,
      responderName: responderName ?? this.responderName,
      taskId: taskId ?? this.taskId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
      batteryLevel: batteryLevel is double? ? batteryLevel : this.batteryLevel,
      speed: speed is double? ? speed : this.speed,
    );
  }
}
