// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchCharacterQuery: GraphQLQuery {
  public static let operationName: String = "SearchCharacter"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SearchCharacter($search: String!) { Page(perPage: 20) { __typename characters(search: $search, sort: FAVOURITES_DESC) { __typename ...CharacterSmall } } }"#,
      fragments: [CharacterSmall.self]
    ))

  public var search: String

  public init(search: String) {
    self.search = search
  }

  public var __variables: Variables? { ["search": search] }

  public struct Data: AnilistAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("Page", Page?.self, arguments: ["perPage": 20]),
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
        .field("characters", [Character?]?.self, arguments: [
          "search": .variable("search"),
          "sort": "FAVOURITES_DESC"
        ]),
      ] }

      public var characters: [Character?]? { __data["characters"] }

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
