class IssueImages {
  int? id;
  String? imagePath;
  int? issueId;
  String? issue;

  IssueImages({this.id, this.imagePath, this.issueId, this.issue});

  IssueImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['imagePath'];
    issueId = json['issueId'];
    issue = json['issue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['issueId'] = this.issueId;
    return data;
  }
}