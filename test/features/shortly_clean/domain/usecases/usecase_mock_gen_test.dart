import 'package:mockito/annotations.dart';
import 'package:shortly_clean/features/shortly_clean/domain/repository/remote/short_link_remote_repository.dart';

// we need this for generating mocks
// After null safety we should use GenerateMocks for Mockito
// This generated Mock repository is a common repo so we can use it fot RemoveShortlinkUsecase too. (without generating)
@GenerateMocks([
  ShortLinkRemoteRepository
], customMocks: [
  MockSpec<ShortLinkRemoteRepository>(
      as: #FakeRepo, onMissingStub: OnMissingStub.throwException),
])
void main() {}
