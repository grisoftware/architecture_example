import 'package:dartz/dartz.dart';
import 'package:shortly_clean/features/shortly_clean/domain/entities/short_link_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecase/usecase.dart';

abstract class ShortLinkCacheRepository {
  Future<Either<Failure, List<ShortLink>>> getValues(
    NoParams params,
  );
  Future<Either<Failure, void>> init(
    NoParams params,
  );
  Future<Either<Failure, void>> addItem(
    String functionId,
    List<ShortLink> entities,
  );
  Future<Either<Failure, void>> clearAll(
    NoParams params,
  );
}
