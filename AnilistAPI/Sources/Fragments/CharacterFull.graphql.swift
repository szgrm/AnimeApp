// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterFull: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterFull on Character { __typename id name { __typename full alternative } image { __typename large } age gender description media(sort: POPULARITY_DESC) { __typename nodes { __typename ...AnimeSmall } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("name", Name?.self),
    .field("image", Image?.self),
    .field("age", String?.self),
    .field("gender", String?.self),
    .field("description", String?.self),
    .field("media", Media?.self, arguments: ["sort": "POPULARITY_DESC"]),
  ] }

  /// The id of the character
  public var id: Int { __data["id"] }
  /// The names of the character
  public var name: Name? { __data["name"] }
  /// Character images
  public var image: Image? { __data["image"] }
  /// The character's age. Note this is a string, not an int, it may contain further text and additional ages.
  public var age: String? { __data["age"] }
  /// The character's gender. Usually Male, Female, or Non-binary but can be any string.
  public var gender: String? { __data["gender"] }
  /// A general description of the character
  public var description: String? { __data["description"] }
  /// Media that includes the character
  public var media: Media? { __data["media"] }

  /// Name
  ///
  /// Parent Type: `CharacterName`
  public struct Name: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterName }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("full", String?.self),
      .field("alternative", [String?]?.self),
    ] }

    /// The character's first and last name
    public var full: String? { __data["full"] }
    /// Other names the character might be referred to as
    public var alternative: [String?]? { __data["alternative"] }
  }

  /// Image
  ///
  /// Parent Type: `CharacterImage`
  public struct Image: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("large", String?.self),
    ] }

    /// The character's image of media at its largest size
    public var large: String? { __data["large"] }
  }

  /// Media
  ///
  /// Parent Type: `MediaConnection`
  public struct Media: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaConnection }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("nodes", [Node?]?.self),
    ] }

    public var nodes: [Node?]? { __data["nodes"] }

    /// Media.Node
    ///
    /// Parent Type: `Media`
    public struct Node: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(AnimeSmall.self),
      ] }

      /// The id of the media
      public var id: Int { __data["id"] }
      /// The cover images of the media
      public var coverImage: CoverImage? { __data["coverImage"] }
      /// The official titles of the media in various languages
      public var title: Title? { __data["title"] }
      /// The genres of the media
      public var genres: [String?]? { __data["genres"] }
      /// Short description of the media's story and characters
      public var description: String? { __data["description"] }
      /// The format the media was released in
      public var format: GraphQLEnum<AnilistAPI.MediaFormat>? { __data["format"] }
      /// The season year the media was initially released in
      public var seasonYear: Int? { __data["seasonYear"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var animeSmall: AnimeSmall { _toFragment() }
      }

      public typealias CoverImage = AnimeSmall.CoverImage

      public typealias Title = AnimeSmall.Title
    }
  }
}
