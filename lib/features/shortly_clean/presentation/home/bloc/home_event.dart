// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Init extends HomeEvent {
  const Init();
  @override
  List<Object> get props => [];
}

class OnShortenItButtonPressed extends HomeEvent {
  String url = '';
  OnShortenItButtonPressed(this.url);
  @override
  List<Object> get props => [url];
}

class OnGetShortLinks extends HomeEvent {
  const OnGetShortLinks();
  @override
  List<Object> get props => [];
}

class RemoveShortLinkFromHistory extends HomeEvent {
  String shortLinkId = '';
  RemoveShortLinkFromHistory(this.shortLinkId);
  @override
  List<Object> get props => [];
}

class OnUrlTextFormFieldChanged extends HomeEvent {
  String textFieldValue = '';
  OnUrlTextFormFieldChanged(this.textFieldValue);
  @override
  List<Object> get props => [];
}

class CopyItemToClipboard extends HomeEvent {
  ShortLink shortLink;
  CopyItemToClipboard(
    this.shortLink,
  );
  @override
  List<Object> get props => [];
}
