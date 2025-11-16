import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpField extends StatefulWidget {
  final int length;
  final void Function(String code)? onCompleted;

  const CustomOtpField({super.key, this.length = 4, this.onCompleted});

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  late List<FocusNode> nodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    nodes = List.generate(widget.length, (_) => FocusNode());
    controllers = List.generate(widget.length, (_) => TextEditingController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      nodes.first.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 45,
          height: 60,
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event is RawKeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                if (controllers[index].text.isEmpty && index > 0) {
                  controllers[index - 1].clear();
                  nodes[index - 1].requestFocus();
                }
              }
            },
            child: TextField(
              controller: controllers[index],
              focusNode: nodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,

              decoration: const InputDecoration(
                counterText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary500, width: 4),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary500, width: 4),
                ),
              ),

              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index + 1 < widget.length) {
                    nodes[index + 1].requestFocus();
                  } else {
                    _submitOtp();
                  }
                }
              },
            ),
          ),
        );
      }),
    );
  }

  void _submitOtp() {
    final code = controllers.map((c) => c.text).join();
    widget.onCompleted?.call(code);
  }
}
