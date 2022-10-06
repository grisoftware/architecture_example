import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/add_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/domain/usecases/remove_short_link.dart';
import 'package:shortly_clean/features/shortly_clean/presentation/home/home_usecase_provider/home_usecase_provider.dart';

import '../../../domain/entities/short_link_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCaseProviderImpl _useCaseProvider;
  final TextEditingController editingController = TextEditingController();
  List<ShortLink> shortLinkList = [];

  HomeBloc(HomeUseCaseProviderImpl useCaseProviderImpl)
      : _useCaseProvider = useCaseProviderImpl,
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
    final result = await _useCaseProvider.getShortLinksFromHistory(NoParams());

    result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());
    emit(state.copyWith(shortLinks: shortLinkList));
  }

  Future<void> _onGetShortLinks(
    OnGetShortLinks event,
    Emitter<HomeState> emit,
  ) async {
    final result = await _useCaseProvider.getShortLinksFromHistory(NoParams());

    result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());
    // print(shortLinkList);
    emit(state.copyWith(shortLinks: shortLinkList));
  }

  Future<void> addShortLinkToHistoryList(String url) async {
    await _useCaseProvider
        .addShortLinkToHistoryList(AddShortLinkToHistoryListParams(url));
  }

  void onShortenItButtonPressed(
    OnShortenItButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isAddButtonPressed: true));
    if (state.fullLinks.contains(event.url)) state.fullLinks.add(event.url);

    await addShortLinkToHistoryList(event.url);

    await getShortLinks(emit);

    editingController.clear();
    // emit(state.copyWith(isAddButtonPressed: true));
  }

  Future<void> getShortLinks(
    Emitter<HomeState> emit,
  ) async {
    final result = await _useCaseProvider.getShortLinksFromHistory(NoParams());

    result.fold((l) => null, (r) => shortLinkList = r.map((e) => e).toList());

    emit(state.copyWith(shortLinks: shortLinkList, isAddButtonPressed: false));
  }

  void removeShortLinkFromHistory(
    RemoveShortLinkFromHistory event,
    Emitter<HomeState> emit,
    // String shortLinkId
  ) {
    _useCaseProvider.removeShortLinkFromHistory(
        RemoveShortLinkFromHistoryListParams(event.shortLinkId));

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
