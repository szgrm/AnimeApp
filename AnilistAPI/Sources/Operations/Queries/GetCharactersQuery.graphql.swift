// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCharactersQuery: GraphQLQuery {
  public static let operationName: String = "GetCharacters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCharacters($page: Int!) { Page(page: $page, perPage: 20) { __typename pageInfo { __typename hasNextPage } characters(sort: FAVOURITES_DESC) { __typename ...CharacterSmall } } }"#,
      fragments: [CharacterSmall.self]
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
        .field("characters", [Character?]?.self, arguments: ["sort": "FAVOURITES_DESC"]),
      ] }

      /// The pagination information
      public var pageInfo: PageInfo? { __data["pageInfo"] }
      public var characters: [Character?]? { __data["characters"] }

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

      /// Page.Character
      ///
      /// Parent Type: `Character`
      public struct Character: AnilistAPI.SelectionSet {
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
  }
}
