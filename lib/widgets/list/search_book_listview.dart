import "package:flutter/material.dart";
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rbti_android/models/bookFilter.dart';
import 'package:rbti_android/provider/book.dart';
import 'package:rbti_android/provider/books.dart';
import 'package:rbti_android/widgets/book_item.dart';

class SearchBookListView extends StatefulWidget {
  const SearchBookListView({Key? key, required BookFilter this.filter})
      : super(key: key);

  final BookFilter filter;

  @override
  _SearchBookListViewState createState() => _SearchBookListViewState();
}

class _SearchBookListViewState extends State<SearchBookListView> {
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

  @override
  void didUpdateWidget(SearchBookListView oldWidget) {
    if (oldWidget.filter != widget.filter) {
      _pagingController.refresh();
    }

    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchPage(int pageKey) async {
    final books = Provider.of<Books>(context, listen: false);
    final int pageSize = 20;
    try {
      final newPage = await books.fetchPaginatedBook(
          pageSize, (pageKey - 1) * pageSize, widget.filter);

      final prevFetchedItems = _pagingController.itemList?.length ?? 0;
      final totalPaginateCount = books.currentPaginateCount;
      final bool isLastPage = prevFetchedItems + pageSize > totalPaginateCount;
      if (isLastPage) {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PagedListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: ClampingScrollPhysics(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Book>(
              itemBuilder: (context, book, index) => BookItem(
                  id: book.id.toString(),
                  tipe: book.tipe,
                  title: book.title,
                  penulis: book.penulis,
                  isAvailable: book.isAvailable,
                  kategori: book.kategori),
              firstPageErrorIndicatorBuilder: (context) => AlertDialog(
                    title: Text("Tidak ada buku untuk kategori ini!"),
                  ),
              noItemsFoundIndicatorBuilder: (context) => Center(
                    child: Text("No books found!"),
                  )),
          separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              )),
    );
  }
}
