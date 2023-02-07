import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget{
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      title: Center(
        child: Container(
          height:50,
          width:50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),

          child: const Image(
            image: AssetImage("assets/appLogo.png"),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 100.0,
      leading: IconButton(
        onPressed: (){},
        icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black ),
      ),
      actions: [
        Transform.scale(
          scale: 1.5,
          child: IconButton(
            onPressed: (){},
            icon: const Icon(Icons.account_circle_outlined , color: Colors.black),
          ),
        ),
      ],
    );
  }
}


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(70.0,10.0,70.0,10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: 40,
        child: const TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 7, 0, 5),
            prefixIcon: Icon(Icons.search_outlined , color: Colors.black),
            border: InputBorder.none,
            fillColor: Colors.white,
            hintText: 'Search...',
          ),
        ),
      ),
    );
  }
}




