// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sohaib_store/server/model/adderss_model.dart';

import '../value/colors.dart';
import 'custom_text.dart';

class DropDownAdderss extends StatelessWidget {
  // const DropDownSearchWidget({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  late List<Adderss> items;
  late void Function(Adderss? value) onSaved;
  late void Function(Adderss? value) onChange;
  late Adderss usersAccount;

  DropDownAdderss(
      {super.key,
      required this.formKey,
      required this.items,
      required this.onSaved,
      required this.onChange,
      required this.usersAccount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.zero,
      height: 60.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          // BoxShadow(
          //   color: Colors.grey,
          //   blurRadius: 10,
          //   offset: Offset(0, 4),
          // ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.appColor, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0),
                child: DropdownSearch<Adderss>(
                  // dropdownBuilder: _customDropDownExampleMultiSelection,
                  mode: Mode.DIALOG,
                  // showClearButton: true,
                  showSearchBox: true,
                  // compareFn: null,
                  items: items,
                  dropdownButtonSplashRadius: 25,
                  // clearButton: IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.border_clear,
                  //       color: Colors.transparent),
                  // ),
                  dropDownButton: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: AppColors.appColor,
                  ),
                  selectionListViewProps: const SelectionListViewProps(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    primary: true,
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    addSemanticIndexes: true,
                    shrinkWrap: true,
                  ),
                  showSelectedItems: false,

                  clearButtonSplashRadius: 25,
                  popupBarrierColor: Colors.black.withOpacity(0.24),
                  popupShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  popupSafeArea: const PopupSafeAreaProps(
                      top: true,
                      bottom: true,
                      left: true,
                      right: true,
                      maintainBottomViewPadding: true),
                  popupElevation: 3,
                  isFilteredOnline: true,
                  dropdownSearchDecoration:
                      const InputDecoration(border: InputBorder.none),
                  onChanged: onChange,
                  selectedItem: items.isNotEmpty
                      ? usersAccount
                      : Adderss(name: 'الاسم', id: 0),
                  itemAsString: (Adderss? u) => u!.userAsString(),

                  onSaved: onSaved,
                  dropdownSearchBaseStyle: const TextStyle(color: Colors.red),
                  showAsSuffixIcons: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      isDense: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.w,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: AppColors.appColor,
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0,
                        ),
                        borderSide: BorderSide(
                          color: AppColors.appColor,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          0,
                        ),
                        borderSide: BorderSide(
                          color: AppColors.appColor,
                          width: 2.w,
                        ),
                      ),
                      label: const CustomText(
                        " البحث",
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
