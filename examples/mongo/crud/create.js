/** === Creating New Records ===
 db.collectionName.insert(RECORD);
 */

// Create new users
var now = new Date();
db.users.insert({
  firstname: 'Zohar',
  lastname: 'Arad',
  email: 'zohar@arad.com',
  skills: ['Javascript', 'CSS', 'HTML', 'MongoDB', 'Ruby'],
  created_at: now,
  updated_at: now
});

db.users.insert({
  firstname: 'Yossi',
  lastname: 'Cohen',
  email: 'yossi@cohen.com',
  skills: ['Hadoop', 'Apache Hive', 'Pig Latin', 'Storm'],
  created_at: now,
  updated_at: now,
  friends: []
});