abstract class SupportEvent {}

class InitEvent extends SupportEvent {}

class PostSupportEvent extends SupportEvent {
  final String text;

  PostSupportEvent(this.text);
}
