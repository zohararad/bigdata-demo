var very_skilled = db.users.find({
  $where: "this.skills.length >= 2"
}, {email:1, skills: 1}).limit(2);

very_skilled.forEach(printjson);