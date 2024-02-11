import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 640;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= 640 &&
      MediaQuery.of(context).size.width < 1024;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1024;
}
