import 'package:flutter/material.dart';
import 'package:my_app/core/entities/store_entity.dart';
import 'package:my_app/core/ui/component_styles/text_style.dart';
import 'package:my_app/features/home/presentation/widgets/store_tile_rating_widget.dart';

class StoresListComponentWithRating extends StatelessWidget {
  final String title;
  final List<StoreEntity> storeEntities;
  final double paddingBottom;

  const StoresListComponentWithRating(
      {Key? key, required this.storeEntities, required this.title, this.paddingBottom = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            title,
            style: AppTextStyles.defaultTextStyleTitle,
          ),
          padding: const EdgeInsets.only(left: 20, top: 30),
        ),
        Container(
          margin: EdgeInsets.only(bottom: paddingBottom, top: 20),
          child: Column(
            children: [
              for (int index = 0; index < storeEntities.length; index++)
                buildStoreTileWidget(storeEntities[index], needsToSetStyle(index + 1)),
            ],
          ),
        ),
      ],
    );
  }

  bool needsToSetStyle(int index) {
    if (index % 2 == 1 || index == 0) {
      return true;
    }

    return false;
  }

  buildStoreTileWidget(StoreEntity storeEntity, bool hasToSetStyle) {
    return StoreTileRatingWidget(
      storeEntity: storeEntity,
      border: hasToSetStyle ? Border(bottom: BorderSide(color: Color(0XFFB4D8D8))) : null,
      backgroundColor: hasToSetStyle ? Color.fromRGBO(180, 216, 216, 0.2) : Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
