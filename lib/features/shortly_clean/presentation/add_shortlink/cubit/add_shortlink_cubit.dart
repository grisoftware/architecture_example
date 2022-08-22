import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'add_shortlink_state.dart';

@injectable
class AddShortlinkCubit extends Cubit<AddShortlinkState> {
  AddShortlinkCubit() : super(AddShortlinkInitial());
}
