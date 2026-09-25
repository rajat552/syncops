class SyncOpsRole {
  final int id;
  final String name;
  final String title;
  final String roleType; // 'COORDINATOR' or 'RESPONDER'

  const SyncOpsRole({
    required this.id,
    required this.name,
    required this.title,
    required this.roleType,
  });
}

class SyncOpsConstants {
  static const coordinator = SyncOpsRole(
    id: 101,
    name: 'Dispatcher Maya',
    title: 'Emergency Operations Director',
    roleType: 'COORDINATOR',
  );

  static const responderA = SyncOpsRole(
    id: 201,
    name: 'Alex Chen',
    title: 'Alpha Unit (Medic 1)',
    roleType: 'RESPONDER',
  );

  static const responderB = SyncOpsRole(
    id: 202,
    name: 'Bailey Torres',
    title: 'Bravo Unit (Rescue 4)',
    roleType: 'RESPONDER',
  );

  static const List<SyncOpsRole> availableRoles = [
    coordinator,
    responderA,
    responderB,
  ];

  static const List<Map<String, dynamic>> presetIncidents = [
    {
      'title': 'Trauma Supply Delivery',
      'description':
          'Urgent blood plasma and defibrillator transport to Sector 4 field clinic.',
      'severity': 'CRITICAL',
      'lat': 37.7749,
      'lng': -122.4194,
      'skill': 'HAZMAT_PARAMEDIC',
      'timeoutSeconds': 40,
    },
    {
      'title': 'Search & Rescue Grid B',
      'description': 'Overdue trail runner beacon active near western ravine.',
      'severity': 'HIGH',
      'lat': 37.7833,
      'lng': -122.4167,
      'skill': 'SEARCH_RESCUE',
      'timeoutSeconds': 50,
    },
    {
      'title': 'Substation Cooling Failure',
      'description':
          'Emergency backup coolant pump stopped. Heat escalation in Progress.',
      'severity': 'CRITICAL',
      'lat': 37.7900,
      'lng': -122.4000,
      'skill': 'INFRASTRUCTURE',
      'timeoutSeconds': 45,
    },
    {
      'title': 'Coastal Pier Evacuation',
      'description': 'High surf breach at pier 14 mooring line.',
      'severity': 'MEDIUM',
      'lat': 37.7950,
      'lng': -122.3920,
      'skill': 'GENERAL_RESPONSE',
      'timeoutSeconds': 60,
    },
  ];
}
