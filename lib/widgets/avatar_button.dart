import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({
    super.key,
    this.imageSize = 100
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black26,
                        offset: Offset(0, 20)
                      ),

                    ]
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://iconspng.com/images/young-user-icon.jpg',
                      width: imageSize,
                      height: imageSize,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 0,

                  child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2
                    ),
                    color: Colors.pink,
                    shape: BoxShape.circle
                    ),
                    child: const Icon(
                        Icons.add,
                        color: Colors.white
                      )
                  ),
                  onPressed: () {},
                                        ),
                ),
              ],
            );
  }
}