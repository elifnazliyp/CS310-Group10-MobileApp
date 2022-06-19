import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;
  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  CommentScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final data = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(data.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                data.username,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                data.comment,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                timeago.format(data.datePublished.toDate()),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${data.likes.length} likes',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () =>
                                  commentController.likeComment(data.id),
                                  
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: data.likes
                                        .contains(firebaseAuth.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.white,
                              )),
                        );
                      },
                    );
                  }),
                ),
                Divider(),
                ListTile(
                  title: TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'comment',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      commentController.postComment(_commentController.text);
                      _commentController.clear();
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
