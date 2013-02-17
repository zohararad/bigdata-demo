// Iterate over users
db.users.find({}).sort({firstname: 1}).limit(2).forEach(printjson);