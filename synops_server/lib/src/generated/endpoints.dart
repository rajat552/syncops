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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:synops_server/src/generated/future_calls.dart' as _iw5h3zzg;
import 'package:synops_server/src/generated/location_ping.dart' as _ie0ms72o;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/location_endpoint.dart' as _iu1rtxjg;
import '../endpoints/task_endpoint.dart' as _idmllfay;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'location': _iu1rtxjg.LocationEndpoint()
        ..initialize(
          server,
          'location',
          null,
        ),
      'task': _idmllfay.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['location'] = _is.EndpointConnector(
      name: 'location',
      endpoint: endpoints['location']!,
      methodConnectors: {
        'sendLocationPing': _is.MethodConnector(
          name: 'sendLocationPing',
          params: {
            'ping': _is.ParameterDescription(
              name: 'ping',
              type: _is.getType<_ie0ms72o.LocationPing>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['location'] as _iu1rtxjg.LocationEndpoint)
                  .sendLocationPing(
                    session,
                    params['ping'],
                  ),
        ),
        'subscribeToTaskLocation': _is.MethodStreamConnector(
          name: 'subscribeToTaskLocation',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['location'] as _iu1rtxjg.LocationEndpoint)
                  .subscribeToTaskLocation(
                    session,
                    params['taskId'],
                  ),
        ),
        'subscribeToAllLocations': _is.MethodStreamConnector(
          name: 'subscribeToAllLocations',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['location'] as _iu1rtxjg.LocationEndpoint)
                  .subscribeToAllLocations(session),
        ),
      },
    );
    connectors['task'] = _is.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'createTask': _is.MethodConnector(
          name: 'createTask',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'severity': _is.ParameterDescription(
              name: 'severity',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'createdById': _is.ParameterDescription(
              name: 'createdById',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'requiredSkill': _is.ParameterDescription(
              name: 'requiredSkill',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'timeoutSeconds': _is.ParameterDescription(
              name: 'timeoutSeconds',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['task'] as _idmllfay.TaskEndpoint).createTask(
                    session,
                    title: params['title'],
                    description: params['description'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    severity: params['severity'],
                    createdById: params['createdById'],
                    requiredSkill: params['requiredSkill'],
                    timeoutSeconds: params['timeoutSeconds'],
                  ),
        ),
        'getAllTasks': _is.MethodConnector(
          name: 'getAllTasks',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .getAllTasks(session),
        ),
        'getTask': _is.MethodConnector(
          name: 'getTask',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint).getTask(
                session,
                params['taskId'],
              ),
        ),
        'getOpenTasks': _is.MethodConnector(
          name: 'getOpenTasks',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .getOpenTasks(session),
        ),
        'acceptTask': _is.MethodConnector(
          name: 'acceptTask',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responderId': _is.ParameterDescription(
              name: 'responderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responderName': _is.ParameterDescription(
              name: 'responderName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'timeoutSeconds': _is.ParameterDescription(
              name: 'timeoutSeconds',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['task'] as _idmllfay.TaskEndpoint).acceptTask(
                    session,
                    taskId: params['taskId'],
                    responderId: params['responderId'],
                    responderName: params['responderName'],
                    timeoutSeconds: params['timeoutSeconds'],
                  ),
        ),
        'updateTaskStatus': _is.MethodConnector(
          name: 'updateTaskStatus',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responderId': _is.ParameterDescription(
              name: 'responderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newStatus': _is.ParameterDescription(
              name: 'newStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'timeoutSeconds': _is.ParameterDescription(
              name: 'timeoutSeconds',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .updateTaskStatus(
                    session,
                    taskId: params['taskId'],
                    responderId: params['responderId'],
                    newStatus: params['newStatus'],
                    timeoutSeconds: params['timeoutSeconds'],
                  ),
        ),
        'releaseTask': _is.MethodConnector(
          name: 'releaseTask',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'responderId': _is.ParameterDescription(
              name: 'responderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['task'] as _idmllfay.TaskEndpoint).releaseTask(
                    session,
                    taskId: params['taskId'],
                    responderId: params['responderId'],
                    reason: params['reason'],
                  ),
        ),
        'triggerSimulatedTimeout': _is.MethodConnector(
          name: 'triggerSimulatedTimeout',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .triggerSimulatedTimeout(
                    session,
                    taskId: params['taskId'],
                  ),
        ),
        'getTaskTimeline': _is.MethodConnector(
          name: 'getTaskTimeline',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['task'] as _idmllfay.TaskEndpoint).getTaskTimeline(
                    session,
                    params['taskId'],
                  ),
        ),
        'getDashboardSummary': _is.MethodConnector(
          name: 'getDashboardSummary',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .getDashboardSummary(session),
        ),
        'subscribeToTaskUpdates': _is.MethodStreamConnector(
          name: 'subscribeToTaskUpdates',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .subscribeToTaskUpdates(session),
        ),
        'subscribeToTaskEvents': _is.MethodStreamConnector(
          name: 'subscribeToTaskEvents',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .subscribeToTaskEvents(
                    session,
                    params['taskId'],
                  ),
        ),
        'subscribeToAllEvents': _is.MethodStreamConnector(
          name: 'subscribeToAllEvents',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['task'] as _idmllfay.TaskEndpoint)
                  .subscribeToAllEvents(session),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _iw5h3zzg.FutureCalls();
  }
}
