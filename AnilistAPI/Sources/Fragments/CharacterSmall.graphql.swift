// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterSmall: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterSmall on Character { __typename id name { __typename full } image { __typename large } media { __typename nodes { __typename title { __typename english romaji } } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Int.self),
    .field("name", Name?.self),
    .field("image", Image?.self),
    .field("media", Media?.self),
  ] }

  /// The id of the character
  public var id: Int { __data["id"] }
  /// The names of the character
  public var name: Name? { __data["name"] }
  /// Character images
  public var image: Image? { __data["image"] }
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
    ] }

    /// The character's first and last name
    public var full: String? { __data["full"] }
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
        .field("title", Title?.self),
      ] }

      /// The official titles of the media in various languages
      public var title: Title? { __data["title"] }

      /// Media.Node.Title
      ///
      /// Parent Type: `MediaTitle`
      public struct Title: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaTitle }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("english", String?.self),
          .field("romaji", String?.self),
        ] }

        /// The official english title
        public var english: String? { __data["english"] }
        /// The romanization of the native language title
        public var romaji: String? { __data["romaji"] }
      }
    }
  }
}
