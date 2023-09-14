import 'package:bloc/bloc.dart';
import 'package:flutter_fic7/data/datasources/product_remote_datasource.dart';
import 'package:flutter_fic7/data/models/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(_Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _$_Loading());
      final result = await ProductRemoteDatasource().getProducts();
      result.fold(
        (l) => emit(_$_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
