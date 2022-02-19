import 'package:flutter/material.dart';
import 'package:news_app_flutter/modules/article.dart';

Widget buildArticleItem({
  required String? imageUrl,
  required String title,
  required String date,
  required BuildContext context,
  required String url,
}) {
  return InkWell(
    onTap: () {
      navigateTo(context: context, screen: ArticleScreen(url));
    },
    child: Container(
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
                    maxLines: 4,
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
    ),
  );
}

DefaultFormField(
  String labelText,
  TextEditingController controller, {
  bool obscureText = false,
  Icon? prefixIcon,
  Icon? suffixIcon,
  TextInputType? keyboardType,
  GestureTapCallback? onFieldTap,
  bool? isReadOnly,
  FormFieldValidator? validator,
  ValueChanged<String>? onFieldChanged,
}) {
  return TextFormField(
    onChanged: onFieldChanged,
    onTap: onFieldTap,
    keyboardType: keyboardType,
    controller: controller,
    obscureText: obscureText,
    readOnly: isReadOnly ?? false,
    validator: validator,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: labelText,
    ),
  );
}

void navigateTo({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return screen;
    }),
  );
}
