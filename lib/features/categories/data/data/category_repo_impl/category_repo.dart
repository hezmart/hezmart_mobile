import 'package:hezmart/core/services/network/network_service.dart';
import 'package:hezmart/core/services/network/url_config.dart';
import 'package:hezmart/features/categories/data/models/all_category.dart';
import 'package:hezmart/features/categories/data/models/similar.dart';
import 'package:hezmart/features/categories/data/models/sub_cat_response.dart';

import '../../../domain/category_repo/category_repo.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  NetworkService networkService;

  CategoryRepositoryImpl(this.networkService);

  @override
  Future<AllCategoryResponse> allCategory() async {
    var response = await networkService.call(
      UrlConfig.allcategory,
      RequestMethod.get,
    );
    return AllCategoryResponse.fromJson(response.data);
  }

  @override
  Future<SubCategoryItemsResponse> getsubCategory(
    String catId,
    String subcartId,
  ) async {
    var response = await networkService.call(
      UrlConfig.subcategory,
      RequestMethod.get,
      queryParams: {"categoryId": catId, "subCategoryId": subcartId},
    );
    return SubCategoryItemsResponse.fromJson(response.data);
  }

  @override
  Future<SimilarProductResponse> similarProduct(String catId) async {
    var response = await networkService.call(
      UrlConfig.similarpro,
      RequestMethod.get,
      queryParams: {"categoryId": catId},
    );
    return SimilarProductResponse.fromJson(response.data);
  }

  @override
  Future<SubCategoryItemsResponse> subCategory(String catId) {
    // TODO: implement subCategory
    throw UnimplementedError();
  }
}
