import 'package:auto_direction/auto_direction.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MEditText extends StatelessWidget {
  final BuildContext context;
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final Function(String?)? onSubmit;
  final int? maxLines;

  final TextEditingController textController = TextEditingController();

  MEditText({
    Key? key,
    required this.context,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.onSubmit,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textController.text = text;

    return GestureDetector(
      onTap: () async {
        var data = await Tools.textEditDialog(
          context: context,
          text: text,
          maxLines: maxLines!,
        );

        onSubmit!(data?["text"]);
      },
      child: AutoDirection(
        text: text,
        onDirectionChange: (val) {},
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Text(
                  text,
                  style: textStyle,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MEditTextBadge extends StatelessWidget {
  final BuildContext context;
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool verified;
  final Function(dynamic)? onSubmit;

  final TextEditingController textController = TextEditingController();

  MEditTextBadge({
    Key? key,
    required this.context,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.start,
    required this.verified,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    textController.text = text;

    return GestureDetector(
      onTap: () async {
        var data = await Tools.textEditDialog(
          context: context,
          text: text,
          maxLines: 1,
          verifiedButton: verified,
        );

        onSubmit!(data);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              style: textStyle,
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 4.0),
          verified
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SvgPicture.asset(
                    'assets/icons/verified_badge.svg',
                    width: 12.0,
                  ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
