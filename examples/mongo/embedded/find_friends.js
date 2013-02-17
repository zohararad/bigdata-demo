var user = db.users.findOne({});

var friends = db.users.find({
  friends: {
    $in: [user._id]
  }
});

printjson("User ID is: " + user._id);

friends.forEach(function(friend){
  printjson("Friend name:" + friend.firstname + ' ' + friend.lastname);
  printjson("Friend friends are : " + friend.friends );
});