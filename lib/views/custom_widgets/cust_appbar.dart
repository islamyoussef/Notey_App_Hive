import 'package:flutter/material.dart';

class CustAppBar extends StatefulWidget {
  const CustAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick,
  });

  final String title;
  final IconData icon;
  final VoidCallback onClick;

  @override
  State<CustAppBar> createState() => _CustAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the preferred size
}

class _CustAppBarState extends State<CustAppBar> {
  bool isSearchReady = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.1),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child:
                !isSearchReady
                    ? InkWell(
                      onTap: () {
                        setState(() {
                          isSearchReady = !isSearchReady;
                        });

                        widget.onClick;
                      },
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Match the container's border radius
                      child: Icon(widget.icon, size: 24), // Adjusted icon size
                    )
                    : InkWell(
                      onTap: () {
                        setState(() {
                          isSearchReady = !isSearchReady;
                        });
                      },
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Match the container's border radius
                      child: Icon(Icons.close, size: 24),
                    ),
          ),
        ],
      ),
    );
  }
}
