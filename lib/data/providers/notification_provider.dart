import 'package:custome_mobile/data/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;
  int _notreadednotifications = 0;
  int get notreadednotifications => _notreadednotifications;

  initNotifications(List<NotificationModel> noti) async {
    _notifications = [];
    _notifications = noti;
    var prefs = await SharedPreferences.getInstance();
    _notreadednotifications = prefs.getInt("notreaded") ?? 0;
    notifyListeners();
  }

  addNotReadedNotification() async {
    var prefs = await SharedPreferences.getInstance();
    _notreadednotifications = prefs.getInt("notreaded") ?? 0;
    _notreadednotifications++;
    prefs.setInt("notreaded", _notreadednotifications);
    notifyListeners();
  }

  removeNotReadedNotification() async {
    var prefs = await SharedPreferences.getInstance();
    _notreadednotifications = prefs.getInt("notreaded") ?? 0;
    _notreadednotifications--;
    prefs.setInt("notreaded", _notreadednotifications);
    notifyListeners();
  }

  clearNotReadedNotification() async {
    var prefs = await SharedPreferences.getInstance();
    _notreadednotifications = prefs.getInt("notreaded") ?? 0;
    _notreadednotifications = 0;
    prefs.setInt("notreaded", _notreadednotifications);
    notifyListeners();
  }

  markNotificationAsRead(int id) {
    var templist = _notifications;
    for (var element in templist) {
      if (element.id! == id) {
        _notifications
            .singleWhere((it) => it.id == element.id,
                orElse: () => NotificationModel())
            .isread = true;
      }
    }
    notifyListeners();
  }

  addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
