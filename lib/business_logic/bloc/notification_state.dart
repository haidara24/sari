part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadingProgress extends NotificationState {}

class NotificationLoadedSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoadedSuccess({required this.notifications});
}

class NotificationLoadedFailed extends NotificationState {
  final String errorText;

  NotificationLoadedFailed({required this.errorText});
}
