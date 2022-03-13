import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  String imageLink;
  ImagePlaceHolder(this.imageLink);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageLink,
      fit: BoxFit.cover,
      placeholder: (context, url) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/icons/loading.png',scale: 0.5,height: 100,width: 100,),
      ),
      errorWidget: (context, url, error) =>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/loading.png',scale: 0.5,height: 100,width: 100,),
          ),
    );
  }
}
