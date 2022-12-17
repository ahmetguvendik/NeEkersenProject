class ActivityModel {
  String? id;
  String? title;
  String? date;
  String? description;
  String? category;
  String? city;
  String? venue;

  ActivityModel(
      {this.id,
        this.title,
        this.date,
        this.description,
        this.category,
        this.city,
        this.venue});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
    category = json['category'];
    city = json['city'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    data['category'] = this.category;
    data['city'] = this.city;
    data['venue'] = this.venue;
    return data;
  }

}