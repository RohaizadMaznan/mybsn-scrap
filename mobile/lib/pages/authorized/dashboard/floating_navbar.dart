import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FloatingNavbar extends StatefulWidget {
  const FloatingNavbar({Key? key, required this.updateCurrentPage}) : super(key: key);

  final void Function(int) updateCurrentPage;

  @override
  State<FloatingNavbar> createState() => _FloatingNavbarState();
}

class _FloatingNavbarState extends State<FloatingNavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 64,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff02c3d6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: ()=>widget.updateCurrentPage(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/imgs/dashboard.svg'),
                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: ()=>widget.updateCurrentPage(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/imgs/duitnow.svg'),
                    const Text(
                      "DuitNow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: ()=>widget.updateCurrentPage(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/imgs/stats.svg'),
                    const Text(
                      "Stats",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Signika",
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
