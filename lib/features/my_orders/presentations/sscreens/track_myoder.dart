
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/single_order.dart';

class TrackingMyOrder extends StatefulWidget {
  final String method;
  final String status;
  final DeliveryAddress? shippingAddress;
  final PickupStationDetails? pickupStationDetails;
  final String? name;

  const TrackingMyOrder({
    super.key,
    required this.status,
    required this.shippingAddress,
    required this.pickupStationDetails, required this.method, this.name,
  });

  @override
  State<TrackingMyOrder> createState() => _TrackingMyOrderState();
}

class _TrackingMyOrderState extends State<TrackingMyOrder> {
  final List<Map<String, String>> statusSteps = [
    {"key": "pending", "label": "Pending"},
    {"key": "processing", "label": "Processing"},
    {"key": "shipped", "label": "On Transit"},
    {"key": "delivered", "label": "Delivered"},
    {"key": "received", "label": "Order Received"},
  ];

  Color _getStatusColor(String stepStatus) {
    final current = widget.status.toLowerCase().replaceAll(' ', '_');
    final steps = ["pending", "processing", "shipped", "delivered", "received"];

    final currentIndex = steps.indexOf(current);
    final stepIndex = steps.indexOf(stepStatus.toLowerCase());

    if (stepIndex == -1 || currentIndex == -1) return Colors.grey;

    if (stepIndex < currentIndex) {
      return Colors.green.shade400;
    } else if (stepIndex == currentIndex) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  final Map<String, LatLng> stateCoordinates = {
    "lagos": LatLng(6.5244, 3.3792),
    "abuja": LatLng(9.0579, 7.4951),
  };
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.5244, 3.3792),
    zoom: 12,
  );
  // GoogleMapController? _mapController;

  // List<Marker> _markers = [];


  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateMapBasedOnStatus();
  }

  // List<Polyline> _polylines = [];
  // bool _isBlinkVisible = true;
  // Timer? _blinkTimer;
  //

  GoogleMapController? _mapController;
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  bool _isBlinkVisible = true;
  Timer? _blinkTimer;

  @override
  void initState() {
    super.initState();
    _updateMapBasedOnStatus();
  }

  @override
  void didUpdateWidget(TrackingMyOrder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _updateMapBasedOnStatus();
    }
  }

  void _updateMapBasedOnStatus() {
    final String state = (widget.method == "door"
        ? widget.shippingAddress?.state
        : widget.pickupStationDetails?.state)
        ?.toLowerCase() ?? "";

    // Get coordinates for the destination state
    LatLng? destination = stateCoordinates[state];
    if (destination == null) return;

    setState(() {
      _markers.clear();
      _polylines.clear();
      _blinkTimer?.cancel();

      final currentStatus = widget.status.toLowerCase();

      if (["pending", "processing"].contains(currentStatus)) {
        // Show pending/processing marker
        _markers.add(Marker(
          markerId: MarkerId('status'),
          position: destination,
          infoWindow: InfoWindow(
            title: widget.status.toUpperCase(),
            snippet: "Location: ${state.toUpperCase()}",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ));

        // Center map on destination
        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(destination, 10));
      }
      else if (currentStatus == "shipped") {
        // Draw route from source to destination
        LatLng source = _kGooglePlex.target;

        _markers.addAll([
          Marker(
            markerId: MarkerId('source'),
            position: source,
            infoWindow: InfoWindow(title: 'Shipping from'),
          ),
          Marker(
            markerId: MarkerId('destination'),
            position: destination,
            infoWindow: InfoWindow(
              title: 'Shipping to ${state.toUpperCase()}',
            ),
          ),
        ]);

        _polylines.add(Polyline(
          polylineId: PolylineId("route"),
          points: [source, destination],
          color: Colors.blue,
          width: 4,
        ));

        // Fit camera to show both points
        _mapController?.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              min(source.latitude, destination.latitude),
              min(source.longitude, destination.longitude),
            ),
            northeast: LatLng(
              max(source.latitude, destination.latitude),
              max(source.longitude, destination.longitude),
            ),
          ),
          100, // padding
        ));
      }
      else if (["delivered", "received"].contains(currentStatus)) {
        // Add blinking delivered marker
        _addBlinkingMarker(destination, state);
        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(destination, 12));
      }
    });
  }

  void _addBlinkingMarker(LatLng destination, String state) {
    _blinkTimer?.cancel();

    // Add initial visible marker
    _markers.add(Marker(
      markerId: MarkerId('blinking'),
      position: destination,
      infoWindow: InfoWindow(
        title: 'Delivered to ${state.toUpperCase()}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));

    _blinkTimer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      setState(() {
        _isBlinkVisible = !_isBlinkVisible;
        _markers.removeWhere((m) => m.markerId.value == 'blinking');
        if (_isBlinkVisible) {
          _markers.add(Marker(
            markerId: MarkerId('blinking'),
            position: destination,
            infoWindow: InfoWindow(
              title: 'Delivered to ${state.toUpperCase()}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ));
        }
      });
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: _onMapCreated,
              markers: Set.from(_markers),
              polylines: Set.from(_polylines),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Status",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Divider(),
                  widget.method=="door"? Column(
                    children: statusSteps
                        .map((step) =>
                        _buildStatusRow(step["key"]!, step["label"]!))
                        .toList(),
                  ): Column(
                    children: statusSteps
                        .map((step) =>
                        _buildStatusPickupRow(step["key"]!, step["label"]!))
                        .toList(),
                  ),
                ],
              ),
            ),
          )
        ] ,
      ),
    );
  }

  Widget _buildStatusRow(String key, String label) {
    Color statusColor = _getStatusColor(key);
    final current = widget.status.toLowerCase();
    String? message;

    if (key == current) {
      switch (key) {
        case "pending":
          message = "Your order is pending,waiting to be processed";
          break;
        case "processing":
          message = "Your order is being processed,waiting to be hipped";
          break;
        case "shipped":
          message = "Your order has been shipped,it will soon arrive";
          break;
        case "delivered":
        case "received":
          message =
          "Successfully shipped to ${widget.shippingAddress?.primaryAddress?.toUpperCase() ?? ''}";
          break;
      }
    } else if (["delivered", "received"].contains(current) &&
        (key == "delivered" || key == "received")) {
      message =
      "Successfully shipped to ${widget.shippingAddress?.primaryAddress?.toUpperCase() ?? ''}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: statusColor,
              ),
              if (key != "received")
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                if (message != null) ...[
                  SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStatusPickupRow(String key, String label) {
    Color statusColor = _getStatusColor(key);
    final current = widget.status.toLowerCase();
    String? message;

    if (key == current) {
      switch (key) {
        case "pending":
          message = "Your order is pending,waiting to be processed";
          break;
        case "processing":
          message = "Your order is being processed,waiting to be shipped";
          break;
        case "shipped":
          message = "Your order has been shipped to ${widget.pickupStationDetails?.name?.toUpperCase() ?? ''}";
          break;
        case "delivered":
        case "received":
          message =
          "Successfully shipped to ${widget.pickupStationDetails?.name?.toUpperCase() ?? ''}";
          break;
      }
    } else if (["delivered", "received"].contains(current) &&
        (key == "delivered" || key == "received")) {
      message =
      "Successfully shipped to ${widget.pickupStationDetails?.name?.toUpperCase() ?? ''}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: statusColor,
              ),
              if (key != "received")
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                if (message != null) ...[
                  SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}





