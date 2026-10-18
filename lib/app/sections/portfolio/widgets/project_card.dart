import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mysite/app/utils/project_utils.dart';
import 'package:mysite/core/color/colors.dart';
import 'package:mysite/core/res/responsive.dart';
import 'package:mysite/core/util/constants.dart';
import 'package:sizer/sizer.dart';
class ProjectCard extends StatefulWidget {
  final ProjectUtils project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);
  @override
  ProjectCardState createState() => ProjectCardState();
}

class ProjectCardState extends State<ProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (!Responsive.isDesktop(context)) {
          setState(() => isHover = !isHover);
        }
      },
      onHover: (isHovering) {
        if (!Responsive.isDesktop(context)) return;
        setState(() => isHover = isHovering);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        width: Responsive.isDesktop(context) ? 30.w : 70.w,
        height: 36.h,
        decoration: BoxDecoration(
          gradient: isHover ? pinkpurple : grayBack,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isHover ? [primaryColorShadow] : [blackColorShadow],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isHover ? 0.1 : 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: IgnorePointer(
                  child: _BannerCarousel(
                    images: widget.project.banners,
                    height: 36.h,
                  ),
                ),
              ),
            ),
            if (isHover)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.project.icons,
                      height: height * 0.045,
                    ),
                    SizedBox(height: height * 0.012),
                    Text(
                      widget.project.titles,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.008),
                    Text(
                      widget.project.description,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: whiteColor.withOpacity(0.95),
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (widget.project.playStoreUrl != null)
                          _StoreButton(
                            label: 'Google Play',
                            iconPath: 'assets/icons/android.svg',
                            onTap: () =>
                                openURL(widget.project.playStoreUrl!),
                          ),
                        if (widget.project.appStoreUrl != null)
                          _StoreButton(
                            label: 'App Store',
                            iconPath: 'assets/icons/apple.svg',
                            onTap: () =>
                                openURL(widget.project.appStoreUrl!),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BannerCarousel extends StatelessWidget {
  final List<String> images;
  final double height;

  const _BannerCarousel({
    required this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return SizedBox(height: height);
    }
    if (images.length == 1) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Image.asset(
          images.first,
          fit: BoxFit.cover,
        ),
      );
    }
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return SizedBox(
          height: height,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: height,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        pauseAutoPlayOnTouch: false,
      ),
    );
  }
}

class _StoreButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  const _StoreButton({
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  textColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
