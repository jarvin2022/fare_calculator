import 'package:farecalculator/packages.dart';

class HomeView extends GetView<UserController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 79, 88, 88),
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: const TextWidget(
          title: 'Tricy Fare Calculator',
          color: Color.fromARGB(255, 79, 88, 88),
          fontSized: 20,
          fontWeight: FontWeight.w600,
        ),
        flexibleSpace: Container(
          width: Get.width,
          height: 35,
          color: const Color.fromARGB(255, 78, 176, 18),
        ),
      ),
      drawer: drawer(),
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
                child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Obx(
                () => GoogleMap(
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition:
                      controller.hcontroller!.initialGooglePlex,
                  polylines: controller.hcontroller!.polylines.value!,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  buildingsEnabled: false,
                  trafficEnabled: false,
                  onMapCreated: (GoogleMapController gmapController) {
                    controller.hcontroller!.completer.complete(gmapController);
                    controller.hcontroller!.googleMapController =
                        gmapController;
                  },
                ),
              ),
            )),
            Positioned(bottom: 20, child: bottom()),
            Obx(() => Positioned(
                top: 0,
                child: controller.hcontroller?.transaction?.value == null
                    ? const FareWidgetView()
                    : topJourneyStart()))
          ],
        ),
      )),
    );
  }

  Drawer drawer() {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 78, 176, 18)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: TextWidget(
                        title: controller.user.value?.userFirstName?[0] ?? '',
                        color: const Color.fromARGB(255, 78, 176, 18),
                        fontSized: 36,
                        fontWeight: FontWeight.w700),
                  ),
                  TextWidget(
                    title:
                        '${controller.user.value?.userFirstName} ${controller.user.value?.userLastName}',
                    color: Colors.white,
                    fontSized: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.mode_of_travel_rounded,
                size: 28, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'Fare Rate',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(rateRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded,
                size: 28, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'Account',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(accountRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_history_outlined,
                size: 30, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'History',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(historyRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.password_rounded,
                size: 28, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'Change Password',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(passwordRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning_amber_rounded,
                size: 28, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'Terms and Condition',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(termsRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded,
                size: 28, color: Color.fromARGB(255, 79, 88, 88)),
            title: const TextWidget(
                title: 'About',
                color: Color.fromARGB(255, 79, 88, 88),
                fontSized: 14,
                fontWeight: FontWeight.w500),
            onTap: () {
              Get.toNamed(aboutRoute);
            },
          ),
          SizedBox(height: Get.height * 0.25),
          Center(
            child: MaterialButton(
              minWidth: Get.width * 0.7,
              height: 35,
              color: const Color.fromARGB(255, 78, 176, 18),
              onPressed: () {
                controller.signOut();
              },
              child: const TextWidget(
                  title: "Log out",
                  fontSized: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget topJourneyStart() {
    return SizedBox(
      width: Get.width,
      height: 180,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned.fill(
                  child: SizedBox(
                width: Get.width,
                height: 150,
              )),
              Positioned(
                  top: 3,
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width * 0.95,
                  height: 120,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 1, spreadRadius: 1)
                  ], borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: Get.width * 0.95,
                    height: 120,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 78, 176, 18),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => TextWidget(
                                    title:
                                        'Duration : ${controller.hcontroller?.transaction!.value!.retrieveTimeTravel()}',
                                    fontSized: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Obx(
                                  () => TextWidget(
                                    title:
                                        'Distance : ${controller.hcontroller?.transaction!.value!.transactionDistance.value ?? "2 km"}',
                                    fontSized: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.white,
                              indent: 15,
                              endIndent: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FareRate(),
                                Container(
                                  width: 170,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Obx(
                                        () => TextWidget(
                                          title:
                                              'FARE : ${PriceClass().priceFormat(controller.hcontroller!.transaction!.value!.transactionFare.value)}',
                                          fontSized: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromARGB(
                                              255, 79, 88, 88),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Center(
                              child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SvgPicture.asset('./assets/logo/Logo.svg'),
                          )),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  Widget bottom() {
    return SizedBox(
      width: Get.width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Obx(
          () => Container(
            width: Get.width,
            height: 40,
            decoration: BoxDecoration(
                color: controller.hcontroller?.transaction?.value == null
                    ? const Color.fromARGB(255, 78, 176, 18)
                    : Colors.deepOrange,
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: MaterialButton(
                onPressed: () {
                  if (controller.hcontroller?.transaction?.value == null) {
                    Get.toNamed('/scan');
                    return;
                  }
                  Get.toNamed(transactionRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    TextWidget(
                      title: controller.hcontroller?.transaction?.value == null
                          ? 'Start Journey'
                          : 'End Journey',
                      color: Colors.white,
                      fontSized: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
