import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Functions/Functions.dart';

// loading widget
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary),
          value: null,
        ),
      ),
    );
  }
}

// show empty widget
class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        child: Column(
          children: const [
            Icon(Icons.cloud_off_rounded, size: 70),
            SizedBox(
              height: 10,
            ),
            Text("empty",
                style: TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.img, this.fit, this.size = 150})
      : super(key: key);
  final String img;
  final BoxFit? fit;
  final int? size;

  @override
  Widget build(BuildContext context) {
    return img.substring(img.length - 3) == "svg"
        ? SvgPicture.network(
            "$link/uploads/$img",
            placeholderBuilder: (context) => const Loading(),
            fit: fit ?? BoxFit.contain,
            clipBehavior: Clip.hardEdge,
          )
        : CachedNetworkImage(
            placeholder: (context, i) => const Loading(),
            imageUrl: "$link/imgs1.php?size=$size&img=$img",
            fit: fit,
          );
  }
}

// costume input widget
class MyInput extends StatelessWidget {
  const MyInput({
    Key? key,
    required this.label,
    this.hideText = false,
    this.value,
    this.save,
    this.valida,
    this.onlyRead = false,
    this.controller,
  }) : super(key: key);
  final bool hideText;
  final String? value;
  final String label;
  final Function(String?)? save;
  final String? Function(String?)? valida;
  final bool onlyRead;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Opacity(
          opacity: onlyRead ? 0.9 : 1,
          child: TextFormField(
            controller: controller,
            readOnly: onlyRead,
            validator: valida,
            style: const TextStyle(color: Colors.white),
            obscureText: hideText,
            initialValue: value,
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(.9),
              floatingLabelAlignment: FloatingLabelAlignment.center,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
              ),
            ),
            onSaved: save,
          ),
        ),
      ],
    );
  }
}
