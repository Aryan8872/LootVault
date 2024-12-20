import 'package:flutter/material.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    super.key,
    required this.cardData,
    required this.itemName,
    required this.price,
    this.rating = "0",
  });

  final List cardData;
  final String rating;
  final String price;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight; // Detect landscape mode

    return SizedBox(
      height: screenHeight *
          (isLandscape ? 0.5 : 0.3), // Adjust height based on orientation
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentWidth = constraints.maxWidth;
          double parentHeight = constraints.maxHeight;

          return ListView.builder(
            itemCount: cardData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: parentWidth *
                    (isLandscape
                        ? 0.30
                        : 0.37), // Adjust width based on orientation
                margin: EdgeInsets.only(
                    right: screenWidth * 0.05), // Responsive margin
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        height: parentHeight *
                            0.76, // Adjust height of image container
                        decoration: const BoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            cardData[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Item name and rating row
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        3,
                        2,
                        0,
                        0,
                      ),
                      child: Row(
                        children: [
                          Text(itemName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith()),
                          const Spacer(),
                          if (rating != "0")
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow[600],
                                  size: (isLandscape
                                      ? 17
                                      : 17), // Responsive icon size
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Text(rating,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith()),
                              ],
                            ),
                        ],
                      ),
                    ),
                    // Price row

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Colors.green,
                            size: (isLandscape
                                ? 0.05
                                : 16.6), // Responsive icon size
                          ),
                          Text(price,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.green)),
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
