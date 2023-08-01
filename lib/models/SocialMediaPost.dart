/**
 * 
 * {
"userId": 1,
"id": 1,
"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
"body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
},
 */

class SocialMediaPost {
  int userId;
  int id;
  String title;
  String body;

  SocialMediaPost(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory SocialMediaPost.fromMap(Map<String, dynamic> apiDataMap) {
    return SocialMediaPost(
        userId: apiDataMap["userId"],
        id: apiDataMap["id"],
        title: apiDataMap["title"],
        body: apiDataMap["body"]);
  }

  Map<String, dynamic> toMap() {
    return {"userId": userId, "id": id, "title": title, "body": body};
  }
}
