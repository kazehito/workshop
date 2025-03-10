part of 'crete_post_bloc.dart';

@immutable
sealed class CretePostState {}

final class CretePostInitial extends CretePostState {}

class  PostCreated extends CretePostState{

}
class  PostUnsuccessful extends CretePostState{

}