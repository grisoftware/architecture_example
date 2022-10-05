import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../observer/observer.dart';

abstract class UseCase<T, Params> {
  late CompositeSubscription _disposables;

  // Future<Either<Failure, RT>> call(T params);

  UseCase() {
    _disposables = CompositeSubscription();
    // _logger = Logger(runtimeType.toString());
  }

  /// Builds the [Stream] to be subscribed to. [Params] is required
  /// by the [UseCase] to retrieve the appropraite data from the repository
  Future<Stream<T?>> buildUseCaseStream(Params? params);

  /// Subscribes to the [Observerable] with the [Observer] callback functions.
  void execute(Observer<T> observer, [Params? params]) async {
    final StreamSubscription subscription = (await buildUseCaseStream(params))
        .listen(observer.onNext,
            onDone: observer.onComplete, onError: observer.onError);
    _addSubscription(subscription);
  }

  /// Adds a [StreamSubscription] i.e. the subscription to the
  /// [Stream] to the [CompositeSubscription] list of subscriptions.
  void _addSubscription(StreamSubscription subscription) {
    if (_disposables.isDisposed) {
      _disposables = CompositeSubscription();
    }
    _disposables.add(subscription);
  }

  /// Disposes (unsubscribes) from the [Stream]
  void dispose() {
    if (!_disposables.isDisposed) {
      // logger.info('Disposing $runtimeType');
      _disposables.dispose();
    }
  }
}

// abstract class NoneFutureUseCase<RT, T> {
//   Either<Failure, RT?> call(T params);
// }

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
