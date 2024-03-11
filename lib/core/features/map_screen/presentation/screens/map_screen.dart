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
     LatLng newLanLng;
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
                
              },
              initialCameraPosition: const CameraPosition(
                  target: LatLng(42.882004, 74.582748), zoom: 15)),
          Center(
              child: BlocListener<GeolocationCubit, GeolocationState>(
            listener: (context, state) {
              if (state is GeolocationSuccess) {
                if(state.geolocationModel==null){
                  addressController.text =
                    state.locationByAddressModel?.results?.first.formattedAddress ?? "";
                    newLanLng=LatLng(state.locationByAddressModel?.results?.first.geometry?.location?.lat??0, state.geolocationModel?.results?.first.geometry?.location?.lng??0);
                

                }else{
                  addressController.text =
                    state.geolocationModel?.results?.first.formattedAddress ?? "";
                    newLanLng=LatLng(state.geolocationModel?.results?.first.geometry?.location?.lat??0, state.geolocationModel?.results?.first.geometry?.location?.lng??0);
              
                }
                 

                markers.add(Marker(
                    markerId: const MarkerId("Targetlocation"), position: newLanLng ));
                    setState(() {
                      
                    });
              }
            },
            child: Container(),
            
          )),
          Positioned(
              bottom: 100,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AddressContainer(addressController: addressController,
                onPressed: ()
                {BlocProvider.of<GeolocationCubit>(context).getLocationByAddress(addressController.text);},),
              ),
            ),
        ],
      ),
    );
  }
}

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key,
    required this.addressController, required this.onPressed,
  });

  final TextEditingController addressController;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onPressed: onPressed,
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
    );
  }
}
