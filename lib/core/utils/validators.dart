abstract final class Validators {
  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? positiveAmount(String? value) {
    final required = requiredField(value, fieldName: 'Amount');
    if (required != null) return required;

    final amount = double.tryParse(value!.trim());

    if (amount == null || !amount.isFinite || amount <= 0) {
      return 'Enter a valid amount greater than zero';
    }

    return null;
  }

  static String? optionalDescription(String? value) {
    if (value != null && value.length > 500) {
      return 'Description cannot exceed 500 characters';
    }
    return null;
  }
}
