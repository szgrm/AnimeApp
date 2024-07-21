// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAnimeDetailQuery: GraphQLQuery {
  public static let operationName: String = "GetAnimeDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAnimeDetail($id: Int) { Media(id: $id) { __typename id coverImage { __typename large } title { __typename english native } genres description episodes characters(sort: FAVOURITES_DESC, perPage: 25) { __typename nodes { __typename id name { __typename full } image { __typename medium } } } } }"#
    ))

  public var id: GraphQLNullable<Int>

  public init(id: GraphQLNullable<Int>) {
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
        .field("id", Int.self),
        .field("coverImage", CoverImage?.self),
        .field("title", Title?.self),
        .field("genres", [String?]?.self),
        .field("description", String?.self),
        .field("episodes", Int?.self),
        .field("characters", Characters?.self, arguments: [
          "sort": "FAVOURITES_DESC",
          "perPage": 25
        ]),
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
      /// The amount of episodes the anime has when complete
      public var episodes: Int? { __data["episodes"] }
      /// The characters in the media
      public var characters: Characters? { __data["characters"] }

      /// Media.CoverImage
      ///
      /// Parent Type: `MediaCoverImage`
      public struct CoverImage: AnilistAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.MediaCoverImage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("large", String?.self),
        ] }

        /// The cover image url of the media at a large size
        public var large: String? { __data["large"] }
      }

      /// Media.Title
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

      /// Media.Characters
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

        /// Media.Characters.Node
        ///
        /// Parent Type: `Character`
        public struct Node: AnilistAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", Int.self),
            .field("name", Name?.self),
            .field("image", Image?.self),
          ] }

          /// The id of the character
          public var id: Int { __data["id"] }
          /// The names of the character
          public var name: Name? { __data["name"] }
          /// Character images
          public var image: Image? { __data["image"] }

          /// Media.Characters.Node.Name
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

          /// Media.Characters.Node.Image
          ///
          /// Parent Type: `CharacterImage`
          public struct Image: AnilistAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.CharacterImage }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("medium", String?.self),
            ] }

            /// The character's image of media at medium size
            public var medium: String? { __data["medium"] }
          }
        }
      }
    }
  }
}
