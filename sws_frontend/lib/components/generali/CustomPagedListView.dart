import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_exception_indicator.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/first_page_exception_indicator.dart';
import 'package:infinite_scroll_pagination/src/ui/default_indicators/footer_tile.dart';

class CustomPagedListView<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemBuilder;
  final PagingController<int, T> pagingController;

  const CustomPagedListView(
      {Key? key, required this.itemBuilder, required this.pagingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
        shrinkWrap: false,
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
            noItemsFoundIndicatorBuilder: (context) {
              return const FirstPageExceptionIndicator(
                title: 'Nessun elemento trovato',
                message: 'La lista è vuota.',
              );
            },
            firstPageProgressIndicatorBuilder: (context) {
              return const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            newPageErrorIndicatorBuilder: (context) {
              return InkWell(
                onTap: pagingController.retryLastFailedRequest,
                child: FooterTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Qualcosa è andato storto. Riprova.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Icon(
                        Icons.refresh,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
            firstPageErrorIndicatorBuilder: (context) {
              return FirstPageExceptionIndicator(
                title: 'Qualcosa è andato storto',
                message: 'Errore inaspettato.\n'
                    'Riprova.',
                onTryAgain: pagingController.retryLastFailedRequest,
              );
            },
            newPageProgressIndicatorBuilder: (context) {
              return const FooterTile(
                child: CircularProgressIndicator(),
              );
            },


            itemBuilder: itemBuilder));
  }
}
