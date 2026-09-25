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

abstract class TaskTimeoutCallHandleTimeoutModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TaskTimeoutCallHandleTimeoutModel._({required this.taskId});

  factory TaskTimeoutCallHandleTimeoutModel({required int taskId}) =
      _TaskTimeoutCallHandleTimeoutModelImpl;

  factory TaskTimeoutCallHandleTimeoutModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TaskTimeoutCallHandleTimeoutModel(
      taskId: jsonSerialization['taskId'] as int,
    );
  }

  int taskId;

  /// Returns a shallow copy of this [TaskTimeoutCallHandleTimeoutModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TaskTimeoutCallHandleTimeoutModel copyWith({int? taskId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaskTimeoutCallHandleTimeoutModel',
      'taskId': taskId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TaskTimeoutCallHandleTimeoutModelImpl
    extends TaskTimeoutCallHandleTimeoutModel {
  _TaskTimeoutCallHandleTimeoutModelImpl({required int taskId})
    : super._(taskId: taskId);

  /// Returns a shallow copy of this [TaskTimeoutCallHandleTimeoutModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TaskTimeoutCallHandleTimeoutModel copyWith({int? taskId}) {
    return TaskTimeoutCallHandleTimeoutModel(taskId: taskId ?? this.taskId);
  }
}
