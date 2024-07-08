import 'package:flutter/material.dart';

class Rule {
  final bool Function(String) valid;
  final String message;

  Rule({required this.valid, required this.message});
}

class FormItem extends StatefulWidget {
  final String name;
  final bool isSubmitted;
  final bool showRules;
  final List<Rule> rules;
  final Widget child;

  const FormItem(
      {super.key,
      required this.name,
      required this.isSubmitted,
      this.showRules = false,
      this.rules = const [],
      required this.child});

  @override
  FormItemState createState() => FormItemState();
}

class FormItemState extends State<FormItem> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, TextEditingValue value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KeyedSubtree(
                key: widget.child.key,
                child: (widget.child is TextFormField)
                    ? TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: widget.name,
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: const TextStyle(height: 0),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: widget.isSubmitted
                                ? const BorderSide(
                                    color: Colors.green, width: 1)
                                : BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: widget.isSubmitted
                                ? const BorderSide(
                                    color: Colors.green, width: 1)
                                : BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: widget.isSubmitted
                                ? const BorderSide(
                                    color: Colors.green, width: 1)
                                : const BorderSide(
                                    color: Colors.grey, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          hintText: null,
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (_) {
                          for (Rule rule in widget.rules) {
                            if (!rule.valid(controller.text)) {
                              return '';
                            }
                          }
                          return null;
                        },
                      )
                    : widget.child),
            if (widget.isSubmitted &&
                !widget.showRules &&
                widget.rules.isNotEmpty &&
                widget.rules.any((rule) => !rule.valid(value.text)))
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  widget.rules
                      .firstWhere((rule) => !rule.valid(value.text))
                      .message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (widget.showRules && widget.rules.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.rules
                    .map(
                      (rule) => Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8),
                        child: Text(
                          rule.message,
                          style: TextStyle(
                            color: rule.valid(value.text)
                                ? Colors.green
                                : widget.isSubmitted
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
          ],
        );
      },
    );
  }
}
