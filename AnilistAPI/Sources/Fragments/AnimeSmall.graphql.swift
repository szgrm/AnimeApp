// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct AnimeSmall: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment AnimeSmall on Media { __typename id coverImage { __typename large color } title { __typename english romaji } genres description format seasonYear }"#
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
    .field("description", String?.self),
    .field("format", GraphQLEnum<AnilistAPI.MediaFormat>?.self),
    .field("seasonYear", Int?.self),
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

  /// CoverImage
  ///
  /// Parent Type: `MediaCoverImage`
  public struct CoverImage: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("large", String?.self),
      .field("color", String?.self),
    ] }

    /// The cover image url of the media at a large size
    public var large: String? { __data["large"] }
    /// Average #hex color of cover image
    public var color: String? { __data["color"] }
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
      .field("romaji", String?.self),
    ] }

    /// The official english title
    public var english: String? { __data["english"] }
    /// The romanization of the native language title
    public var romaji: String? { __data["romaji"] }
  }
}
