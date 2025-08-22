import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/categories/data/models/all_category.dart';
import 'package:hezmart/features/categories/domain/category_repo/category_repo.dart';

import '../../data/models/similar.dart';
import '../../data/models/sub_cat_response.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AllCategoryEvent>(_mapAllCategoryEventToState);
    on<SubCategoryEvent>(_mapSubCategoryEventToState);
    on<GetSimilarProductEvent>(_mapGetSimilarProductEventToState);
  }

  Future<void> _mapAllCategoryEventToState(AllCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryloadinggState());
    try {
      var response=await repository.allCategory();
      emit(CategorySuccessState(response));
    }  catch (e) {
      emit(CategoryfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapSubCategoryEventToState(SubCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryloadinggState());
    try {
      var response=await repository.getsubCategory(event.catId, event.subcatId);
      emit(SubCategorySuccessState(response));
    }  catch (e) {
      emit(CategoryfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }

  Future<void> _mapGetSimilarProductEventToState(GetSimilarProductEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryloadinggState());
    try {
      var response=await repository.similarProduct(event.catId );
      emit(SimilarproductSuccess(response));
    }  catch (e) {
      emit(CategoryfailiureState(e.toString()));
      rethrow;
      // TODO
    }
  }
}
