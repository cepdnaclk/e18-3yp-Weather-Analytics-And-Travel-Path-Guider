function getDateTime() {
    var datetime = new Date();
    return datetime.toISOString();
}

module.exports = { getDateTime }