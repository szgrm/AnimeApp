// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CharacterSmall: AnilistAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CharacterSmall on Character { __typename id name { __typename full } image { __typename medium } }"#
  }

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
      .field("medium", String?.self),
    ] }

    /// The character's image of media at medium size
    public var medium: String? { __data["medium"] }
  }
}
