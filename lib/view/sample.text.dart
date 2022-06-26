import 'package:flutter/material.dart';

class SampleText extends StatelessWidget {
  const SampleText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 350,
                        height: 350,
                        child: FittedBox(
                          child: Text(
                            'SP',
                            style: TextStyle(
                              color: theme.scaffoldBackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rajdhani',
                              // fontSize: 100,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 50,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'iNNOVATIONS',
                          style: TextStyle(
                            color: theme.scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rajdhani',
                            fontSize: 60,
                            height: 2
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
