import 'package:hirevire_app/constants/image_constants.dart';

class GlobalConstants {
  static int maxHeadlineChars = 50;
  static int maxBioChars = 1000;
  static int maxExpDescriptionChars = 4000;
  static double screenHorizontalPadding = 16.0;
  static int trendingProfileMinViewCount = 1;

  static var suggestions = [
    'Web Development',
    'Web Design',
    'Web Services',
    'Web Applications',
    'Web Content Writing',
    'Web Analytics',
    'Amazon Web Services (AWS)',
    'Social Media',
    'Web 2.0'
  ];

  static List<String> employmentTypes = [
    "Please select",
    'Full-time',
    'Part-time',
    'Self-employed',
    'Freelance',
    'Internship',
    'Trainee'
  ];

  static const List<String> statusList = [
    'Pending',
    'Rejected',
    'Approved',
  ];

  static List<String> locationTypes = [
    "Please select",
    'Onsite',
    'Hybrid',
    'Remote',
  ];

  static Map<String, String> socialProfileTypesMap = {
    'Select': "",
    'Github': ImageConstant.githubLogo,
    'LinkedIn': ImageConstant.linkedInLogo,
    'Instagram': ImageConstant.instagramLogo,
    'X': ImageConstant.xLogo,
    'Twitter': ImageConstant.xLogo,
    'Youtube': ImageConstant.youtubeLogo,
    'Facebook': ImageConstant.facebookLogo,
    'Other': ImageConstant.linkOtherIcon,
  };

  static Map<String, int> monthsMap = {
    'Month': -1,
    'Jan': 0,
    'Feb': 1,
    'Mar': 2,
    'Apr': 3,
    'May': 4,
    'Jun': 5,
    'Jul': 6,
    'Aug': 7,
    'Sep': 8,
    'Oct': 9,
    'Nov': 10,
    'Dec': 11,
  };

  static List<String> get years {
    int currentYear = DateTime.now().year;
    return ["Year"] +
        List.generate(101, (index) => (currentYear - index).toString());
  }
}
