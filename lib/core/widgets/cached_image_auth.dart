import 'package:InOut/core/constant/url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedImageAuth extends StatefulWidget {
  const CachedImageAuth({
    super.key,
    required this.photo,
    required this.errorWidget,
    required this.size,
  });

  final String photo;
  final double size;
  final Widget Function(BuildContext, String, Object)? errorWidget;

  @override
  State<CachedImageAuth> createState() => _CachedImageAuthState();
}

class _CachedImageAuthState extends State<CachedImageAuth> {
  late SharedPreferences prefs;
  String token = "";

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString("access_token")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (token == "")
        ? Center(
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "$baseUrl/storage/img/${widget.photo}",
            errorWidget: widget.errorWidget,
            httpHeaders: {
              "Cookie": "access_token=${prefs.getString("access_token")!}"
            },
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: progress.progress,
                ),
              ),
            ),
          );
  }
}
