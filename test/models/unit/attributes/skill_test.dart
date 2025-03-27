import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/pages/roster/models/unit/skill.dart';

void main() {
  group('Skill', () {
    test('should create Skill with valid value', () {
      const validSkillValue = 4;
      const skill = Skill(validSkillValue);
      expect(skill.value, validSkillValue);
    });

    test('should throw assertion error for negative value', () {
      const invalidSkillValue = -1;
      expect(() => Skill(invalidSkillValue), throwsAssertionError);
    });
  });
}
