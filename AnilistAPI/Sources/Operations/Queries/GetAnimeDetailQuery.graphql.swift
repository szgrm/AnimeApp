// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAnimeDetailQuery: GraphQLQuery {
  public static let operationName: String = "GetAnimeDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAnimeDetail($id: Int!) { Media(id: $id) { __typename ...AnimeFull } }"#,
      fragments: [AnimeFull.self, CharacterSmall.self]
    ))

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Media", Media?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Media query
    public var media: Media? { __data["Media"] }

    /// Media
    ///
    /// Parent Type: `Media`
    public struct Media: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Media }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(AnimeFull.self),
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

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var animeFull: AnimeFull { _toFragment() }
      }

      public typealias CoverImage = AnimeFull.CoverImage

      public typealias Title = AnimeFull.Title

      public typealias Characters = AnimeFull.Characters

      public typealias Trailer = AnimeFull.Trailer
    }
  }
}
