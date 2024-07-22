class EndpointService {
  // ------------------- COMMON ENDPOINTS -------------------

  // -------------------- USER ENDPOINTS --------------------

  // GET Endpoint
  static const String getRecommendedJobs = 'jobPosting/recommendation';
  static const String getUserProfile = 'jobSeeker';

  // POST Endpoints
  static const String userLeftSwipe = 'jobApplication/user/leftSwipe';
  static const String userUploadVideoWithThumbnail = 'jobPosting/media';
  static const String userJobApply = 'jobApplication/user/rightSwipe';

  // UPDATE Endpoints


  // ------------------ EMPLOYER ENDPOINTS ------------------

  // GET Endpoint
  static const String getRequisitions = 'jobPosting/requisitions';
  static const String getJobPostings = 'jobPosting/created';


  // POST Endpoints
  static const String createJobPostings = 'jobPosting/create';

  // UPDATE Endpoints
  static const String closeJobPostings = 'jobPosting/close';
  static const String updateJobPostings = 'jobPosting/update';

}