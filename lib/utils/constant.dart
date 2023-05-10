import 'package:brand_fiesta/Hive_model/brand_details_model.dart';
import 'package:hive/hive.dart';

double defaultHeight = 932.0;
String detailsBox = "BrandDetails";
Box<BrandDetailsModel> getBusinessData() =>
    Hive.box<BrandDetailsModel>(detailsBox);
