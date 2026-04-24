import '/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class QuotesDesign1 extends StatelessWidget {
  const QuotesDesign1({
    Key? key,
    required this.size,
    required this.color,
    required this.bodyText,
    required this.footerText,
  }) : super(key: key);

  final Color color;
  final String bodyText, footerText;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width - SizeConfig.width(16),
      height: size.width / 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(SizeConfig.height(20)),
          topRight: Radius.circular(SizeConfig.height(20)),
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4,
            color: Colors.grey,
          ),
        ],
      ),
      child: Stack(
        children: [
          /// TOP QUOTE ICON
          Icon(
            Icons.format_quote,
            color: Theme.of(context).primaryIconTheme.color,
          ),

          /// BODY TEXT
          Positioned(
            top: 20,
            width: size.width - SizeConfig.width(16),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width(8)),
                child: Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ),

          /// FOOTER TEXT
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width(8)),
                child: Text(
                  footerText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).primaryIconTheme.color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}