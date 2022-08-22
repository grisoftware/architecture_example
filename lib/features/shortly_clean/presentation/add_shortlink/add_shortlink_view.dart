import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly_clean/features/shortly_clean/presentation/add_shortlink/cubit/add_shortlink_cubit.dart';

import '../../../../core/config/dependency/injectable.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddShortlinkCubit>(),
      child: Scaffold(
        body: BlocBuilder<AddShortlinkCubit, AddShortlinkState>(
          builder: (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
