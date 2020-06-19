/// This class implements a cache. This is a parametric class because in this
/// way you can save every object you want.
class Cache<T> {
  final List<T> _cachedData = List<T>();

  /// Get the last data saved in cache. This is a public interface of
  /// [_getLastDataCached] method.
  T get lastData => _getLastDataCached();

  /// Get all the data saved in cache. This is a public interface of
  /// [_getDataCached] method.
  List<T> get dataCached => _getDataCached();

  /// Get the number of elements saved in cache.
  int get size => _cachedData.length;

  /// This method allows to save a new data.
  void save(T data) => _cachedData.add(data);

  /// This method cleans the cache.
  void emptyCache() {
    if (_cachedData.length > 0) {
      _cachedData.clear();
    }
  }

  /// This method permits to check if the cache is empty.
  bool isCacheEmpty() => _cachedData.isEmpty;

  /// This is a private method that permits to get the last data saved in cache.
  T _getLastDataCached() {
    if (_cachedData != null) {
      if (_cachedData.isNotEmpty) {
        return _cachedData.last;
      }
    }
    return null;
  }

  /// This is a private method that permits to get all the data saved in cache.
  List<T> _getDataCached () {
    if (_cachedData != null) {
      if (_cachedData.isNotEmpty) {
        return _cachedData;
      }
    }
    return null;
  }
}