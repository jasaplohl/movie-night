class PaginationService<T> {
  final List<T> items;
  int maxItemsPerPage;
  int _totalPages = 1;

  PaginationService({
    required this.items,
    required this.maxItemsPerPage,
  }) {
    final maxPages = (this.items.length / this.maxItemsPerPage).ceil();
    this._totalPages = maxPages > 0 ? maxPages : 1;
  }

  List<T> getItemsForPage(int currentPage) {
    final lowerLimit = (currentPage - 1) * this.maxItemsPerPage;
    int upperLimit;
    if(currentPage * this.maxItemsPerPage > this.items.length) {
      upperLimit = this.items.length;
    } else {
      upperLimit = currentPage * this.maxItemsPerPage;
    }
    return items.sublist(lowerLimit, upperLimit);
  }

  int get totalPages {
    return this._totalPages;
  }

  int get itemCount {
    return this.items.length;
  }
}