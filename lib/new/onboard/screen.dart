import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../screens/Home_page.dart';
import 'model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      Onboard(
        title: "Title",
        subtitle:
        "SubTitle",
        lottie: "laww",
      ),
      Onboard(
        title: 'Title',
        lottie: 'law',
        subtitle:
        'SubTitle',
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: c,
          itemCount: list.length,
          itemBuilder: (ctx, ind) {
            final isLast = ind == list.length - 1;
            return Center(
              child: Column(
                children: [
                  Lottie.asset("assets/lottie/${list[ind].lottie}.json",
                      height: MediaQuery.of(context).size.height * .6),
                  Text(
                    list[ind].title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .5,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(
                      list[ind].subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 13.5,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 10,
                    children: List.generate(
                      list.length,
                          (i) => Container(
                        width: i == ind ? 15 : 10,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == ind ? Colors.blue : Colors.grey,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        elevation: 0,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * .4,
                          55,
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        if (isLast) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => home_page(),
                            ),
                          );
/*Get.off(()=> home_page());*/

                        } else {
                          c.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        isLast ? "Finish" : "Next",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
