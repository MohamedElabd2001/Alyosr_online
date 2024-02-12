import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class DrawerController extends GetxController {

  final Uri facebookUrl = Uri.parse('https://www.facebook.com/alyosrservices');
  final Uri instagramUrl = Uri.parse('http://elfahdlaw.com');
  final Uri websiteUrl = Uri.parse('https://www.alyosr.online');
  final Uri privacyUrl = Uri.parse('http://elfahdlaw.com');
  final Uri termsUrl = Uri.parse('http://elfahdlaw.com');


  Future<void> _launchwebsite() async {
    if (await launchUrl(websiteUrl)) {
      throw Exception('Could not launch $websiteUrl');
    }
  }

  Future<void> _launchFacebook() async {
    if (!await launchUrl(facebookUrl)) {
      throw Exception('Could not launch $facebookUrl');
    }
  }

  Future<void> _launchInstagram() async {
    if (!await launchUrl(instagramUrl)) {
      throw Exception('Could not launch $instagramUrl');
    }
  }

  Future<void> _launchPrivacy() async {
    if (!await launchUrl(privacyUrl)) {
      throw Exception('Could not launch $privacyUrl');
    }
  }

  Future<void> _launchTerms() async {
    if (!await launchUrl(termsUrl)) {
      throw Exception('Could not launch $termsUrl');
    }
  }
}
