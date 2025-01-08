import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageAutoSlider extends StatefulWidget {
  const ImageAutoSlider({super.key});

  @override
  State<ImageAutoSlider> createState() => _ImageAutoSliderState();
}

class _ImageAutoSliderState extends State<ImageAutoSlider> {
  /// HERE WE CREATE LIST OF IMAGE
  List imageList = [
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner1.png.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/blodd.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 3.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 2.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 7.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner1.png.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 8.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 9.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 6.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner5.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 4.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/banner/banner 3.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];


  int currentIndex = 0;

  MediaQueryData? mqData;

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Column(
      children: [
        /// here we apply
        CarouselSlider.builder(
            itemCount: imageList.length,
            itemBuilder: (context, index, realIndex) {
              return imageList[index];
            },
            options: CarouselOptions(
                height: mqData!.size.height * 0.2,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 15,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                })),
        const SizedBox(
          height: 8,
        ),

        /// here we show inductor
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imageList.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4.0,
              width: currentIndex == index ? 10 : 4,
              decoration: BoxDecoration(
                color: currentIndex == index ? Colors.blue : Colors.black54,
                borderRadius: BorderRadius.circular(6.8),
              ),
            );
          }),
        )
      ],
    );
  }
}

/// IN THIS VIDEO CREATE IMAGE AUTO SLIDER
/// SIMPLE STEP
/// ADD DEPENDENCY
/// complete any error then comment in comment box
/// final check check
