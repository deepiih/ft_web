class GetDashboard {
  bool? status;
  String? lifetimeRevenue;
  String? underReviewFunds;
  String? lastWeeksEarnings;
  bool? isStripeOnboardingCompleted;
  bool? instantPayoutSupported;
  List<Videos>? videos;
  String? message;

  GetDashboard(
      {this.status,
        this.lifetimeRevenue,
        this.underReviewFunds,
        this.lastWeeksEarnings,
        this.isStripeOnboardingCompleted,
        this.instantPayoutSupported,
        this.videos,
        this.message});

  GetDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    lifetimeRevenue = json['lifetime_revenue'];
    underReviewFunds = json['under_review_funds'];
    lastWeeksEarnings = json['last_weeks_earnings'];
    isStripeOnboardingCompleted = json['is_stripe_onboarding_completed'];
    instantPayoutSupported = json['instant_payout_supported'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['lifetime_revenue'] = this.lifetimeRevenue;
    data['under_review_funds'] = this.underReviewFunds;
    data['last_weeks_earnings'] = this.lastWeeksEarnings;
    data['is_stripe_onboarding_completed'] = this.isStripeOnboardingCompleted;
    data['instant_payout_supported'] = this.instantPayoutSupported;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Videos {
  int? id;
  String? title;
  String? description;
  String? url;
  String? createdAt;
  String? updatedAt;

  Videos(
      {this.id,
        this.title,
        this.description,
        this.url,
        this.createdAt,
        this.updatedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
