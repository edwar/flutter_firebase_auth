import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomInputField(
      {Key? key,
      this.onChanged,
      required this.label,
      this.inputType,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        initialValue: '',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: const TextStyle(
                    color: Color(0xFF80929F), fontSize: 17, letterSpacing: 0.2),
                obscureText: _obscureText,
                keyboardType: widget.inputType,
                onChanged: (text) {
                  if (widget.validator != null) {
                    // ignore: invalid_use_of_protected_member
                    state.setValue(text);
                    state.validate();
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(text);
                  }
                },
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Color(0xFF80929f)),
                    labelText: widget.label,
                    suffixIcon: widget.isPassword
                        ? CupertinoButton(
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF80929f),
                            ),
                            onPressed: () {
                              _obscureText = !_obscureText;
                              setState(() {});
                            })
                        : Container(
                            width: 0,
                          ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF80929f)),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF80929f)),
                    ),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF80929f)))),
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.redAccent),
                )
            ],
          );
        });
  }
}
