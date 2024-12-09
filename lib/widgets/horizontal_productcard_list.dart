import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    super.key,
    required this.giftcardData,
  });

  final List giftcardData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.26,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentWidth =
              constraints.maxWidth; //card haru ko horizontal container
          double parentHeight = constraints.maxHeight;

          return ListView.builder(
            itemCount: giftcardData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width:
                    parentWidth * 0.4, // card container ko main parent ko width
                margin: const EdgeInsets.only(right: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            blurRadius: 8, // How much the shadow is blurred
                            offset: Offset(0, 4), // Position of the shadow
                          ),
                        ],
                      ),
                      child: Container(
                        //clip rect ko child
                        height: parentHeight * 0.76,
                        decoration: const BoxDecoration(),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "./assets/images/fb_image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(6, 4, 0, 0),
                      child: Text("CSGO",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16)),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.green,
                            size: 15,
                          ),
                          Text(
                            "98166",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
