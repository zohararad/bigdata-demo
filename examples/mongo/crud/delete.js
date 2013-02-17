/** === Deleting Records ===
 * db.collectionName.remove(CONDITIONS)
 */

// Cleanup before we start
db.users.remove({});
db.users.find({}).forEach(printjson);