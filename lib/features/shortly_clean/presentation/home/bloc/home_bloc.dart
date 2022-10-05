import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';
import 'package:shortly_clean/features/shortly_clean/presentation/home/home_presenter.dart';

import '../../../data/model/short_link_model.dart';
import '../../../domain/entities/short_link_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> with ChangeNotifier {
  // final HomeUseCaseProviderImpl _useCaseProvider;
  final TextEditingController editingController = TextEditingController();
  List<ShortLink> shortLinkList = [];
  final HomePresenter _presenter;

  HomeBloc(ShortLinkRemoteRepository remoteRepository)
      : _presenter = HomePresenter(remoteRepository),
        super(HomeState(
          shortLinks: const [],
          fullLinks: const [],
          url: '',
          isAddButtonPressed: false,
        )) {
    on<Init>((event, emit) async {
      return await _onInit(event, emit);
    });
    on<OnShortenItButtonPressed>(onShortenItButtonPressed);
    on<RemoveShortLinkFromHistory>(removeShortLinkFromHistory);
    on<OnUrlTextFormFieldChanged>(onUrlTextFormFieldChanged);
    on<CopyItemToClipboard>(copyItemToClipboard);
    on<OnGetShortLinks>(_onGetShortLinks);
  }

  Future<void> _onInit(
    Init event,
    Emitter<HomeState> emit,
  ) async {
    _presenter.getShortLinks();
    initListeners();

    // result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());
    // emit(state.copyWith(shortLinks: shortLinkList));
  }

  @mustCallSuper
  void initListeners() {
    _presenter.getShortLinkOnNext = (List<ShortLinkModel> response) {
      shortLinkList = response
          .map(
            (e) => ShortLink(
              id: e.id,
              fullShortLink: e.fullShortLink,
            ),
          )
          .toList();

      add(const OnGetShortLinks());
    };

    _presenter.getShortLinkOnError = (e) {};

    _presenter.addShortLinkOnComplete = () {
      // ignore: avoid_print
      print("complete");
    };

    _presenter.addShortLinkOnError = (e) {};

    _presenter.removeShortLinkOnComplete = () {};

    _presenter.removeShortLinkOnError = (e) {};
  }

  Future<void> _onGetShortLinks(
    OnGetShortLinks event,
    Emitter<HomeState> emit,
  ) async {
    // final result = await _presenter.ge(NoParams());

    // result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());
    // print(shortLinkList);
    emit(state.copyWith(shortLinks: shortLinkList));
  }

  Future<void> addShortLinkToHistoryList(String url) async {
    _presenter.addShortLinks(url);
  }

  void onShortenItButtonPressed(
    OnShortenItButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isAddButtonPressed: true));
    if (state.fullLinks.contains(event.url)) state.fullLinks.add(event.url);

    await addShortLinkToHistoryList(event.url);

    // await getShortLinks(emit);

    editingController.clear();
    // emit(state.copyWith(isAddButtonPressed: true));
  }

  Future<void> getShortLinks(
    Emitter<HomeState> emit,
  ) async {
    _presenter.getShortLinks();

    // result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());

    emit(state.copyWith(shortLinks: shortLinkList, isAddButtonPressed: false));
  }

  void removeShortLinkFromHistory(
    RemoveShortLinkFromHistory event,
    Emitter<HomeState> emit,
    // String shortLinkId
  ) {
    _presenter.removeShortLink(event.shortLinkId);

    getShortLinks(emit);
  }

  void onUrlTextFormFieldChanged(
    OnUrlTextFormFieldChanged event,
    Emitter<HomeState> emit,
    // String value
  ) {
    emit(state.copyWith(url: event.textFieldValue));
  }

  void copyItemToClipboard(
    CopyItemToClipboard event,
    Emitter<HomeState> emit,
    // ShortLink shortLink
  ) async {
    await Clipboard.setData(ClipboardData(text: event.shortLink.fullShortLink));
    // final ClipboardData? _data = await Clipboard.getData('text/plain');

    // ignore: avoid_function_literals_in_foreach_calls
    state.shortLinks.forEach(
      (element) {
        element.id == event.shortLink.id
            ? element.isCopied = true
            : element.isCopied = false;
      },
    );
  }
}
