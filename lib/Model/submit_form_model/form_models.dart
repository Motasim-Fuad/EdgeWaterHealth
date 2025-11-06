// Form Field Data Model
class FormFieldData {
  final String label;
  final bool isDropdown;
  final FieldType fieldType;

  FormFieldData({
    required this.label,
    required this.isDropdown,
    required this.fieldType,
  });
}

// FieldType Enum
enum FieldType {
  referralSource,
  county,
  crisisType,
  outcome,
  referralType,
  insurance,
  ageGroup,
  veteranStatus,
  servingMilitary,
  number,
  time,
  referralStabilization,
}