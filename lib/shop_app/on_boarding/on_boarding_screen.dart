import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled5/remote/cache_helper.dart';
import 'package:untitled5/styels/color.dart';
import '../../screens/login/screen/shop_login_screen.dart';

class BoardingMoudel{
  late String image;
  late String title;
  late String body;

  BoardingMoudel({
    required this.title,
    required this.body,
    required this.image,
});
}
class OnBoardingScreen extends StatefulWidget {

   const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  var boardingController = PageController();


  List<BoardingMoudel> boarding=[
    BoardingMoudel(
        title:'on Board 1 title' ,
        body: 'on Board 1 body',
        image:('assets/images/logo.jpg'),
    ),
    BoardingMoudel(
        title:'on Board 2 title' ,
        body: 'on Board 2 body',
      image:('assets/images/logo.jpg'),
    ),
    BoardingMoudel(
        title:'on Board 3 title' ,
        body: 'on Board 3 body',
      image:('assets/images/logo.jpg'),
    ),
  ];
var isLast = false;
final controller = PageController();
void submit(){
  CacheHelper.saveData(
      key:'OnBoarding' ,
      value: true,
  ).then((value){
    if(value)
      {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context)=>ShopLoginScreen(),
          ),
        );
      }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child:const Text(
                'Skip',
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child:
                PageView.builder(
                  controller: boardController,
                  onPageChanged: (int index){
                    {
                      if (index == (boarding.length - 1) && !isLast) {
                        setState(() => isLast = true);
                      } else if (isLast) {
                        setState(() => isLast = false);
                      }
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                ),
            ),
             Row(
              children: [
               SmoothPageIndicator(
                   controller:boardingController ,
                   effect: const ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     activeDotColor: defaultColor,
                     dotWidth: 10,
                     dotHeight: 10,
                     expansionFactor: 4,
                     spacing: 5.0,
                   ),
                   count: 3,
               ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  child: const Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                    onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                    }
                ),
              ],

            ),
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingMoudel moudel)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image.asset(
        moudel.image,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        moudel.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        moudel.body,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ],
  );
}
