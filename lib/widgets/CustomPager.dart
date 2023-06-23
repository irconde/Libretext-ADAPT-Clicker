import 'package:adapt_clicker/constants/dimens.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/Logger.dart';

// ignore: must_be_immutable
class CustomPager extends StatefulWidget {
  CustomPager({
    Key? key,
    required this.totalPages,
    required this.onPageChanged,
    this.currentItemsPerPage,
    this.itemsPerPageList,
    this.pagesView = 3,
    this.currentPage = 1,
    this.numberButtonSelectedColor = CColors.primaryColor,
    this.numberTextSelectedColor = CColors.primaryBackground,
    this.numberTextUnselectedColor = CColors.primaryColor,
    this.pageChangeIconColor = CColors.arrowForegroundColor,
    this.itemsPerPageText,
    this.itemsPerPageTextStyle,
  })  : assert(currentPage >= 0 && totalPages > 0 && pagesView > 0,
            "Fatal Error: Make sure the currentPage, totalPages and pagesView fields are greater than zero. "),
        super(key: key) {}

  /// How many page numbers selectable to show at once.
  int pagesView;

  /// Total pages.
  final int totalPages;

  /// The callback that is called when the page is changed.
  final Function(int) onPageChanged;

  /// Current items per page.
  final int? currentItemsPerPage;

  /// Items per page list. Example: [5,10,20,50]
  List<int>? itemsPerPageList;

  /// Current page. Default is 1.
  int currentPage;

  // Button color of the selected page number.
  final Color numberButtonSelectedColor;

  // Text color of the selected page number.
  final Color numberTextUnselectedColor;

  // Text color of the unselected page numbers.
  final Color numberTextSelectedColor;

  // Color of the next, previous, first and last page icons.
  final Color pageChangeIconColor;

  // ItemsPerPage label text.
  final String? itemsPerPageText;

  // ItemsPerPage label text style.
  final TextStyle? itemsPerPageTextStyle;

  @override
  State<CustomPager> createState() => _PagerState();
}

class _PagerState extends State<CustomPager> {
  @override
  Widget build(BuildContext context) {
    pagesViewValidation();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         SizedBox(
            width: Dimens.paginatorButtonSize,
            height: Dimens.paginatorButtonSize,
            child: Ink(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                  color: CColors.arrowBackgroundColor),
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: "First Page",
                onPressed: () {
                  setState(() {
                    widget.currentPage = 0; //index starts at 0
                    widget.onPageChanged(widget.currentPage);
                  });
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.first_page,
                  color: widget.pageChangeIconColor,
                  size: 25,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: Dimens.paginatorButtonSize,
            height: Dimens.paginatorButtonSize,
            child: Ink(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                  color: CColors.arrowBackgroundColor),
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: "Previous",
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        side:
                            BorderSide(color: CColors.secondaryColor, width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    backgroundColor: CColors.tertiaryShimmerBackground),
                onPressed: () {
                  setState(() {
                    widget.currentPage =
                        widget.currentPage > 1 ? widget.currentPage - 1 : 1;
                    widget.onPageChanged(widget.currentPage);
                  });
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.chevron_left,
                  color: widget.pageChangeIconColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = getPageStart(getPageEnd()); i < getPageEnd(); i++)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: SizedBox(
                  width: Dimens.paginatorButtonSize,
                  height: Dimens.paginatorButtonSize,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.currentPage = i;
                        widget.onPageChanged(widget.currentPage);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: CColors.arrowBackgroundColor),
                            borderRadius: widget.currentPage == i
                                ? const BorderRadius.all(Radius.circular(1))
                                : const BorderRadius.all(Radius.circular(0))
                        ),
                        backgroundColor: widget.currentPage == i
                            ? widget.numberButtonSelectedColor
                            : null),
                    child: Text(
                      '${i+1}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: widget.currentPage == i
                            ? widget.numberTextSelectedColor
                            : widget.numberTextUnselectedColor,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 4, 0),
          child: SizedBox(
            width: Dimens.paginatorButtonSize,
            height: Dimens.paginatorButtonSize,
            child: Ink(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                  color: CColors.arrowBackgroundColor),
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: "Next Page",
                onPressed: () {
                  setState(() {
                    widget.currentPage = widget.currentPage < widget.totalPages
                        ? widget.currentPage + 1
                        : widget.totalPages;
                    widget.onPageChanged(widget.currentPage);
                  });
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.chevron_right,
                  color: widget.pageChangeIconColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            width: Dimens.paginatorButtonSize,
            height: Dimens.paginatorButtonSize,
            child: Ink(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1))),
                  color: CColors.arrowBackgroundColor),
              child: IconButton(
                padding: EdgeInsets.zero,
                tooltip: "Last Page",
                onPressed: () {
                  setState(() {
                    widget.currentPage = widget.totalPages-1; //index starts at 0 but total pages is counting from 1
                    widget.onPageChanged(widget.currentPage);
                    logger.i('curreng page: ${widget.currentPage}');
                  });
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.last_page,
                  color: widget.pageChangeIconColor,
                  size: 25,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Get last page to show in pagination.
  int getPageEnd() {
    return widget.currentPage + widget.pagesView > widget.totalPages
        ? widget.totalPages
        : widget.currentPage + widget.pagesView;
  }

  /// Get first page to show in pagination.
  int getPageStart(int pageEnd) {
    return pageEnd == widget.totalPages
        ? pageEnd - widget.pagesView
        : widget.currentPage;
  }

  /// Validation of pagesView field
  void pagesViewValidation() {
    if (widget.totalPages < widget.pagesView) {
      widget.pagesView = widget.totalPages;
    }
  }
}
