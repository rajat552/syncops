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

abstract class Task implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      arrivedAt: jsonSerialization['arrivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['arrivedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      lastActivityAt: jsonSerialization['lastActivityAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastActivityAt'],
            ),
      reassignmentCount: jsonSerialization['reassignmentCount'] as int?,
      requiredSkill: jsonSerialization['requiredSkill'] as String?,
    );
  }

  static final t = TaskTable();

  static const db = TaskRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static TaskInclude include() {
    return TaskInclude._();
  }

  static TaskIncludeList includeList({
    _is.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    TaskInclude? include,
  }) {
    return TaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class TaskUpdateTable extends _is.UpdateTable<TaskTable> {
  TaskUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<String, String> severity(String value) => _is.ColumnValue(
    table.severity,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> createdById(int value) => _is.ColumnValue(
    table.createdById,
    value,
  );

  _is.ColumnValue<int, int> assignedToId(int? value) => _is.ColumnValue(
    table.assignedToId,
    value,
  );

  _is.ColumnValue<String, String> assignedResponderName(String? value) =>
      _is.ColumnValue(
        table.assignedResponderName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> acceptedAt(DateTime? value) =>
      _is.ColumnValue(
        table.acceptedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> arrivedAt(DateTime? value) =>
      _is.ColumnValue(
        table.arrivedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastActivityAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastActivityAt,
        value,
      );

  _is.ColumnValue<int, int> reassignmentCount(int value) => _is.ColumnValue(
    table.reassignmentCount,
    value,
  );

  _is.ColumnValue<String, String> requiredSkill(String? value) =>
      _is.ColumnValue(
        table.requiredSkill,
        value,
      );
}

class TaskTable extends _is.Table<int?> {
  TaskTable({super.tableRelation}) : super(tableName: 'task') {
    updateTable = TaskUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    severity = _is.ColumnString(
      'severity',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    createdById = _is.ColumnInt(
      'createdById',
      this,
    );
    assignedToId = _is.ColumnInt(
      'assignedToId',
      this,
    );
    assignedResponderName = _is.ColumnString(
      'assignedResponderName',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    acceptedAt = _is.ColumnDateTime(
      'acceptedAt',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    arrivedAt = _is.ColumnDateTime(
      'arrivedAt',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    lastActivityAt = _is.ColumnDateTime(
      'lastActivityAt',
      this,
    );
    reassignmentCount = _is.ColumnInt(
      'reassignmentCount',
      this,
      hasDefault: true,
    );
    requiredSkill = _is.ColumnString(
      'requiredSkill',
      this,
    );
  }

  late final TaskUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString severity;

  late final _is.ColumnString status;

  late final _is.ColumnInt createdById;

  late final _is.ColumnInt assignedToId;

  late final _is.ColumnString assignedResponderName;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime acceptedAt;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime arrivedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime lastActivityAt;

  late final _is.ColumnInt reassignmentCount;

  late final _is.ColumnString requiredSkill;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    description,
    latitude,
    longitude,
    severity,
    status,
    createdById,
    assignedToId,
    assignedResponderName,
    createdAt,
    acceptedAt,
    startedAt,
    arrivedAt,
    completedAt,
    expiresAt,
    lastActivityAt,
    reassignmentCount,
    requiredSkill,
  ];
}

class TaskInclude extends _is.IncludeObject {
  TaskInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Task.t;
}

class TaskIncludeList extends _is.IncludeList {
  TaskIncludeList._({
    _is.WhereExpressionBuilder<TaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Task.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Task.t;
}

class TaskRepository {
  const TaskRepository._();

  /// Returns a list of [Task]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Task>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Task>(
      where: where?.call(Task.t),
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Task] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Task?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaskTable>? where,
    int? offset,
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Task>(
      where: where?.call(Task.t),
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Task] by its [id] or null if no such row exists.
  Future<Task?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Task>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Task]s in the list and returns the inserted rows.
  ///
  /// The returned [Task]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> insert(
    _is.DatabaseSession session,
    List<Task> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Task>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Task] and returns the inserted row.
  ///
  /// The returned [Task] will have its `id` field set.
  Future<Task> insertRow(
    _is.DatabaseSession session,
    Task row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Task>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Task]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Task]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> upsert(
    _is.DatabaseSession session,
    List<Task> rows, {
    required _is.ColumnSelections<TaskTable> conflictColumns,
    _is.ColumnSelections<TaskTable>? updateColumns,
    _is.WhereExpressionBuilder<TaskTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Task>(
      rows,
      conflictColumns: conflictColumns(Task.t),
      updateColumns: updateColumns?.call(Task.t),
      updateWhere: updateWhere?.call(Task.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Task] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Task] will have its `id` field set.
  Future<Task?> upsertRow(
    _is.DatabaseSession session,
    Task row, {
    required _is.ColumnSelections<TaskTable> conflictColumns,
    _is.ColumnSelections<TaskTable>? updateColumns,
    _is.WhereExpressionBuilder<TaskTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Task>(
      row,
      conflictColumns: conflictColumns(Task.t),
      updateColumns: updateColumns?.call(Task.t),
      updateWhere: updateWhere?.call(Task.t),
      transaction: transaction,
    );
  }

  /// Updates all [Task]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> update(
    _is.DatabaseSession session,
    List<Task> rows, {
    _is.ColumnSelections<TaskTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Task>(
      rows,
      columns: columns?.call(Task.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Task]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Task> updateRow(
    _is.DatabaseSession session,
    Task row, {
    _is.ColumnSelections<TaskTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Task>(
      row,
      columns: columns?.call(Task.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Task] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Task?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TaskUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Task>(
      id,
      columnValues: columnValues(Task.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Task]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TaskUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TaskTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Task>(
      columnValues: columnValues(Task.t.updateTable),
      where: where(Task.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Task]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> delete(
    _is.DatabaseSession session,
    List<Task> rows, {
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Task>(
      rows,
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Task].
  Future<Task> deleteRow(
    _is.DatabaseSession session,
    Task row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Task>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Task>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TaskTable> where,
    _is.OrderByBuilder<TaskTable>? orderBy,
    _is.OrderByListBuilder<TaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Task>(
      where: where(Task.t),
      orderBy: orderBy?.call(Task.t),
      orderByList: orderByList?.call(Task.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaskTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Task>(
      where: where?.call(Task.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Task] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TaskTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Task>(
      where: where(Task.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
