import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _circleFade;
  late Animation<double> _checkScale;
  late Animation<double> _sparkScale;
  late Animation<double> _textFade;
  late Animation<Offset> _checkOffsetAnimation;


  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2250),
    );

    //  ظهور الدائرة
    _circleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    //  دخول الصح مع تكبير ناعم
    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.6, curve: Curves.easeOutBack),
      ),
    );
// تعريف حركة دخول الصح من الأعلى واليمين إلى مكانه
    _checkOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.35, -0.35), // يبدأ من الأعلى واليمين
      end: Offset.zero,                 // يستقر في الموقت المطلوب
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.6, curve: Curves.easeOutBack),
      ),
    );


    //  ظهور السبارك
    _sparkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 0.8, curve: Curves.elasticOut),
      ),
    );

    //  ظهور اسم التطبيق في الأسفل
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );


    _controller.forward();


    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        // كود الانتقال للشاشة الرئيسيهً
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // تكوين اللوجو من الطبقات المتحركة فوق بعضها
            SizedBox(
              width: 250,
              height: 250,
              child: Stack(

                children: [
                  // 1. الدائرة
                  Positioned.fill(
                    child: FadeTransition(
                      opacity: _circleFade,
                      child: Image.asset(
                        AppAssets.circle,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
// 2. علامة الصح مع حركة الدخول للمنتصف
                  Positioned(
                    top:-1,
                    left: 10,
                    child: SlideTransition(
                      position: _checkOffsetAnimation,
                      child: ScaleTransition(
                        scale: _checkScale,
                        child: Transform.rotate(
                          angle: -0.12,
                          child: Image.asset(
                            AppAssets.check,
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // تأثير الاضاءللشاحن السفلي
                  Positioned(
                    bottom: 0,
                    left: 35,
                    child: ScaleTransition(
                      scale: _sparkScale,
                      child: Container(
                        width: 170,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.withValues(alpha: 0.7),
                              blurRadius:30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),


            FadeTransition(
              opacity: _textFade,
              child: const Text(
                'Taskify',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryMedium,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


