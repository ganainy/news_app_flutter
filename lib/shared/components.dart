import 'package:flutter/material.dart';

Widget buildArticleItem({
  required String? imageUrl,
  required String title,
  required String date,
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    height: 120,
    child: Row(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            //sometimes the api doesnt return image url so we use placeholder instead
            child: imageUrl != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/no_image.png',
                    image: imageUrl,
                    fit: BoxFit.fill,
                  )
                : Image.asset('assets/images/no_image.png'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  /*  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),*/
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
