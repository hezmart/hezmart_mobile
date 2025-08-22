import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../core/theme/pallets.dart';

class DesParams{
  String category;
  String subCategory;
  String weight;
  String taxable;
  String isDigital;
  String description;

  DesParams(
    this.category,
    this.subCategory,
    this.weight,
    this.taxable,
    this.isDigital,
    this.description,
  );}

class DescriptionDetails extends StatefulWidget {
  final String description;
  final String category;
  final String subCategory;
  final String weight;
  final String taxable;
  final String isDigital;
  const DescriptionDetails({super.key, required this.description, required this.category, required this.subCategory, required this.weight, required this.taxable, required this.isDigital});

  @override
  State<DescriptionDetails> createState() => _DescriptionDetailsState();
}

class _DescriptionDetailsState extends State<DescriptionDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        tittle: TextView(text: "Product Description",fontSize: 18,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                width: 1.sw,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(text: "Description",fontSize: 15,fontWeight: FontWeight.w600,),
                    15.verticalSpace,
                    TextView(text: widget.description,fontSize: 10,),
                    10.verticalSpace,


                  ],
                ),
              ),
              20.verticalSpace,
              Container(padding: EdgeInsets.all(15),
                width: 1.sw,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: "Specifications",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    10.verticalSpace,
                    TextView(
                      text: "General",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Category",
                          fontSize: 14,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text: widget.category,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "SubCategory",
                          fontSize: 14,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text: widget.subCategory,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),  15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Weight",
                          fontSize: 14,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:"${ widget.weight.toString()} kg",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    TextView(
                      text: "Other",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Taxable",
                          fontSize: 14,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:widget.taxable==false?"No":"Yes",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Digital Product",
                          fontSize: 14,
                          color: Pallets.grey35,

                        ),
                        TextView(
                          text:widget.isDigital==false?"No":"Yes",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
