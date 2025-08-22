import '../data/models/all_sub_category.dart';
import '../data/models/search_response.dart';

abstract class AllSubCategoriesRepository{
  Future<AllSubCategoryResspomse>allsubcat();
  Future<SearchResponse>search(String query);
}