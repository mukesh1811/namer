class FavsDataModel
{
  final String favWord;

  const FavsDataModel({required this.favWord});

  Map<String, dynamic> toMap()
  {
    return {
      'favWord' : favWord,
    };
  }

}