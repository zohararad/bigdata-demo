var skilled = db.users.find({
  skills: { $size: 2 }
}, {email:1, skills: 1}).limit(2);

skilled.forEach(printjson);