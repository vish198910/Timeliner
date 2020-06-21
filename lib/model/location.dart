// Update the Dog class to include a `toMap` method.
class MyLocation{
  final int id;
  final double latitude;
  final double longitude;

  MyLocation({this.id, this.latitude, this.longitude});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude    };
  }
}