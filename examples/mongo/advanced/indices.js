db.users.ensureIndex( { friends: 1 }, { unique: false, background: true } );
db.users.ensureIndex( { skills: 1 }, { unique: false, background: true } );
db.users.ensureIndex( { 'employments.position': 1 }, { unique: false, background: true } );

printjson(db.users.getIndexes());