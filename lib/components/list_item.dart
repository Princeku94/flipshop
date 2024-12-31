import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.image,
    required this.title,
    required this.model,
    required this.price,
    this.height = 150,
    this.width = 150,
    required this.onTap,
  });

  final String image;
  final String title;
  final String model;
  final String price;
  final double height;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 0),
                  blurRadius: 15,
                  spreadRadius: 1),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                bottomRight: Radius.circular(45))),
        margin: EdgeInsets.all(10),
        child: Row(
          spacing: 15,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    // child: Image.network(
                    //   image,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      model,
                      maxLines: 1,
                    ),
                    Text(
                      '⭐ ⭐ ⭐ ⭐ ⭐',
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Rs.$price',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
