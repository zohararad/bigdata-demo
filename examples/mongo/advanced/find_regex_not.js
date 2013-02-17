var non_gees = db.users.find({
  lastname: { $not: /^f/i}
}, {firstname: 1, lastname: 1}).limit(2);

non_gees.forEach(printjson);