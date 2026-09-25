/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:synops_client/src/protocol/task.dart' as _iz13ab3z;
import 'package:synops_client/src/protocol/task_event.dart' as _ixhio2rx;
import 'dashboard_summary.dart' as _ijes90i9;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'location_ping.dart' as _i775ycu8;
import 'task.dart' as _iwn6t6fs;
import 'task_event.dart' as _io0tje1k;
export 'dashboard_summary.dart';
export 'greetings/greeting.dart';
export 'location_ping.dart';
export 'task.dart';
export 'task_event.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ijes90i9.DashboardSummary) {
      return _ijes90i9.DashboardSummary.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i775ycu8.LocationPing) {
      return _i775ycu8.LocationPing.fromJson(data) as T;
    }
    if (t == _iwn6t6fs.Task) {
      return _iwn6t6fs.Task.fromJson(data) as T;
    }
    if (t == _io0tje1k.TaskEvent) {
      return _io0tje1k.TaskEvent.fromJson(data) as T;
    }
    if (t == _isc.getType<_ijes90i9.DashboardSummary?>()) {
      return (data != null ? _ijes90i9.DashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i775ycu8.LocationPing?>()) {
      return (data != null ? _i775ycu8.LocationPing.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwn6t6fs.Task?>()) {
      return (data != null ? _iwn6t6fs.Task.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_io0tje1k.TaskEvent?>()) {
      return (data != null ? _io0tje1k.TaskEvent.fromJson(data) : null) as T;
    }
    if (t == List<_iz13ab3z.Task>) {
      return (data as List).map((e) => deserialize<_iz13ab3z.Task>(e)).toList()
          as T;
    }
    if (t == List<_ixhio2rx.TaskEvent>) {
      return (data as List)
              .map((e) => deserialize<_ixhio2rx.TaskEvent>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ijes90i9.DashboardSummary => 'DashboardSummary',
      _izw8z7ou.Greeting => 'Greeting',
      _i775ycu8.LocationPing => 'LocationPing',
      _iwn6t6fs.Task => 'Task',
      _io0tje1k.TaskEvent => 'TaskEvent',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('synops.', '');
    }

    switch (data) {
      case _ijes90i9.DashboardSummary():
        return 'DashboardSummary';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i775ycu8.LocationPing():
        return 'LocationPing';
      case _iwn6t6fs.Task():
        return 'Task';
      case _io0tje1k.TaskEvent():
        return 'TaskEvent';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_ijes90i9.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'LocationPing') {
      return deserialize<_i775ycu8.LocationPing>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_iwn6t6fs.Task>(data['data']);
    }
    if (dataClassName == 'TaskEvent') {
      return deserialize<_io0tje1k.TaskEvent>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('synops', this);
    _iacc.Protocol().registerHostProtocol('synops', this);
  }

  @override
  String getModuleName() => 'synops';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
