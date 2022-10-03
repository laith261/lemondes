import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key? key,
    required this.data,
    required this.index,
    required this.delete,
    required this.onsave,
    this.validt,
  }) : super(key: key);
  final Function(int) delete;
  final Function(int, String, String?) onsave;
  final String? Function(String?)? validt;
  final Map data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(7),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(color: Colors.black, spreadRadius: -10, blurRadius: 15)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (index != 0)
                  IconButton(
                      onPressed: () => delete(index),
                      icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            SizedBox(
              width: double.infinity,
              child: FormText(
                onvalid: (value) {
                  if (value!.isEmpty) {
                    return "Fill The Input";
                  }
                  return null;
                },
                value: data["link"],
                label: "Link",
                onsave: (value) => onsave(index, "link", value),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: FormText(
                    onvalid: (value) {
                      if (value!.isEmpty) {
                        return "Fill The Input";
                      }
                      return null;
                    },
                    value: data["color"],
                    label: "Color",
                    onsave: (value) => onsave(index, "color", value),
                  )),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                      child: FormText(
                    onvalid: (value) {
                      if (value!.isEmpty) {
                        return "Fill The Input";
                      }
                      return null;
                    },
                    value: data["size"],
                    label: "Size",
                    onsave: (value) => onsave(index, "size", value),
                  )),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                      child: FormText(
                    onvalid: (value) {
                      if (value!.isEmpty) {
                        return "Fill The Input";
                      }
                      return null;
                    },
                    value: data["quantity"],
                    label: "Quantity",
                    onsave: (value) => onsave(index, "quantity", value),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormText extends StatelessWidget {
  const FormText(
      {Key? key,
      required this.label,
      required this.onsave,
      this.onvalid,
      required this.value})
      : super(key: key);
  final String label;
  final void Function(String?) onsave;
  final String? Function(String?)? onvalid;
  final String value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController()..text = value,
      validator: onvalid,
      onSaved: onsave,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: label,
      ),
    );
  }
}
