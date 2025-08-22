import 'package:flutter/material.dart';

import '../../core/theme/pallets.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final BorderRadius? borderRadius;
  final double? elevation;

  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.bgColor,
      this.padding,
      this.isExpanded = true,
      this.foregroundColor,
      this.borderRadius,
      this.elevation})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: widget.isExpanded! ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffE67002),
                  Color(0xffE67002),
                  Color(0xff992002)
                ]),
                  borderRadius:
                  widget.borderRadius ?? BorderRadius.circular(10)
              ),
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: widget.elevation,
                  padding: widget.padding ?? const EdgeInsets.all(15),
                  foregroundColor: widget.foregroundColor ??
                      Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10)),
                  disabledBackgroundColor: widget.bgColor == null
                      ? Theme.of(context).colorScheme.primary.withAlpha(-200)
                      : widget.bgColor!.withAlpha(-200),
                  backgroundColor:
                      widget.bgColor ?? Colors.transparent,

                ),
                child: widget.child,
              ),
            )),
      ],
    );
  }
}

class OutlinedGoogleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool? isExpanded;
  final BorderRadius? borderRadius;
  final double? elevation;

  const OutlinedGoogleButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.bgColor,
      this.foregroundColor,
      this.padding,
      this.isExpanded,
      this.borderRadius,
      this.elevation});

  @override
  State<OutlinedGoogleButton> createState() => _OutlinedGoogleButtonState();
}

class _OutlinedGoogleButtonState extends State<OutlinedGoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            flex: widget.isExpanded??false? 1 : 0,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                elevation: widget.elevation,
                padding: widget.padding ?? const EdgeInsets.all(13),
                foregroundColor: widget.foregroundColor ??
                    Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(5),
                side: BorderSide(color: Pallets.orange)),
                disabledBackgroundColor: widget.bgColor == null
                    ? Theme.of(context).colorScheme.primary.withAlpha(-200)
                    : widget.bgColor!.withAlpha(-200),
                backgroundColor:
                    widget.bgColor ?? Pallets.normalwhite,
              ),
              child: widget.child,
            )),
      ],
    );
  }
}
