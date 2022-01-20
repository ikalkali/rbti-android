import "package:flutter/material.dart";
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rbti_android/widgets/book_item.dart';

class PagedBookListView extends StatefulWidget {
  const PagedBookListView(
      {Key? key, required this.bookRepository, required this.filter})
      : super(key: key);

  final Books bookRepository;
  final BookFilter filter;

  @override
  _PagedBookListViewState createState() => _PagedBookListViewState();
}

class _PagedBookListViewState extends State<PagedBookListView> {
  // 1
  final _pagingController = PagingController<int, Book>(
    // 2
    firstPageKey: 1,
  );

  @override
  void initState() {
    // 3
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    // TODO: Implement the function's body.
    final int pageSize = 20;
    try {
      print("pageKey : $pageKey");
      final newPage = await widget.bookRepository.fetchPaginatedBook(
          pageSize, (pageKey - 1) * pageSize, widget.filter);

      final prevFetchedItems = _pagingController.itemList?.length ?? 0;
      print("prevFetched : $prevFetchedItems");
      final bool isLastPage = prevFetchedItems + pageSize > 20;
      if (isLastPage) {
        print("LAST PAGE!");
        _pagingController.appendLastPage(newPage);
      } else {
        _pagingController.appendPage(newPage, pageKey + 1);
      }
    } catch (error) {
      print("error : $error");
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PagedBookListView oldWidget) {
    print(oldWidget.filter.jenis);
    print(widget.filter.jenis);
    if (oldWidget.filter.jenis != widget.filter.jenis) {
      _pagingController.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: ClampingScrollPhysics(),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Book>(
            itemBuilder: (context, book, index) => BookItem(
                title: book.title,
                penulis: book.penulis,
                kategori: book.kategori),
            firstPageErrorIndicatorBuilder: (context) => AlertDialog(
                  title: Text(_pagingController.error),
                ),
            noItemsFoundIndicatorBuilder: (context) => Center(
                  child: Text("No books found!"),
                )),
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ));
  }
}
