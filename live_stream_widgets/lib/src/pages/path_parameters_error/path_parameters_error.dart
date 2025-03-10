import 'package:flutter/material.dart';

class PathParametersError extends StatelessWidget {
  final String pagePath;
  final Map<String, dynamic> queryParameters;

  const PathParametersError({
    super.key,
    required this.pagePath,
    required this.queryParameters,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Page with path $pagePath requires query parameters: $queryParameters',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
