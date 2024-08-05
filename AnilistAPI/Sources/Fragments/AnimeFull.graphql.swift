// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct AnimeFull: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment AnimeFull on Media { __typename id coverImage { __typename extraLarge } title { __typename english native } genres averageScore description episodes characters(sort: FAVOURITES_DESC) { __typename nodes { __typename ...CharacterSmall } } seasonYear status trailer { __typename site thumbnail id } format bannerImage }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("coverImage", CoverImage?.self),
    .field("title", Title?.self),
    .field("genres", [String?]?.self),
    .field("averageScore", Int?.self),
    .field("description", String?.self),
    .field("episodes", Int?.self),
    .field("characters", Characters?.self, arguments: ["sort": "FAVOURITES_DESC"]),
    .field("seasonYear", Int?.self),
    .field("status", GraphQLEnum<AnilistAPI.MediaStatus>?.self),
    .field("trailer", Trailer?.self),
    .field("format", GraphQLEnum<AnilistAPI.MediaFormat>?.self),
    .field("bannerImage", String?.self),
  ] }

  /// The id of the media
  public var id: Int { __data["id"] }
  /// The cover images of the media
  public var coverImage: CoverImage? { __data["coverImage"] }
  /// The official titles of the media in various languages
  public var title: Title? { __data["title"] }
  /// The genres of the media
  public var genres: [String?]? { __data["genres"] }
  /// A weighted average score of all the user's scores of the media
  public var averageScore: Int? { __data["averageScore"] }
  /// Short description of the media's story and characters
  public var description: String? { __data["description"] }
  /// The amount of episodes the anime has when complete
  public var episodes: Int? { __data["episodes"] }
  /// The characters in the media
  public var characters: Characters? { __data["characters"] }
  /// The season year the media was initially released in
  public var seasonYear: Int? { __data["seasonYear"] }
  /// The current releasing status of the media
  public var status: GraphQLEnum<AnilistAPI.MediaStatus>? { __data["status"] }
  /// Media trailer or advertisement
  public var trailer: Trailer? { __data["trailer"] }
  /// The format the media was released in
  public var format: GraphQLEnum<AnilistAPI.MediaFormat>? { __data["format"] }
  /// The banner image of the media
  public var bannerImage: String? { __data["bannerImage"] }

  /// CoverImage
  ///
  /// Parent Type: `MediaCoverImage`
  public struct CoverImage: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("extraLarge", String?.self),
    ] }

    /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
    public var extraLarge: String? { __data["extraLarge"] }
  }

  /// Title
  ///
  /// Parent Type: `MediaTitle`
  public struct Title: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("english", String?.self),
      .field("native", String?.self),
    ] }

    /// The official english title
    public var english: String? { __data["english"] }
    /// Official title in it's native language
    public var native: String? { __data["native"] }
  }

  /// Characters
  ///
  /// Parent Type: `CharacterConnection`
  public struct Characters: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterConnection }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("nodes", [Node?]?.self),
    ] }

    public var nodes: [Node?]? { __data["nodes"] }

    /// Characters.Node
    ///
    /// Parent Type: `Character`
    public struct Node: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(CharacterSmall.self),
      ] }

      /// The id of the character
      public var id: Int { __data["id"] }
      /// The names of the character
      public var name: Name? { __data["name"] }
      /// Character images
      public var image: Image? { __data["image"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var characterSmall: CharacterSmall { _toFragment() }
      }

      public typealias Name = CharacterSmall.Name

      public typealias Image = CharacterSmall.Image
    }
  }

  /// Trailer
  ///
  /// Parent Type: `MediaTrailer`
  public struct Trailer: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTrailer }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("site", String?.self),
      .field("thumbnail", String?.self),
      .field("id", String?.self),
    ] }

    /// The site the video is hosted by (Currently either youtube or dailymotion)
    public var site: String? { __data["site"] }
    /// The url for the thumbnail image of the video
    public var thumbnail: String? { __data["thumbnail"] }
    /// The trailer video id
    public var id: String? { __data["id"] }
  }
}
