import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  final String? textTitle;
  final String? text;

  const ExpandedWidget({
    super.key,
    required this.textTitle,
    required this.text,
  });

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text != null && widget.text!.isNotEmpty) {
      if (widget.text!.length > 100) {
        firstHalf = widget.text!.substring(0, 100);
        secondHalf = widget.text!.substring(100, widget.text!.length);
      } else {
        firstHalf = widget.text!;
        secondHalf = "";
      }
    } else {
      firstHalf = "";
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.textTitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: secondHalf.length == ""
              ? Text(
                  widget.text!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    Text(
                      flag ? firstHalf : widget.text!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                      child: Row(
                        children: [
                          const Text(
                            "Show more",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          Icon(
                            flag
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
