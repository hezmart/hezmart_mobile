import 'package:hezmart/features/categories/data/models/all_category.dart';

import '../../data/models/similar.dart';
import '../../data/models/sub_cat_response.dart';

abstract class CategoryRepository{

  Future<AllCategoryResponse>allCategory();
  Future<SubCategoryItemsResponse>getsubCategory(String catId,String subcartId);
  Future<SubCategoryItemsResponse>subCategory(String catId,);
  Future<SimilarProductResponse>similarProduct(String catId);

}