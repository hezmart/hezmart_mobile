import 'package:flutter/material.dart';
import 'package:hezmart/common/widgets/custom_appbar.dart';
import 'package:hezmart/common/widgets/outlined_form_field.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:iconsax/iconsax.dart';
class CustomerSsupport extends StatefulWidget {
  const CustomerSsupport({super.key});

  @override
  State<CustomerSsupport> createState() => _CustomerSsupportState();
}

class _CustomerSsupportState extends State<CustomerSsupport> {
  final controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
      tittle: TextView(text: "Customer Support",fontSize: 18,fontWeight: FontWeight.w600,),),
    
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30,top: 10,left: 20,right: 20),
        child: Column(
          children: [
            Expanded(child: Column()),
            OutlinedFormField(hint: "send us a message",
              controller: controller,
              suffix: InkWell(
              onTap: (){
                controller.clear();
              },
                child: Icon(Iconsax.send_1,color: Color(0xff992002),)),)
          ],
        ),
      ),
      
    );
    
  }
}
