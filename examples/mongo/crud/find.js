/** === Finding Records ===
 * db.collectionName.find(CONDITIONS, [FIELDS]) -> returns cursor
 * db.collectionName.findOne(CONDITIONS) -> returns record
 */

// Find created users
var zohar = db.users.findOne({email: 'zohar@arad.com'});
var yossi = db.users.findOne({email: 'yossi@cohen.com'});

printjson(zohar);
printjson(yossi);