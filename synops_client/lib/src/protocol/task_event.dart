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

abstract class TaskEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TaskEvent._({
    this.id,
    required this.taskId,
    this.actorId,
    this.actorName,
    required this.type,
    required this.message,
    required this.timestamp,
    this.metadata,
  });

  factory TaskEvent({
    int? id,
    required int taskId,
    int? actorId,
    String? actorName,
    required String type,
    required String message,
    required DateTime timestamp,
    String? metadata,
  }) = _TaskEventImpl;

  factory TaskEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskEvent(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      actorId: jsonSerialization['actorId'] as int?,
      actorName: jsonSerialization['actorName'] as String?,
      type: jsonSerialization['type'] as String,
      message: jsonSerialization['message'] as String,
      timestamp: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      metadata: jsonSerialization['metadata'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int taskId;

  int? actorId;

  String? actorName;

  String type;

  String message;

  DateTime timestamp;

  String? metadata;

  /// Returns a shallow copy of this [TaskEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TaskEvent copyWith({
    int? id,
    int? taskId,
    int? actorId,
    String? actorName,
    String? type,
    String? message,
    DateTime? timestamp,
    String? metadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaskEvent',
      if (id != null) 'id': id,
      'taskId': taskId,
      if (actorId != null) 'actorId': actorId,
      if (actorName != null) 'actorName': actorName,
      'type': type,
      'message': message,
      'timestamp': timestamp.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaskEvent',
      if (id != null) 'id': id,
      'taskId': taskId,
      if (actorId != null) 'actorId': actorId,
      if (actorName != null) 'actorName': actorName,
      'type': type,
      'message': message,
      'timestamp': timestamp.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskEventImpl extends TaskEvent {
  _TaskEventImpl({
    int? id,
    required int taskId,
    int? actorId,
    String? actorName,
    required String type,
    required String message,
    required DateTime timestamp,
    String? metadata,
  }) : super._(
         id: id,
         taskId: taskId,
         actorId: actorId,
         actorName: actorName,
         type: type,
         message: message,
         timestamp: timestamp,
         metadata: metadata,
       );

  /// Returns a shallow copy of this [TaskEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TaskEvent copyWith({
    Object? id = _Undefined,
    int? taskId,
    Object? actorId = _Undefined,
    Object? actorName = _Undefined,
    String? type,
    String? message,
    DateTime? timestamp,
    Object? metadata = _Undefined,
  }) {
    return TaskEvent(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      actorId: actorId is int? ? actorId : this.actorId,
      actorName: actorName is String? ? actorName : this.actorName,
      type: type ?? this.type,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata is String? ? metadata : this.metadata,
    );
  }
}
