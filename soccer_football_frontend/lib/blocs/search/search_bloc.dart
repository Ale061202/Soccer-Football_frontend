import 'package:bloc/bloc.dart';
import 'package:soccer_football_frontend/blocs/search/search.dart';
import 'package:soccer_football_frontend/repositories/search_repository.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositories searchRepository;

  SearchBloc(this.searchRepository) : super(SearchInitial()) {
    // ignore: void_checks
    on<SearchQueryChanged>((event, emit) async* {
      emit(SearchLoading());
      final results = await searchRepository.searchRepositories(event.query);
      emit(SearchLoaded(results));
    });
  }
}