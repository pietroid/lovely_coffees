import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/discover/bloc/discover_bloc.dart';
import 'package:my_app/discover/data/repositories/discover_repository.dart';
import 'package:my_app/discover/view/widgets/beating_heart.dart';
import 'package:my_app/favorites/blocs/favorites/favorites_bloc.dart';
import 'package:my_app/l10n/l10n.dart';

class DiscoverCarouselItem extends StatefulWidget {
  const DiscoverCarouselItem({super.key});

  @override
  State<DiscoverCarouselItem> createState() => _DiscoverCarouselItemState();
}

class _DiscoverCarouselItemState extends State<DiscoverCarouselItem> {
  late DiscoverBloc _discoverBloc;
  bool isFavorited = false;

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
          DiscoverLoaded() => Stack(alignment: Alignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: GestureDetector(
                    onDoubleTap: () {
                      context.read<FavoritesBloc>().add(
                            FavoritesAdd(
                              image: state.image,
                              imageUrl: state.name,
                            ),
                          );
                      setState(() {
                        isFavorited = true;
                      });
                    },
                    child: Image.memory(state.image),
                  ),
                ),
              ),
              if (isFavorited) HeartBeatAnimation(),
            ]),
          DiscoverFailure() => Center(
              child: Text(context.l10n.imageLoadingErrorText),
            ),
        };
      },
    );
  }
}
