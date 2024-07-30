// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAnimesQuery: GraphQLQuery {
  public static let operationName: String = "GetAnimes"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAnimes($page: Int!) { Page(page: $page, perPage: 20) { __typename pageInfo { __typename hasNextPage } media(isAdult: false, sort: POPULARITY_DESC, format_in: [TV, MOVIE]) { __typename ...AnimeSmall } } }"#,
      fragments: [AnimeSmall.self]
    ))

  public var page: Int

  public init(page: Int) {
    self.page = page
  }

  public var __variables: Variables? { ["page": page] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Page", Page?.self, arguments: [
        "page": .variable("page"),
        "perPage": 20
      ]),
    ] }

    public var page: Page? { __data["Page"] }

    /// Page
    ///
    /// Parent Type: `Page`
    public struct Page: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Page }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pageInfo", PageInfo?.self),
        .field("media", [Medium?]?.self, arguments: [
          "isAdult": false,
          "sort": "POPULARITY_DESC",
          "format_in": ["TV", "MOVIE"]
        ]),
      ] }

      /// The pagination information
      public var pageInfo: PageInfo? { __data["pageInfo"] }
      public var media: [Medium?]? { __data["media"] }

      /// Page.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("hasNextPage", Bool?.self),
        ] }

        /// If there is another page
        public var hasNextPage: Bool? { __data["hasNextPage"] }
      }

      /// Page.Medium
      ///
      /// Parent Type: `Media`
      public struct Medium: AnilistAPI.SelectionSet {
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
}
