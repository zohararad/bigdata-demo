function map() {
  var user = this;
  this.skills.forEach(function(skill) {
    emit(skill, {count : 1, users: [user.email]});
  });
}

function reduce(key, values) {
  var count = 0, users = [];
  values.forEach(function(value) {
    count += value.count;
    users = users.concat(value.users);
  });
  return {count: count, users: users};
}

// first m/r
/*
db.users.mapReduce(map, reduce, 'user_skills');

db.user_skills.find().forEach(printjson);

// ====================== ADD MORE USERS

// incremental m/r
db.users.mapReduce(map, reduce, {
  query: { created_at: { $gt: ISODate('2013-02-07 13:24:04') } },
  out: { reduce: "user_skills" }
});

db.user_skills.find().forEach(printjson);
 */
//db.user_skills.drop();