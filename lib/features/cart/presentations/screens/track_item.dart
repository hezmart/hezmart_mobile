import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hezmart/common/widgets/text_view.dart';
import 'package:hezmart/core/theme/pallets.dart';
import 'package:iconsax/iconsax.dart';
class TrackItem extends StatefulWidget {
  const TrackItem({super.key});

  @override
  State<TrackItem> createState() => _TrackItemState();
}

class _TrackItemState extends State<TrackItem> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.5244, 3.3792),
    zoom: 12,
  );
  GoogleMapController? _mapController;

  List<Marker> _markers = [];
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: _onMapCreated,
            markers: Set.from(_markers),
            onTap: (LatLng latLng) {

            },
          ),
          Positioned(
            top: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 50,left: 10),
              child: Container(
                width: 1.sw,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Pallets.grey95
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        context.pop();
                      },
                        child: Icon(Icons.keyboard_arrow_left,)),
                    40.horizontalSpace,
                    TextView(text: "Item Location",fontSize: 16,fontWeight: FontWeight.w500,)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
