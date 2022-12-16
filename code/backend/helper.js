function getDateTime() {
    let nz_date_string = new Date().toLocaleString("en-US", { timeZone: "Asia/Colombo" });
    return nz_date_string;
}

module.exports = {
    getDateTime
}