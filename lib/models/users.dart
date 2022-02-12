class MyUser {
  final String name;
  final String department;
  final String email;
  final String post;
  // ignore: non_constant_identifier_names
  final bool? is_admin;
  final String id;

  MyUser(
      {required this.name,
      required this.department,
      required this.email,
      required this.post,
      required this.id,
      required this.is_admin});
}