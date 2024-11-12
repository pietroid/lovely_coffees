import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/discover/bloc/discover_bloc.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/favorites/blocs/favorites/favorites_bloc.dart';

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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BlocBuilder<DiscoverBloc, DiscoverState>(
          bloc: _discoverBloc,
          builder: (context, state) {
            return switch (state) {
              DiscoverLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              DiscoverLoaded() => GestureDetector(
                  onDoubleTap: () => context.read<FavoritesBloc>().add(
                        FavoritesAdd(
                          image: state.image,
                          imageUrl: state.name,
                        ),
                      ),
                  child: Image.memory(state.image),
                ),
              DiscoverFailure() => const Center(
                  child: Text('Failed to load image'),
                ),
            };
          },
        ),
      ),
    );
  }
}
