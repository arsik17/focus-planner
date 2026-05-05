import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';

class SubtaskInput extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const SubtaskInput({super.key, required this.onSubmit});

  @override
  State<SubtaskInput> createState() => _SubtaskInputState();
}

class _SubtaskInputState extends State<SubtaskInput> {
  final _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSubmit(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        controller: _controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Add subtask...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          suffixIcon: GestureDetector(
            onTap: _submit,
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppPallete.accentColor2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ),
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}
