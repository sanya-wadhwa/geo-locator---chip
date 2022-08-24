import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seats/search.dart';

class DeliveryLocation extends StatefulWidget {
  const DeliveryLocation({Key? key}) : super(key: key);

  @override
  State<DeliveryLocation> createState() => _DeliveryLocationState();
}

//changes in GRADLE.Properties
//changes in app/src/main --  ANDROIDMANIFEST.xml
//changes in ios/runner/info.plist ADD KEYS

class _DeliveryLocationState extends State<DeliveryLocation> {
  TextEditingController venueController = TextEditingController();
  TextEditingController locationText = TextEditingController();
  List<String> venue = [
    'oxford university',
    'sector 45',
    'noida one',
    'techahead',
    'tech mahindra'
  ];
  String? selectedPlace;

  List<String> cities = [
    'London',
    'Mumbai',
    'Delhi',
    'Chandigarh',
    'Shimla',
    'Calfornia'
  ];

  String location = 'Null, Press Button';
  String address = "";

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Delivery Partner Application",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Colors.black87,
            )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 20, right: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Preferred Location",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const Text(
                  "Please select your preferred work location",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Location",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                const SizedBox(
                  height: 20,
                ),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: Colors.grey,
                      controller: locationText,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            Position position = await _getGeoLocationPosition();
                            location =
                                'Lat: ${position.latitude} , Long: ${position.longitude}';

                            GetAddressFromLatLong(position);

                            print("location $location");
                            setState(() {
                              locationText.text = address;
                            });
                          },
                          icon: const Icon(
                            Icons.location_searching,
                            color: Colors.red,
                          ),
                        ),
                        hintText: "Enter Location",
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      )),
                  suggestionsCallback: (pattern) {
                    List<String> matches = <String>[];
                    matches.addAll(cities);

                    matches.retainWhere((s) {
                      return s.toLowerCase().contains(pattern.toLowerCase());
                    });
                    return matches;
                  },
                  itemBuilder: (context, sone) {
                    return locationText.text.isNotEmpty
                        ? Card(
                            child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(sone.toString()),
                          ))
                        : Container();
                  },
                  onSuggestionSelected: (suggestion) {
                    locationText.text = suggestion.toString();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Venue",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  icon: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: Colors.black,
                      )),
                  hint: const Text('Select'),
                  decoration: const InputDecoration(
                    // constraints: BoxConstraints(maxWidth: 350, minWidth: 150),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  value: selectedPlace,
                  items: venue
                      .map((item) => DropdownMenuItem(
                            // alignment: Alignment.bottomCenter,
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(),
                            ),
                          ))
                      .toList(),
                  onChanged: (item) {
                    setState(
                      () => selectedPlace = item,
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: MediaQuery.of(context).size.width - 30,
                        height: 45),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Application()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
