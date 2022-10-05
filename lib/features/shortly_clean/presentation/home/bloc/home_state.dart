// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeBaseState extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class HomeState extends HomeBaseState {
  List<ShortLink> shortLinks;
  final List<String> fullLinks;
  final String url;
  final bool isAddButtonPressed;

  HomeState({
    required this.shortLinks,
    required this.fullLinks,
    required this.url,
    required this.isAddButtonPressed,
  });

  @override
  List<Object> get props => [
        shortLinks,
        fullLinks,
        url,
        isAddButtonPressed,
      ];

  HomeState copyWith({
    List<ShortLink>? shortLinks,
    List<String>? fullLinks,
    String? url,
    bool? isAddButtonPressed,
  }) {
    return HomeState(
      shortLinks: shortLinks ?? this.shortLinks,
      fullLinks: fullLinks ?? this.fullLinks,
      url: url ?? this.url,
      isAddButtonPressed: isAddButtonPressed ?? this.isAddButtonPressed,
    );
  }
}
