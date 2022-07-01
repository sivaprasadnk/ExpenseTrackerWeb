import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class SampleText extends StatelessWidget {
  const SampleText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mesh1.jpg'),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: const [
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 350,
                          child: FittedBox(
                            child: Text(
                              'SP',
                              style: TextStyle(
                                color: Colors.black45,
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
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rajdhani',
                              fontSize: 60,
                              height: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).frosted(
                    blur: 1,
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            // Text(
            //   'Frost',
            //   style: theme.textTheme.headline4,
            // ).frosted(
            //   blur: 2,
            //   borderRadius: BorderRadius.circular(20),
            //   padding: const EdgeInsets.all(8),
            // ),
          ],
        ),
      ),
    );
  }
}
