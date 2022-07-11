String getBottomNavigation(int? x) {
  switch (x) {
    case -1:
      return "التسجيل";
    case 0:
      return "الرئيسية";
    case 1:
      return "الدليل";
    case 2:
      return "الخريطة";

    case 3:
      return "تواصل معنا";

    case 4:
      return "حول";
  }
  return "الرئيسية";
}
