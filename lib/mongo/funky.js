var f_users = db.users.find({
  firstname: /^f/i
}, {firstname: 1});

//f_users.forEach(printjson);

var non_gees = db.users.find({
  lastname: { $not: /^f/i}
}, {firstname: 1, lastname: 1}).limit(2);

//non_gees.forEach(printjson);

var skilled = db.users.find({
  skills: { $size: 2 }
}, {email:1, skills: 1});

//skilled.forEach(printjson);

var very_skilled = db.users.find({
  $where: "this.skills.length >= 2"
}, {email:1, skills: 1});

//very_skilled.forEach(printjson);