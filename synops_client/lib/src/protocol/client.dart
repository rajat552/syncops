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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:synops_client/src/protocol/dashboard_summary.dart' as _i997jmad;
import 'package:synops_client/src/protocol/greetings/greeting.dart'
    as _iobj8qlp;
import 'package:synops_client/src/protocol/location_ping.dart' as _ijedxsy4;
import 'package:synops_client/src/protocol/task.dart' as _iz13ab3z;
import 'package:synops_client/src/protocol/task_event.dart' as _ixhio2rx;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointLocation extends _isc.EndpointRef {
  EndpointLocation(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'location';

  /// Responder submits a live GPS ping/telemetry update.
  _ida.Future<void> sendLocationPing(_ijedxsy4.LocationPing ping) =>
      caller.callServerEndpoint<void>(
        'location',
        'sendLocationPing',
        {'ping': ping},
      );

  /// Live stream of location updates for a specific emergency incident.
  _ida.Stream<_ijedxsy4.LocationPing> subscribeToTaskLocation(int taskId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ijedxsy4.LocationPing>,
        _ijedxsy4.LocationPing
      >(
        'location',
        'subscribeToTaskLocation',
        {'taskId': taskId},
        {},
      );

  /// Live stream of all active responders across the operations map.
  _ida.Stream<_ijedxsy4.LocationPing> subscribeToAllLocations() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ijedxsy4.LocationPing>,
        _ijedxsy4.LocationPing
      >(
        'location',
        'subscribeToAllLocations',
        {},
        {},
      );
}

/// {@category Endpoint}
class EndpointTask extends _isc.EndpointRef {
  EndpointTask(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  /// Creates a new emergency task/incident.
  _ida.Future<_iz13ab3z.Task> createTask({
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    required String severity,
    required int createdById,
    String? requiredSkill,
    required int timeoutSeconds,
  }) => caller.callServerEndpoint<_iz13ab3z.Task>(
    'task',
    'createTask',
    {
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'severity': severity,
      'createdById': createdById,
      'requiredSkill': requiredSkill,
      'timeoutSeconds': timeoutSeconds,
    },
  );

  /// Returns all tasks ordered by creation time descending.
  _ida.Future<List<_iz13ab3z.Task>> getAllTasks() =>
      caller.callServerEndpoint<List<_iz13ab3z.Task>>(
        'task',
        'getAllTasks',
        {},
      );

  /// Returns a single task by ID.
  _ida.Future<_iz13ab3z.Task?> getTask(int taskId) =>
      caller.callServerEndpoint<_iz13ab3z.Task?>(
        'task',
        'getTask',
        {'taskId': taskId},
      );

  /// Returns only tasks that are available for acceptance (PENDING).
  _ida.Future<List<_iz13ab3z.Task>> getOpenTasks() =>
      caller.callServerEndpoint<List<_iz13ab3z.Task>>(
        'task',
        'getOpenTasks',
        {},
      );

  /// Responder accepts a task. Protected against race conditions / concurrency conflicts.
  _ida.Future<_iz13ab3z.Task> acceptTask({
    required int taskId,
    required int responderId,
    required String responderName,
    required int timeoutSeconds,
  }) => caller.callServerEndpoint<_iz13ab3z.Task>(
    'task',
    'acceptTask',
    {
      'taskId': taskId,
      'responderId': responderId,
      'responderName': responderName,
      'timeoutSeconds': timeoutSeconds,
    },
  );

  /// Responder updates the state along the emergency workflow:
  /// ACCEPTED -> EN_ROUTE -> ARRIVED -> IN_PROGRESS -> COMPLETED
  _ida.Future<_iz13ab3z.Task> updateTaskStatus({
    required int taskId,
    required int responderId,
    required String newStatus,
    required int timeoutSeconds,
  }) => caller.callServerEndpoint<_iz13ab3z.Task>(
    'task',
    'updateTaskStatus',
    {
      'taskId': taskId,
      'responderId': responderId,
      'newStatus': newStatus,
      'timeoutSeconds': timeoutSeconds,
    },
  );

  /// Responder voluntarily releases a task before completion.
  _ida.Future<_iz13ab3z.Task> releaseTask({
    required int taskId,
    required int responderId,
    required String reason,
  }) => caller.callServerEndpoint<_iz13ab3z.Task>(
    'task',
    'releaseTask',
    {
      'taskId': taskId,
      'responderId': responderId,
      'reason': reason,
    },
  );

  /// Simulated timeout trigger specifically designed for the Hackathon Judge Demo.
  /// Immediately executes the automated recovery workflow.
  _ida.Future<_iz13ab3z.Task> triggerSimulatedTimeout({required int taskId}) =>
      caller.callServerEndpoint<_iz13ab3z.Task>(
        'task',
        'triggerSimulatedTimeout',
        {'taskId': taskId},
      );

  /// Returns the complete event audit timeline for a task.
  _ida.Future<List<_ixhio2rx.TaskEvent>> getTaskTimeline(int taskId) =>
      caller.callServerEndpoint<List<_ixhio2rx.TaskEvent>>(
        'task',
        'getTaskTimeline',
        {'taskId': taskId},
      );

  /// Returns high-level metrics for the Coordinator dashboard cards.
  _ida.Future<_i997jmad.DashboardSummary> getDashboardSummary() =>
      caller.callServerEndpoint<_i997jmad.DashboardSummary>(
        'task',
        'getDashboardSummary',
        {},
      );

  /// Real-time stream of all task status updates.
  _ida.Stream<_iz13ab3z.Task> subscribeToTaskUpdates() => caller
      .callStreamingServerEndpoint<_ida.Stream<_iz13ab3z.Task>, _iz13ab3z.Task>(
        'task',
        'subscribeToTaskUpdates',
        {},
        {},
      );

  /// Real-time stream of audit events for a specific task.
  _ida.Stream<_ixhio2rx.TaskEvent> subscribeToTaskEvents(int taskId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ixhio2rx.TaskEvent>,
        _ixhio2rx.TaskEvent
      >(
        'task',
        'subscribeToTaskEvents',
        {'taskId': taskId},
        {},
      );

  /// Real-time stream of all system-wide audit events.
  _ida.Stream<_ixhio2rx.TaskEvent> subscribeToAllEvents() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ixhio2rx.TaskEvent>,
        _ixhio2rx.TaskEvent
      >(
        'task',
        'subscribeToAllEvents',
        {},
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_iobj8qlp.Greeting> hello(String name) =>
      caller.callServerEndpoint<_iobj8qlp.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    location = EndpointLocation(this);
    task = EndpointTask(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointLocation location;

  late final EndpointTask task;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'location': location,
    'task': task,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
