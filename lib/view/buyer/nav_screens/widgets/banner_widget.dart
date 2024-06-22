import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //temp list
  final List<String> _bannerImage = [
    'https://thumbs.dreamstime.com/b/stock-trading-investment-candle-market-chart-diagram-website-header-banner-city-view-skyline-181698947.jpg',
    'https://thumbs.dreamstime.com/b/stock-trading-investment-candle-market-chart-diagram-website-header-banner-city-view-skyline-181698947.jpg',
    'https://thumbs.dreamstime.com/b/stock-trading-investment-candle-market-chart-diagram-website-header-banner-city-view-skyline-181698947.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
        child: PageView.builder(
          itemCount: _bannerImage.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: _bannerImage[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 10),
                  interval: const Duration(seconds: 10),
                  color: Colors.white,
                  colorOpacity: 0,
                  enabled: true,
                  direction: const ShimmerDirection.fromLBRT(),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          },
        ),
      ),
    );
  }
}
