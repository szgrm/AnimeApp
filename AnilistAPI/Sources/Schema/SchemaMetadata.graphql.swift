// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == AnilistAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == AnilistAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == AnilistAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == AnilistAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Query": return AnilistAPI.Objects.Query
    case "Page": return AnilistAPI.Objects.Page
    case "PageInfo": return AnilistAPI.Objects.PageInfo
    case "Media": return AnilistAPI.Objects.Media
    case "MediaCoverImage": return AnilistAPI.Objects.MediaCoverImage
    case "MediaTitle": return AnilistAPI.Objects.MediaTitle
    case "CharacterConnection": return AnilistAPI.Objects.CharacterConnection
    case "Character": return AnilistAPI.Objects.Character
    case "CharacterName": return AnilistAPI.Objects.CharacterName
    case "CharacterImage": return AnilistAPI.Objects.CharacterImage
    case "MediaTrailer": return AnilistAPI.Objects.MediaTrailer
    case "MediaConnection": return AnilistAPI.Objects.MediaConnection
    case "FuzzyDate": return AnilistAPI.Objects.FuzzyDate
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
