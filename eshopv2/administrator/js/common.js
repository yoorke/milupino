function ChangeDateFormat(date) {
    var formattedDate = date.toString().substring(3, 5) + '.' + date.toString().substring(0, 2) + '.' + date.toString().substring(6);
    return formattedDate.toString();
}