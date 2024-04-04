import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/core/exceptions/http_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLauncherNotifierProvider =
    StateNotifierProvider<UrlLauncherNotifier, AppException?>(
        (ref) => UrlLauncherNotifier());

class UrlLauncherNotifier extends StateNotifier<AppException?> {
  UrlLauncherNotifier() : super(null);

  void tryLaunchUrl(String urlString) async {
    try {
      //uri for the url string
      final uri = Uri.parse(urlString);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw Exception();
      }
    } catch (_) {
      state = AppException(message: 'Could not launch the url !!!');
    }
  }
}
