import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GetReviewSS extends StatelessWidget {
  final String imageUrl;
  GetReviewSS(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 140,
        width: 150,
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
    // return Container(
    //   height: 140,
    //   width: 150,
    //   decoration: BoxDecoration(
    //       color: Colors.blue,
    //       image: DecorationImage(
    //           image: AssetImage(
    //             'assets/images/SS.png',
    //           ),
    //           fit: BoxFit.cover)),
    //   child: Stack(
    //     children: [
    //       Positioned.fill(
    //           child: Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             Container(
    //               height: 30,
    //               width: 30,
    //               decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: FrontEndConfigs.appBaseColor),
    //               child: Center(
    //                 child: Icon(
    //                   Icons.edit,
    //                   size: 17,
    //                 ),
    //               ),
    //             ),
    //             HorizontalSpace(8),
    //             Container(
    //               height: 30,
    //               width: 30,
    //               decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: FrontEndConfigs.appBaseColor),
    //               child: Center(
    //                 child: Icon(
    //                   Icons.download_rounded,
    //                   size: 17,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),
    //     ],
    //   ),
    // );
  }
}
