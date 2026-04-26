enum GolonganDarah {
  a,
  b,
  ab,
  o,
  aPos,
  aNeg,
  bPos,
  bNeg,
  abPos,
  abNeg,
  oPos,
  oNeg,
}

extension GolonganDarahExtension on GolonganDarah {
  String get value {
    switch (this) {
      case GolonganDarah.a:
        return 'A';
      case GolonganDarah.b:
        return 'B';
      case GolonganDarah.ab:
        return 'AB';
      case GolonganDarah.o:
        return 'O';
      case GolonganDarah.aPos:
        return 'A+';
      case GolonganDarah.aNeg:
        return 'A-';
      case GolonganDarah.bPos:
        return 'B+';
      case GolonganDarah.bNeg:
        return 'B-';
      case GolonganDarah.abPos:
        return 'AB+';
      case GolonganDarah.abNeg:
        return 'AB-';
      case GolonganDarah.oPos:
        return 'O+';
      case GolonganDarah.oNeg:
        return 'O-';
    }
  }

  static GolonganDarah fromString(String? value) {
    switch (value) {
      case 'A':
        return GolonganDarah.a;
      case 'B':
        return GolonganDarah.b;
      case 'AB':
        return GolonganDarah.ab;
      case 'O':
        return GolonganDarah.o;
      case 'A+':
        return GolonganDarah.aPos;
      case 'A-':
        return GolonganDarah.aNeg;
      case 'B+':
        return GolonganDarah.bPos;
      case 'B-':
        return GolonganDarah.bNeg;
      case 'AB+':
        return GolonganDarah.abPos;
      case 'AB-':
        return GolonganDarah.abNeg;
      case 'O+':
        return GolonganDarah.oPos;
      case 'O-':
        return GolonganDarah.oNeg;
      default:
        return GolonganDarah.o;
    }
  }
}
