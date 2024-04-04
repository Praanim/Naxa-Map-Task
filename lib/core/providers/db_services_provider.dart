import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/services/db_services.dart';

final dbServicesProvider =
    Provider<LocalDbServices>((ref) => LocalDbServices());
