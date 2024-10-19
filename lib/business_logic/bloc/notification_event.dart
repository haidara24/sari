part of 'notification_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationLoadEvent extends NotificationEvent {}

class NotificationUpdateEvent extends NotificationEvent {
  final int notificationId;

  NotificationUpdateEvent({required this.notificationId});
}
