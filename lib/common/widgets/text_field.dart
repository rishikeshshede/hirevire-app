import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirevire_app/common/widgets/spacing_widget.dart';
import 'package:hirevire_app/constants/color_constants.dart';
import 'package:hirevire_app/themes/text_theme.dart';
import 'package:hirevire_app/utils/size_util.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefix,
    this.prefixText,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.titleText,
    this.textAlign,
    this.showCursor = true,
    this.onBackspacePressed,
    this.readOnly = false,
  });

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefix;
  final String? prefixText;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final Function? onEditingComplete;
  final String? titleText;
  final TextAlign? textAlign;
  final bool showCursor;
  final VoidCallback? onBackspacePressed;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isFocused;
  @override
  void initState() {
    super.initState();
    _isFocused = false;
    widget.focusNode?.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.centerLeft,
            child: textFieldWidget(context),
          )
        : textFieldWidget(context);
  }

  Widget textFieldWidget(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText != null)
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.titleText!,
                style: AppTextThemes.smallText(context)
                    .copyWith(fontSize: 12.5.adaptSize(context)),
              ),
            ),
          const VerticalSpace(),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                if (_isFocused)
                  const BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurRadius: 0,
                    offset: Offset(2, 3),
                  ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (widget.onBackspacePressed != null) {
                    widget.onBackspacePressed!();
                  }
                }
              },
              child: TextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode ?? FocusNode(),
                autofocus: widget.autofocus!,
                style: widget.textStyle ?? AppTextThemes.bodyTextStyle(context),
                obscureText: widget.obscureText!,
                textInputAction: widget.textInputAction,
                keyboardType: widget.textInputType,
                maxLines: widget.maxLines ?? 1,
                // minLines: 1,
                maxLength: widget.maxLength,
                decoration: getDecoration(context),
                validator: widget.validator,
                onChanged: widget.onChanged,
                onEditingComplete: widget.onEditingComplete != null
                    ? () => widget.onEditingComplete!()
                    : null,
                cursorColor: AppColors.primary,
                cursorWidth: 2.5,
                cursorHeight: 22.0,
                cursorRadius: const Radius.circular(2.0),
                showCursor: widget.showCursor,
                textAlign: widget.textAlign ?? TextAlign.left,
                readOnly: widget.readOnly,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration getDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText ?? "",
      hintStyle: widget.hintStyle ??
          AppTextThemes.bodyTextStyle(context).copyWith(
            color: Colors.grey,
          ),
      labelText: widget.labelText ?? "",
      labelStyle: widget.labelStyle ??
          AppTextThemes.bodyTextStyle(context).copyWith(
            color: Colors.grey,
          ),
      prefixIcon: widget.prefix,
      prefixText: widget.prefixText,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      isDense: true,
      counterText: '',
      contentPadding: widget.contentPadding ??
          EdgeInsets.fromLTRB(
              16.h(context), 10.w(context), 16.h(context), 10.w(context)),
      fillColor: widget.fillColor ?? AppColors.background,
      filled: widget.filled,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: widget.borderDecoration ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ),
          ),
      focusedBorder: widget.borderDecoration ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 1,
            ),
          ),
    );
  }
}
