import 'package:cloud_firestore/cloud_firestore.dart';

import '../Constants/Constants.dart';
import '../Models/Post.dart';
import '../Models/UserModel.dart';

class DatabaseServices {
  static Future<int> followersNum(String userId) async {
    QuerySnapshot followersSnapshot =
    await followersRef.doc(userId).collection('Followers').get();

    return followersSnapshot.docs.length;
  }

  static Future<int> followingNum(String userId) async {
    QuerySnapshot followingSnapshot =
    await followingRef.doc(userId).collection('Following').get();

    return followingSnapshot.docs.length;
  }

  static void updateUserData(UserModel user) {
    usersRef.doc(user.id).update({
      'name': user.name,
      'bio': user.bio,
      'profilePicture': user.profilePicture,
      'coverImage': user.coverImage,
    });
  }


  static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = usersRef
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z')
        .get();

    return users;
  }

  static void followUser(String currentUserId, String visitedUserId) {
    followingRef
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .set({});
    followersRef
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .set({});

  }

  static void unFollowUser(String currentUserId, String visitedUserId) {
    followingRef
        .doc(currentUserId)
        .collection('Following')
        .doc(visitedUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    followersRef
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  static Future<bool> isFollowingUser(String currentUserId,
      String visitedUserId) async {
    DocumentSnapshot followingDoc = await followersRef
        .doc(visitedUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get();
    return followingDoc.exists;
  }

  static void createPost(Post post) {
    postsRef.doc(post.authorId).set({'postTime': post.timestamp});
    postsRef.doc(post.authorId).collection('userPosts').add({
      'text': post.text,
      'image': post.image,
      "authorId": post.authorId,
      "timestamp": post.timestamp,
      'likes': post.likes,
    }).then((doc) async {
      QuerySnapshot followerSnapshot =
      await followersRef.doc(post.authorId).collection('Followers').get();

      for (var docSnapshot in followerSnapshot.docs) {
        feedRef.doc(docSnapshot.id).collection('userFeed').doc(doc.id).set({
          'text': post.text,
          'image': post.image,
          "authorId": post.authorId,
          "timestamp": post.timestamp,
          'likes': post.likes,
        });
      }
    });
  }

  static Future<List> getUserPosts(String userId) async {
    QuerySnapshot userPostsSnap = await postsRef
        .doc(userId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
    List<Post> userPosts =
    userPostsSnap.docs.map((doc) => Post.fromDoc(doc)).toList();

    return userPosts;
  }


  static Future<List> getHomePosts(String currentUserId) async {
    QuerySnapshot homePosts = await feedRef
        .doc(currentUserId)
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .get();

    List<Post> followingPosts = homePosts.docs.map((doc) => Post.fromDoc(doc)).toList();
    return followingPosts;
  }

  // static void likePost(String currentUserId, Post post){
  //   DocumentReference postDocProfile = postsRef.doc(post.authorId).collection('userPosts').doc(post.id);
  //
  //   postDocProfile.get().then((doc){
  //     int likes = doc.data()!['likes'];
  //     postDocProfile.update(('likes': likes+1));
  //   });
  // }
  static void likePost(String currentUserId, Post post) {
    DocumentReference postDocProfile =
    postsRef.doc(post.authorId).collection('userPosts').doc(post.id);
    postDocProfile.get().then((doc) {
      //int likes = doc.data()['likes'] ;
      //int likes = doc.data()['likes'] ?? '';
      int likes = (doc.data() as dynamic)['likes'];
      postDocProfile.update({'likes': likes + 1});
    });

    DocumentReference postDocFeed =
    feedRef.doc(currentUserId).collection('userFeed').doc(post.id);
    postDocFeed.get().then((doc) {
      if (doc.exists) {
        int likes = (doc.data() as dynamic)['likes'];
        postDocFeed.update({'likes': likes + 1});
      }
    });

    likesRef.doc(post.id).collection('postLikes').doc(currentUserId).set({});


  }


  static void unlikePost(String currentUserId, Post post) {
    DocumentReference postDocProfile = postsRef.doc(post.authorId).collection('userPosts').doc(post.id);
    postDocProfile.get().then((doc) {
      int likes = (doc.data() as dynamic)['likes'];
      postDocProfile.update({'likes': likes - 1});
    });

    DocumentReference postDocFeed = feedRef.doc(currentUserId).collection('userFeed').doc(post.id);
    postDocFeed.get().then((doc) {
      if (doc.exists) {
        int likes = (doc.data() as dynamic)['likes'];
        postDocFeed.update({'likes': likes - 1});
      }
    });

    likesRef
        .doc(post.id)
        .collection('postLikes')
        .doc(currentUserId)
        .get()
        .then((doc) => doc.reference.delete());
  }

  static Future<bool> isLikePost(String currentUserId, Post post) async {
    DocumentSnapshot userDoc = await likesRef
        .doc(post.id)
        .collection('postLikes')
        .doc(currentUserId)
        .get();

    return userDoc.exists;
  }

}
