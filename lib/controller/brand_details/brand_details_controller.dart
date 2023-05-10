import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandDetailsController extends GetxController {
  TextEditingController searchTextController = TextEditingController();

  int _selectedDetails = 0;

  int get selectedDetails => _selectedDetails;

  set selectedDetails(int value) {
    _selectedDetails = value;
    update();
  }

  String _searchText = "";

  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    update();
  }
}
