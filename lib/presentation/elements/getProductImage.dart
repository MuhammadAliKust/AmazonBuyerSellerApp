import 'package:flutter/material.dart';

class GetProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/product.png'),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: FloatingActionButton.extended(
                  onPressed: () {}, label: Text("CHAT NOW")),
            ),
          ),
        )
      ],
    );
  }
}
