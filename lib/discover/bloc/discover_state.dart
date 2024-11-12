part of 'discover_bloc.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

final class DiscoverLoading extends DiscoverState {}

final class DiscoverLoaded extends DiscoverState {
  const DiscoverLoaded({
    required this.name,
    required this.image,
  });

  final String name;
  final Uint8List image;

  @override
  List<Object> get props => [name, image];
}

final class DiscoverFailure extends DiscoverState {}
