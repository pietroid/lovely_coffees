import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/discover/bloc/discover_bloc.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';

class DiscoverCarouselItem extends StatefulWidget {
  const DiscoverCarouselItem({super.key});

  @override
  State<DiscoverCarouselItem> createState() => _DiscoverCarouselItemState();
}

class _DiscoverCarouselItemState extends State<DiscoverCarouselItem> {
  late DiscoverBloc _discoverBloc;

  @override
  void initState() {
    _discoverBloc = DiscoverBloc(
      repository: context.read<DiscoverRepository>(),
    )..add(DiscoverLoad());
    super.initState();
  }

  @override
  void dispose() {
    _discoverBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      bloc: _discoverBloc,
      builder: (context, state) {
        return switch (state) {
          DiscoverLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          DiscoverLoaded() => Image.memory(state.image),
          DiscoverFailure() => const Center(
              child: Text('Failed to load image'),
            ),
        };
      },
    );
  }
}
