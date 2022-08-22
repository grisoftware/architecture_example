// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../features/shortly_clean/data/datasource/remote/short_link_remote_datasource.dart'
    as _i4;
import '../../../features/shortly_clean/data/repository/remote/data_short_link_remote_repository.dart'
    as _i6;
import '../../../features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart'
    as _i5;
import '../../../features/shortly_clean/domain/usecases/add_short_link.dart'
    as _i7;
import '../../../features/shortly_clean/domain/usecases/get_short_link.dart'
    as _i8;
import '../../../features/shortly_clean/domain/usecases/remove_short_link.dart'
    as _i9;
import '../../../features/shortly_clean/presentation/add_shortlink/cubit/add_shortlink_cubit.dart'
    as _i3;
import '../../../features/shortly_clean/presentation/home/bloc/home_bloc.dart'
    as _i11;
import '../../../features/shortly_clean/presentation/home/home_usecase_provider/home_usecase_provider.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AddShortlinkCubit>(() => _i3.AddShortlinkCubit());
  gh.factory<_i4.ShortLinkRemoteDataSource>(
      () => _i4.ShortLinkRemoteDataSourceImpl());
  gh.factory<_i5.ShortLinkRemoteRepository>(() =>
      _i6.DataShortLinkRemoteRepository(get<_i4.ShortLinkRemoteDataSource>()));
  gh.factory<_i7.AddShortLinkToHistoryList>(() =>
      _i7.AddShortLinkToHistoryList(get<_i5.ShortLinkRemoteRepository>()));
  gh.factory<_i8.GetShortLinksFromHistoryList>(() =>
      _i8.GetShortLinksFromHistoryList(get<_i5.ShortLinkRemoteRepository>()));
  gh.factory<_i9.RemoveShortLinkFromHistoryList>(() =>
      _i9.RemoveShortLinkFromHistoryList(get<_i5.ShortLinkRemoteRepository>()));
  gh.factory<_i10.HomeUseCaseProviderImpl>(() => _i10.HomeUseCaseProviderImpl(
      get<_i7.AddShortLinkToHistoryList>(),
      get<_i9.RemoveShortLinkFromHistoryList>(),
      get<_i8.GetShortLinksFromHistoryList>()));
  gh.factory<_i11.HomeBloc>(
      () => _i11.HomeBloc(get<_i10.HomeUseCaseProviderImpl>()));
  return get;
}
