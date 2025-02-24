import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:wond3rcard/src/utils/decoration_box.dart';
import 'package:wond3rcard/src/utils/size_constants.dart';
import 'package:wond3rcard/src/utils/wonder_card_colors.dart';
import 'package:wond3rcard/src/utils/wonder_card_strings.dart';
import 'package:wond3rcard/src/utils/wonder_card_typography.dart';

enum TextFieldType { defaultType, Email, Password, Number }

class CustomTextField extends StatefulWidget {
  final TextFieldType type;
  final String hintText;
  final bool isRequired;
  final String? text;
  final String? errorText;
  final double? width;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final Function()? onPressEnter;
  final Function(String value)? onChange;
  final bool enabled;
  final bool required;
  final Color? borderColor;
  final double? borderRadius;
  final Color? textColor;
  final Color? hintColor;
  final Function()? onTap;
  final bool isDropDown;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final TextAlign? textAlign;

  const CustomTextField({
    super.key,
    this.type = TextFieldType.defaultType,
    required this.hintText,
    this.borderColor,
    this.suffixIcon,
    this.isRequired = false,
    this.onChange,
    this.inputType,
    this.text,
    this.borderRadius,
    this.textColor,
    this.required = false,
    this.textEditingController,
    this.maxLines = 1,
    this.width,
    this.hintColor,
    this.errorText,
    this.onTap,
    this.validator,
    this.isDropDown = false,
    this.onPressEnter,
    this.inputFormatter,
    this.prefixIcon,
    this.fillColor,
    this.enabled = true,
    this.textAlign,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  late String hintText;
  final bool _isValid = true;
  final bool _userFinishedTyping = false;

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  HeroIcon? getSuffixIcon() {
    if (_userFinishedTyping) {
      return _isValid ? DecorationBox.validIcon() : DecorationBox.cancelIcon();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fieldWidth = widget.width ?? constraints.maxWidth;
        Widget? suffixIcon = widget.suffixIcon;
        if (widget.type == TextFieldType.Password) {
          suffixIcon = GestureDetector(
            onTap: _toggleObscured,
            child: Icon(_obscured ? Icons.visibility : Icons.visibility_off),
          );
        }

        // Ensure correct input formatters based on field type
        List<TextInputFormatter> formatters = widget.inputFormatter ?? [];
        TextInputType keyboardType = widget.inputType ?? TextInputType.text;

        if (widget.type == TextFieldType.Number) {
          keyboardType = TextInputType.number;
          formatters.add(FilteringTextInputFormatter.digitsOnly);
        }

        return SizedBox(
          width: fieldWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.text != null && widget.text!.isNotEmpty)
                Row(
                  children: [
                    Text(
                      widget.text ?? AppStrings.emptyString,
                      style: WonderCardTypography.hintTextSytle(
                        color: widget.textColor ?? AppColors.grayScale800,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    if (widget.required)
                      Text(
                        " *",
                        style: WonderCardTypography.hintTextSytle(
                          color: AppColors.warning,
                        ).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: SpacingConstants.size15,
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 8),
              InkWell(
                onTap: widget.onTap,
                child: TextFormField(
                  keyboardType: keyboardType,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  validator: widget.validator,
                  focusNode: textFieldFocusNode,
                  controller: widget.textEditingController,
                  inputFormatters: formatters,
                  obscureText:
                      widget.type == TextFieldType.Password && _obscured,
                  onEditingComplete: widget.onPressEnter,
                  onChanged: widget.onChange,
                  maxLines: widget.maxLines,
                  enabled: widget.enabled,
                  decoration: InputDecoration(
                    errorText: widget.errorText,
                    hintText: widget.hintText,
                    hintStyle: WonderCardTypography.hintTextSytle(
                      color: widget.hintColor ?? AppColors.grayScale400,
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon ??
                        (widget.isDropDown
                            ? const Icon(
                                Icons.keyboard_arrow_down,
                              )
                            : suffixIcon),
                    filled: true,
                    errorBorder: DecorationBox.customOutlineBorderSideAndRadius(
                      color: widget.borderColor ?? AppColors.grayScale50,
                    ).copyWith(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? SpacingConstants.size5,
                      ),
                    ),
                    fillColor: widget.fillColor ?? AppColors.grayScale50,
                    enabledBorder:
                        DecorationBox.customOutlineBorderSideAndRadius(
                      color: widget.borderColor ?? AppColors.grayScale50,
                    ).copyWith(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? SpacingConstants.size5,
                      ),
                    ),
                    focusedBorder: DecorationBox.customOutlineBorder(
                      color: widget.borderColor ?? AppColors.primaryShade500,
                      width: SpacingConstants.size1point5,
                    ).copyWith(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? SpacingConstants.size5,
                      ),
                    ),
                    disabledBorder: DecorationBox.customOutlineBorder(
                      color: widget.borderColor ?? AppColors.primaryShade500,
                      width: SpacingConstants.size1point5,
                    ).copyWith(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? SpacingConstants.size5,
                      ),
                    ),
                  ),
                  cursorColor: widget.borderColor ?? AppColors.primaryShade500,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
