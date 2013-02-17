/** === Updating Records ===
 * db.collectionName.update(CONDITIONS, UPDATE_DATA);
 */

var zohar = db.users.findOne({email: 'zohar@arad.com'});
var yossi = db.users.findOne({email: 'yossi@cohen.com'});

printjson(zohar);
printjson(yossi);
print("===========================================================================")

// Update users
db.users.update({
  _id: zohar._id
}, {
  $set: { // REGULAR VALUE SET
    friends: [yossi._id]
  }
});

db.users.update({
  _id: yossi._id
}, {
  $push: { // PUSH VALUE TO ARRAY - RUN A FEW TIMES TO SEE DIFFERENCE
    friends: zohar._id
  }
});

var zohar = db.users.findOne({email: 'zohar@arad.com'}, {email: 1, friends: 1});
var yossi = db.users.findOne({email: 'yossi@cohen.com'}, {email: 1, friends: 1});

printjson(zohar);
printjson(yossi);