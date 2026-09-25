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

abstract class DashboardSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DashboardSummary._({
    required this.activeIncidents,
    required this.inResponse,
    required this.needsAttention,
    required this.completedToday,
    required this.reassignedTotal,
  });

  factory DashboardSummary({
    required int activeIncidents,
    required int inResponse,
    required int needsAttention,
    required int completedToday,
    required int reassignedTotal,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      activeIncidents: jsonSerialization['activeIncidents'] as int,
      inResponse: jsonSerialization['inResponse'] as int,
      needsAttention: jsonSerialization['needsAttention'] as int,
      completedToday: jsonSerialization['completedToday'] as int,
      reassignedTotal: jsonSerialization['reassignedTotal'] as int,
    );
  }

  int activeIncidents;

  int inResponse;

  int needsAttention;

  int completedToday;

  int reassignedTotal;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DashboardSummary copyWith({
    int? activeIncidents,
    int? inResponse,
    int? needsAttention,
    int? completedToday,
    int? reassignedTotal,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardSummary',
      'activeIncidents': activeIncidents,
      'inResponse': inResponse,
      'needsAttention': needsAttention,
      'completedToday': completedToday,
      'reassignedTotal': reassignedTotal,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardSummary',
      'activeIncidents': activeIncidents,
      'inResponse': inResponse,
      'needsAttention': needsAttention,
      'completedToday': completedToday,
      'reassignedTotal': reassignedTotal,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required int activeIncidents,
    required int inResponse,
    required int needsAttention,
    required int completedToday,
    required int reassignedTotal,
  }) : super._(
         activeIncidents: activeIncidents,
         inResponse: inResponse,
         needsAttention: needsAttention,
         completedToday: completedToday,
         reassignedTotal: reassignedTotal,
       );

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DashboardSummary copyWith({
    int? activeIncidents,
    int? inResponse,
    int? needsAttention,
    int? completedToday,
    int? reassignedTotal,
  }) {
    return DashboardSummary(
      activeIncidents: activeIncidents ?? this.activeIncidents,
      inResponse: inResponse ?? this.inResponse,
      needsAttention: needsAttention ?? this.needsAttention,
      completedToday: completedToday ?? this.completedToday,
      reassignedTotal: reassignedTotal ?? this.reassignedTotal,
    );
  }
}
