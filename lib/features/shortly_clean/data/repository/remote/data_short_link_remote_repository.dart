import 'package:injectable/injectable.dart';
import 'package:shortly_clean/features/shortly_clean/data/datasource/remote/short_link_remote_datasource.dart';
import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';
import 'package:shortly_clean/core/usecase/usecase.dart';
import 'package:shortly_clean/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

typedef _Get = Future<List<ShortLink>> Function();
typedef _Remove = Future<void> Function();
typedef _Add = Future<void> Function();

@Injectable(as: ShortLinkRemoteRepository)
class DataShortLinkRemoteRepository implements ShortLinkRemoteRepository {
  final ShortLinkRemoteDataSource _shortLinkRemoteDataSource;

  DataShortLinkRemoteRepository(
      ShortLinkRemoteDataSource shortLinkRemoteDataSource)
      : _shortLinkRemoteDataSource = shortLinkRemoteDataSource;

  Future<Either<Failure, List<ShortLink>>> _getValues(
    _Get getList,
  ) async {
    try {
      final result = await getList();

      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> _remove(
    _Remove remove,
  ) async {
    try {
      final result = await remove();

      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, void>> _add(
    _Add add,
  ) async {
    try {
      final result = await add();

      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addShortLinkToHistoryList(String url) async {
    return _add(() async {
      await _shortLinkRemoteDataSource.addShortLinkToHistoryList(url);
    });
  }

//TODO: NULL CHECK TO FLOW
  @override
  Future<Either<Failure, List<ShortLink>>> getShortLinksFromHistory(
      NoParams noParams) async {
    return _getValues(() async {
      final result =
          await _shortLinkRemoteDataSource.getShortLinksFromHistory(NoParams());

      return result
          .map(
            (e) => ShortLink(
              id: e.id,
              fullShortLink: e.fullShortLink,
            ),
          )
          .toList();
    });
  }

  @override
  Future<Either<Failure, void>> removeShortLinkFromHistory(String shortLinkId) {
    return _remove(() async {
      await _shortLinkRemoteDataSource.removeShortLinkFromHistory(shortLinkId);
    });
  }
}
