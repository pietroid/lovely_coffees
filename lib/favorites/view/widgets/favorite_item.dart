import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/favorites/blocs/favorite_item/favorite_item_bloc.dart';
import 'package:my_app/favorites/data/repositories/favorites_item_repository.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({
    required this.name,
    super.key,
  });
  final String name;

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  late FavoriteItemBloc _favoriteItemBloc;

  @override
  void initState() {
    _favoriteItemBloc = FavoriteItemBloc(
      favoriteItemRepository: context.read<FavoriteItemRepository>(),
    )..add(FavoriteItemLoad(
        name: widget.name,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteItemBloc, FavoriteItemState>(
      builder: (context, state) {
        return switch (state) {
          FavoriteItemLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          FavoriteItemLoaded() => Image.memory(state.image),
        };
      },
    );
  }
}
