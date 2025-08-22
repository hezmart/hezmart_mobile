import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hezmart/features/search/data/models/search_response.dart';
import 'package:hezmart/features/search/domain/repo.dart';

import '../../data/models/all_sub_category.dart';

part 'all_sub_cat_event.dart';
part 'all_sub_cat_state.dart';

class AllSubCatBloc extends Bloc<AllSubCatEvent, AllSubCatState> {
  AllSubCategoriesRepository repository;
  AllSubCatBloc(this.repository) : super(AllSubCatInitial()) {
    on<AllSubCatEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllSubCatEvent>(_mapGetAllSubCatEventToState);
    on<SearchProductEvent>(_mapSearchProductEventToState);
  }

  Future<void> _mapGetAllSubCatEventToState(GetAllSubCatEvent event, Emitter<AllSubCatState> emit) async {
    emit(AllSubCatloadingState());
    try {
      var response=await repository.allsubcat();
      emit(AllSubCatSuccessState(response));
    }  catch (e) {
      emit(AllSubCatfailuireState(e.toString()));
      // TODO
    }

  }

  Future<void> _mapSearchProductEventToState(SearchProductEvent event, Emitter<AllSubCatState> emit) async {
    emit(AllSubCatloadingState());
    try {
      var response=await repository.search(event.query);
      emit(SearchSuccessState(response));
    }  catch (e) {
      emit(AllSubCatfailuireState(e.toString()));
      rethrow;
      // TODO
    }
  }
}
