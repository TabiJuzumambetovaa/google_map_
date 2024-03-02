import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_map/core/features/map_screen/presentation/cubit/geolocation_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("MyLocation"),
      position: LatLng(42.882004, 74.582748),
    )
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.terrain,
              onMapCreated: (controller) => _controller.complete(controller),
              markers: markers,
              onTap: (val) {
                BlocProvider.of<GeolocationCubit>(context)
                    .getLocationByLatLng(val);
                markers.add(Marker(
                    markerId: const MarkerId("Targetlocation"), position: val));
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(42.882004, 74.582748), zoom: 15)),
          Center(
              child: BlocListener<GeolocationCubit, GeolocationState>(
            listener: (context, state) {
              if (state is GeolocationSuccess) {
                addressController.text =
                    state.model.results?.first.formattedAddress ?? "";
                setState(() {});
              }
            },
            child: Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.165,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff1F212A)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(
                              color: Color(0xffD0D0D0),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          controller: addressController,
                          decoration: InputDecoration(
                              hintText: "Where would you go?",
                              hintStyle: const TextStyle(
                                  color: Color(0xffD0D0D0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              fillColor: const Color(0xff35383F),
                              filled: true,
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  )),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffEDAE10)))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
          // const Center(child: BlocBuilder<GeolocationCubit, GeolocationState>(
          //   builder: (context, state) {
          //     if (state is GeolocationSuccess) {
          //       return Text(
          //         "hhjdjdjghhf",
          //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          //       );
          //     }
          //     return SizedBox();
          //   },
          // )),
        ],
      ),
    );
  }
}
