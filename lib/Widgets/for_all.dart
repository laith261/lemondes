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

class BottomButton extends StatelessWidget {
  const BottomButton(
      {Key? key, required this.function, required this.text, this.size = 17})
      : super(key: key);
  final void Function()? function;
  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count(
      {Key? key,
      required this.count,
      required this.increase,
      required this.decrease})
      : super(key: key);
  final int count;
  final Function()? increase;
  final Function()? decrease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipOval(
            child: InkWell(
              onTap: decrease,
              child: SizedBox(
                width: 30,
                height: 30,
                child: Opacity(
                  opacity: decrease == null ? 0.3 : 1,
                  child: ColoredBox(
                    color: Colors.white.withOpacity(.4),
                    child: const Icon(Icons.remove, size: 20),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            duration: const Duration(milliseconds: 250),
            child: Text(
              "$count",
              style: const TextStyle(fontSize: 18),
              key: ValueKey<int>(count),
            ),
          ),
          ClipOval(
            child: InkWell(
              onTap: increase,
              child: SizedBox(
                width: 30,
                height: 30,
                child: ColoredBox(
                  color: Colors.white.withOpacity(.4),
                  child: const Icon(Icons.add, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
