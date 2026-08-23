import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Offline-stable client UUID. The same id is sent to the server later.
String newClientId() => _uuid.v4();
