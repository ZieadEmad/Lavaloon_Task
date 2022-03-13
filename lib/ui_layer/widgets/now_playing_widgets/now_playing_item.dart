import 'package:flutter/material.dart';
import 'package:lavaloon/ui_layer/helpers/text_trim/text_trim.dart';
import 'package:lavaloon/ui_layer/shared_widgets/image_place_holder/image_place_holder.dart';

class NowPlayingItem extends StatelessWidget {
  NowPlayingItem({
    Key? key,
    required this.imagePath,
    required this.details,
    required this.description,
    required this.favoritePress,
  }) : super(key: key);
  String imagePath ;
  String details ;
  String description ;
  VoidCallback favoritePress ;
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              //color: Colors.red,
              child: ImagePlaceHolder(imagePath.toString()),
            ),
            SizedBox(width: MediaQuery.of(context).size.width/20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(textTrim(25, details.toString()),maxLines: 1,overflow:TextOverflow.ellipsis,softWrap: true,),
                      IconButton(onPressed: favoritePress, icon:const Icon(Icons.favorite))
                    ],
                  ),
                 const SizedBox(height: 8,),
                  Text(description.toString(),maxLines: 5,overflow:TextOverflow.ellipsis,softWrap: true,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
