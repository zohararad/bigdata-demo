var f_users = db.users.find({
  firstname: /^f/i
}, {firstname: 1});

f_users.forEach(printjson);