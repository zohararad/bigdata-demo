var users = db.users.find({
  "employments.position": "Engineer"
}, {firstname:1, lastname:1, email: 1, "employments.position": 1})

users.forEach(printjson);