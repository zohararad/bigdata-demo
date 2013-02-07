db.users.remove({});

var now = new Date();
db.users.save({
  firstname: 'Zohar',
  lastname: 'Arad',
  email: 'zohar@arad.com',
  skills: ['Javascript', 'CSS', 'HTML', 'MongoDB', 'Ruby'],
  created_at: now,
  updated_at: now
});

db.users.save({
  firstname: 'Yossi',
  lastname: 'Cohen',
  email: 'yossi@cohen.com',
  skills: ['Hadoop', 'Apache Hive', 'Pig Latin', 'Storm'],
  created_at: now,
  updated_at: now,
  friends: []
});

var zohar = db.users.findOne({email: 'zohar@arad.com'});
var yossi = db.users.findOne({email: 'yossi@cohen.com'});

printjson(zohar);
printjson(yossi);

db.users.update({
  _id: zohar._id
}, {
  $set: {
    friends: [yossi._id]
  }
});

db.users.update({
  _id: yossi._id
}, {
  $push: {
    friends: zohar._id
  }
});

db.users.find({}).sort({firstname: 1}).forEach(printjson);