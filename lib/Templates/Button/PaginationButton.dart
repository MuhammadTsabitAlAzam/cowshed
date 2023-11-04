import 'package:cowshed/Templates/Color/myColor.dart';
import 'package:cowshed/Templates/Text/Text.dart';
import 'package:flutter/material.dart';

class PaginationButton extends StatelessWidget {
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final Function()? onNextPage;
  final Function()? onPreviousPage;

  PaginationButton({
    required this.pageNumber,
    required this.pageSize,
    this.onNextPage,
    this.onPreviousPage, required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          child: ElevatedButton(
            onPressed: onPreviousPage,
            child: Icon(
                Icons.chevron_left_outlined,
              color: AppColors.myColor,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.myColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          height: 35,
          width: 50,
          child: Center(child: CommonThemedText(pageNumber.toString())),
        ),
        SizedBox(width: 10,),
        CommonThemedText('/'),
        SizedBox(width: 10,),
        Container(
          height: 35,
          width: 50,
          child: Center(child: CommonThemedText(totalPages.toString())),
        ),
        SizedBox(width: 10,),
        Container(
          width: 70,
          child: ElevatedButton(
            onPressed: onNextPage,
            child: Icon(
                Icons.chevron_right_outlined,
              color: AppColors.myColor,
            ),
          ),
        ),
      ],
    );
  }
}