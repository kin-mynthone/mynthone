part of '../views/onboarding_view.dart';

class _OnboardingWidget extends StatelessWidget {
  const _OnboardingWidget({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNumbers.screenPadding,
        vertical: AppNumbers.screenPadding,
      ),
      child: Column(
        children: [
          _ImageWidget(imagePath: imagePath),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(title: title),
              const SizedBox(
                height: 20,
              ),
              _Description(description: description),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        width: 300,
        height: 400,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text: title,
      color: AppColors.hF6F6F6,
      fontWeight: FontWeight.w700,
      fontSize: 30,
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      text: description,
      color: AppColors.hF6F6F6,
      fontSize: 15,
    );
  }
}
