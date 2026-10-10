// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/utils/validators.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _type = 'Subscriptions';
  String _plan = 'Monthly';
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('CREDIT TYPE'),
                DropdownButtonFormField<String>(
                  value: _type,
                  items: const [
                    DropdownMenuItem(
                      value: 'Subscriptions',
                      child: Text('Subscriptions'),
                    ),
                    DropdownMenuItem(
                      value: 'One-Time',
                      child: Text('One-Time'),
                    ),
                    DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _type = value);
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _nameController,
                  label: 'To',
                  validator: (value) =>
                      Validators.requiredField(value, fieldName: 'Name'),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Date'),
                  subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
                  trailing: IconButton(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('PLAN TYPE'),
                DropdownButtonFormField<String>(
                  value: _plan,
                  items: const [
                    DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                    DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
                    DropdownMenuItem(
                      value: 'One-Time',
                      child: Text('One-Time'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _plan = value);
                  },
                ),
                const SizedBox(height: 18),
                AppButton(
                  label: 'Save',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Credit storage will be connected next.'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Your Saved Lists',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'No saved items yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
