import 'package:alabtech/Widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AuthScreen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List accountTile = [
    {'icon': const Icon(Icons.person), 'label': 'My Profile'},
    {'icon': const Icon(Icons.home_outlined), 'label': 'Manage Address'},
    {'icon': const Icon(Icons.payment), 'label': 'Payment & Refund'},
    {'icon': const Icon(Icons.logout), 'label': 'Logout'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: const Text('kodiyarasan'),
              accountEmail: Text("${FirebaseAuth.instance.currentUser!.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/profile_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              arrowColor: Colors.deepOrange,
              otherAccountsPictures: [
                IconButton(onPressed: () {}, icon: Icon(Icons.edit))
              ],
            ), //DrawerHeader
            Column(
              children: List.generate(accountTile.length, (index) {
                return ListTile(
                    title: Text(accountTile[index]['label']),
                    leading: accountTile[index]['icon'],
                    onTap: (accountTile[index]['label'] == 'Logout')
                        ? () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const TextWidget(
                                                text: 'Logout',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const TextWidget(
                                                text:
                                                    'Are you sure, do you want logout?',
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: TextButton.styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10)),
                                                      child: const TextWidget(
                                                        text: 'No',
                                                        color: Colors.blue,
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        FirebaseAuth.instance
                                                            .signOut();
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginScreen(),
                                                                ),
                                                                (route) =>
                                                                    false);
                                                      },
                                                      style: TextButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10)),
                                                      child: const TextWidget(
                                                        text: 'Yes',
                                                        color: Colors.blue,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          }
                        : () {
                            Navigator.pop(context);
                          });
              }),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Alab Technology'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child: TextWidget(
                text:
                    "Hello! ${FirebaseAuth.instance.currentUser?.displayName}",
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.wavy,
                decorationColor: Colors.deepOrangeAccent,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const TextWidget(
              text: "Product Card",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            ProductCard(),
            const SizedBox(height: 24),
            const TextWidget(
              text: "Tips Section",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            TipsCard(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.orange.shade100.withOpacity(.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                height: 130,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/cake.png",
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextWidget(
                        padding: EdgeInsets.only(left: 3, bottom: 3),
                        text: "FLAT DEAL\n125 OFF\nABOVE ₹199",
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(.0),
                                Colors.black.withOpacity(.0),
                                Colors.black.withOpacity(.5),
                              ])),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            transform: GradientRotation(6),
                            tileMode: TileMode.clamp,
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(.0),
                              Colors.black.withOpacity(.0),
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (favorite == true) {
                              favorite = false;
                            } else if (favorite == false) {
                              favorite = true;
                            }
                          });
                        },
                        child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.08),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4))
                              ],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: (favorite == false)
                                ? const Icon(Icons.favorite_outline,
                                    color: Colors.white)
                                : const Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.red,
                                  )),
                      ),
                    ),

                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 3),
                    //   // foregroundDecoration: BoxDecoration(
                    //   //     gradient: LinearGradient(
                    //   //   begin: Alignment.topCenter,
                    //   //   end: Alignment.bottomCenter,
                    //   //   colors: [Colors.white, Colors.black],
                    //   // )),
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.topRight,
                    //         end: Alignment.bottomCenter,
                    //         // transform: GradientRotation(4),
                    //         // stops: const [1.0, .1, 1.0],
                    //         tileMode: TileMode.clamp,
                    //         colors: [
                    //           Colors.black,
                    //           Colors.transparent,
                    //           Colors.transparent,
                    //           Colors.transparent,
                    //         ]),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   alignment: Alignment.topRight,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             if (favorite == true) {
                    //               favorite = false;
                    //             } else if (favorite == false) {
                    //               favorite = true;
                    //             }
                    //           });
                    //         },
                    //         child: Container(
                    //             height: 36,
                    //             width: 36,
                    //             decoration: BoxDecoration(
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     color: Colors.black.withOpacity(.08),
                    //                     blurRadius: 4,
                    //                     offset: const Offset(0, 4))
                    //               ],
                    //               shape: BoxShape.circle,
                    //             ),
                    //             alignment: Alignment.center,
                    //             child: (favorite == false)
                    //                 ? const Icon(Icons.favorite_outline,
                    //                     color: Colors.white)
                    //                 : const Icon(
                    //                     Icons.favorite_outlined,
                    //                     color: Colors.red,
                    //                   )),
                    //       ),
                    //       const Spacer(),
                    //       const Align(
                    //         alignment: Alignment.bottomLeft,
                    //         child: TextWidget(
                    //           padding: EdgeInsets.only(left: 3, bottom: 3),
                    //           text: "FLAT DEAL\n125 OFF\nABOVE ₹199",
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 13,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                )),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 4),
                  const TextWidget(
                    text: "Cake Trends",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 13,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      const TextWidget(
                        text: "4.1 (140) • 40-45 mins",
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/theme.png',
                        height: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const TextWidget(
                        text: 'Perfect cake Delivery',
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  TextWidget(
                    text: "Bakery, Cakes and pastries...",
                    color: Colors.grey[600],
                  ),
                  TextWidget(
                    text: "Padapai • 3.0 km",
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TipsCard extends StatefulWidget {
  const TipsCard({super.key});

  @override
  State<TipsCard> createState() => _TipsCardState();
}

class _TipsCardState extends State<TipsCard> {
  bool checkBox = false;
  List tipsAmount = [
    {"amount": '₹20', "selectAmount": false},
    {"amount": '₹30', "selectAmount": false},
    {"amount": '₹50', "selectAmount": false},
    {"amount": 'other', "selectAmount": false},
  ];
  int? selectAmount;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Thank you for adding a Tip!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.info_outline,
                color: Colors.grey,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: "You've made their day! 100% of \n"
                            "the tip will go to your delivery\n"
                            " partner for this and future orders.",
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/swiggy.png',
                        height: 60,
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: List.generate(tipsAmount.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (selectAmount == null) {
                              selectAmount = index;
                            } else if (selectAmount == index) {
                              selectAmount = null;
                            } else {}
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectAmount != index
                              ? Colors.white
                              : Colors.orange.shade100.withOpacity(.7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: selectAmount == index
                                    ? Colors.orangeAccent.shade700
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        child: Row(
                          children: [
                            TextWidget(
                                text: tipsAmount[index]['amount'],
                                color: selectAmount == index
                                    ? Colors.orangeAccent.shade700
                                    : Colors.black),
                            const SizedBox(
                              width: 3,
                            ),
                            selectAmount == index
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectAmount = null;
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.orangeAccent.shade700,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                          size: 10,
                                        )),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: checkBox,
                      onChanged: (value) {
                        setState(() {
                          checkBox = value!;
                        });
                      },
                      activeColor: Colors.orange,
                    ),
                    const Expanded(
                        child: TextWidget(
                      text: "Add this tip automatically to future orders",
                      fontSize: 12,
                    ))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
