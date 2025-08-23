import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/widgets/custom_appbar.dart';
import '../../../../common/widgets/image_widget.dart';
import '../../../../common/widgets/text_view.dart';
import '../../../../core/theme/pallets.dart';
import '../../../../core/utils/helper_utils.dart';
class HelpTab extends StatefulWidget {
  const HelpTab({super.key});

  @override
  State<HelpTab> createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        tittle: Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Helpers.launchRawUrl('https://hezmart.com/');
              },
              child: HelpItem(
                widget: Icon(Icons.language,color: Pallets.grey35,size: 30,),
                text: 'Website',
                voidCallback: () {
                  Helpers.launchRawUrl('https://hezmart.com/');
                },
              ),
            ),
            10.verticalSpace,
            // HelpItem(
            //   widget: ImageWidget(imageUrl: Assets.images.pngs.wats.path),
            //   text: 'Whatsapp',
            //   voidCallback: () async {
            //     final url = "https://wa.me/+2348089465200";
            //     if (await canLaunch(url)) {
            //     await launch(url);
            //     }
            //   },
            // ),
            HelpItem(
              widget: ImageWidget(imageUrl: 'assets/images/pngs/wat.png',size: 30,),
              text: 'Whatsapp',
              voidCallback: () async {
                openLink(urlLink:"https://wa.me/2349160002490",);

                // final url = "https://wa.me/2348089465200";
                // if (await canLaunch(url)) {
                //   await launch(url);
                // }
              },
            ),

            10.verticalSpace,
            InkWell(
              onTap: () {
                Helpers.launchRawUrl(
                    'https://www.facebook.com/share/1CM7dF5EhD/?mibextid=wwXIfr');
              },
              child: HelpItem(
                widget: ImageWidget(imageUrl:'assets/images/pngs/fb.png', size: 30,),
                text: 'Facebook',
                voidCallback: () {
                  Helpers.launchRawUrl(
                      'https://www.facebook.com/share/1CM7dF5EhD/?mibextid=wwXIfr');
                },
              ),
            ),

            10.verticalSpace,
            InkWell(
              onTap: () {
                Helpers.launchRawUrl(
                    "https://www.instagram.com/workandshopapp?igsh=MWhscWd3bXh0eTg5Ng%3D%3D&utm_source=qr");
              },
              child: HelpItem(
                widget:
                ImageWidget(imageUrl: 'assets/images/pngs/insta.png',size: 30,),
                text: 'Instagram',
                voidCallback: () {
                  Helpers.launchRawUrl(
                      "https://www.instagram.com/hezmart_ng?igsh=bzYwY2c1YmxhcDlo");
                },
              ),
            ),
            10.verticalSpace,
            InkWell(
              onTap: () {
                Helpers.launchRawUrl(
                    "https://www.tiktok.com/@hezmart.com?_t=ZS-8z4XfDw4EXy&_r=1");

              },
              child: HelpItem(
                widget:
                ImageWidget(imageUrl: 'assets/images/pngs/tik.png',size: 30,),
                text: 'TikTok',
                voidCallback: () {
                  Helpers.launchRawUrl(
                      "https://www.tiktok.com/@hezmart.com?_t=ZS-8z4XfDw4EXy&_r=1");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void openLink({
    required String urlLink,
    bool inApp = false,
  }) async {
    final Uri url = Uri.parse(urlLink);

    await launchUrl(
      url,
      mode: inApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    );
  }
}

class HelpItem extends StatefulWidget {
  final Widget widget;
  final VoidCallback voidCallback;
  final String text;

  const HelpItem(
      {super.key,
        required this.widget,
        required this.text,
        required this.voidCallback});

  @override
  State<HelpItem> createState() => _HelpItemState();
}

class _HelpItemState extends State<HelpItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.voidCallback,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Pallets.grey75),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            widget.widget,
            15.horizontalSpace,
            TextView(text: widget.text,fontSize: 16,)
          ],
        ),
      ),
    );
  }

}
