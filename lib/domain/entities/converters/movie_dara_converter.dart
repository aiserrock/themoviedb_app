DateTime? convertDateFromString(String? rawDate) {
if (rawDate == null || rawDate.isEmpty) return null;
return DateTime.tryParse(rawDate);
}