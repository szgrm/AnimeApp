// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCharacterDetailQuery: GraphQLQuery {
  public static let operationName: String = "GetCharacterDetail"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCharacterDetail($id: Int!) { Character(id: $id) { __typename ...CharacterFull } }"#,
      fragments: [AnimeSmall.self, CharacterFull.self]
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
      .field("Character", Character?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Character query
    public var character: Character? { __data["Character"] }

    /// Character
    ///
    /// Parent Type: `Character`
    public struct Character: AnilistAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { AnilistAPI.Objects.Character }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(CharacterFull.self),
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
      /// The character's birth date
      public var dateOfBirth: DateOfBirth? { __data["dateOfBirth"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var characterFull: CharacterFull { _toFragment() }
      }

      public typealias Name = CharacterFull.Name

      public typealias Image = CharacterFull.Image

      public typealias Media = CharacterFull.Media

      public typealias DateOfBirth = CharacterFull.DateOfBirth
    }
  }
}
