import 'package:amplify_flutter/amplify.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';

class SearchHistoryRepository {
  Future<SearchHistory> createSearch({String searchText, String id}) async {
    final searchObject = SearchHistory(
      id: id,
      searchHistory: searchText,
    );

    try {
      await Amplify.DataStore.save(searchObject);

      return searchObject;
    } catch (e) {
      return e;
    }
  }

  Future<List<SearchHistory>> histories() async {
    try {
      return await Amplify.DataStore.query(SearchHistory.classType);
    } catch (e) {
      return e;
    }
  }

  Future<SearchHistory> readByIdHistory({String id}) async {
    try {
      final searchObjects = await Amplify.DataStore.query(
        SearchHistory.classType,
        where: SearchHistory.ID.eq(
          id,
        ),
      );

      if (searchObjects.isEmpty) {
        print('No Data');
        return null;
      }

      final searchObject = searchObjects.first;

      return searchObject;
    } catch (e) {
      throw (e);
    }
  }

  Future<SearchHistory> updateHistory({String id}) async {
    final searchObject = await readByIdHistory(id: id);
    final updateSearch = searchObject.copyWith(searchHistory: 'new tag');

    await Amplify.DataStore.save(updateSearch);

    return updateSearch;
  }

  Future<SearchHistory> deleteHistory({String id}) async {
    try {
      final searchObject = await readByIdHistory(id: id);
      await Amplify.DataStore.delete(searchObject);

      return searchObject;
    } catch (e) {
      throw e;
    }
  }
}
