//
//  EventRegistryAPI.swift
//  tree
//
//  Created by ParkSungJoon on 24/01/2019.
//  Copyright © 2019 gardener. All rights reserved.
//

import Foundation
import Booster

private enum DefaultParameter {
    case articleBodyLen
    case includeArticleImage
    case includeArticleCategories
    case articlesCount
    case resultType
    case action
    case eventsCount
    case eventsPage
    case includeEventConcepts
    case language
    case categoryUri
}

extension DefaultParameter {
    var value: Any {
        switch self {
        case .articleBodyLen: return -1
        case .includeArticleImage: return true
        case .includeArticleCategories: return true
        case .articlesCount: return 20
        case .resultType: return "articles"
        case .action: return "getArticles"
        case .eventsCount: return 50
        case .eventsPage: return 1
        case .includeEventConcepts: return false
        case .language: return "eng"
        case .categoryUri: return "dmoz"
        }
    }
}

public enum EventRegistryAPI {
    
    case fetchDefaultArticles(
        keyword: String,
        keywordLoc: String,
        lang: String,
        articlesSortBy: String,
        articlesPage: Int
    )
    case fetchArticles(
        keyword: String,
        keywordLoc: String,
        lang: String,
        articlesSortBy: String,
        categoryUri: String,
        articlesPage: Int
    )
    case fetchRecentEvents
}

extension EventRegistryAPI: BoosterService {
    
    public var baseURL: URL {
        guard let url = URL(string: BaseURL.eventRegistryAPIBaseURL) else { fatalError("Invalid URL") }
        return url
    }
    
    public var path: String? {
        switch self {
        case .fetchDefaultArticles:
            return "/api/v1/article"
        case .fetchArticles:
            return "/api/v1/article"
        case .fetchRecentEvents:
            return "/api/v1/topRecentEvents"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchDefaultArticles:
            return .get
        case .fetchArticles:
            return .get
        case .fetchRecentEvents:
            return .get
        }
    }
    
    public var parameters: Parameters {
        switch self {
        case .fetchDefaultArticles(
            let keyword,
            let keywordLoc,
            let lang,
            let articlesSortBy,
            let articlesPage
            ):
            return [
                ParamterKey.keyword.stringValue: keyword,
                ParamterKey.keywordLoc.stringValue: keywordLoc,
                ParamterKey.lang.stringValue: lang,
                ParamterKey.articlesSortBy.stringValue: articlesSortBy,
                ParamterKey.articlesPage.stringValue: articlesPage,
                ParamterKey.action.stringValue: DefaultParameter.action.value,
                ParamterKey.resultType.stringValue: DefaultParameter.resultType.value,
                ParamterKey.articlesCount.stringValue: DefaultParameter.articlesCount.value,
                ParamterKey.includeArticleImage.stringValue: DefaultParameter.includeArticleImage.value,
                ParamterKey.includeArticleCategories.stringValue: DefaultParameter.includeArticleCategories.value,
                ParamterKey.articleBodyLen.stringValue: DefaultParameter.articleBodyLen.value,
                ParamterKey.apiKey.stringValue: APIConstant.eventRegistryKey
            ]
        case .fetchArticles(
            let keyword,
            let keywordLoc,
            let lang,
            let articlesSortBy,
            let category,
            let articlesPage
            ):
            return [
                ParamterKey.keyword.stringValue: keyword,
                ParamterKey.keywordLoc.stringValue: keywordLoc,
                ParamterKey.lang.stringValue: lang,
                ParamterKey.articlesSortBy.stringValue: articlesSortBy,
                ParamterKey.articlesPage.stringValue: articlesPage,
                ParamterKey.categoryUri.stringValue: category,
                ParamterKey.action.stringValue: DefaultParameter.action.value,
                ParamterKey.resultType.stringValue: DefaultParameter.resultType.value,
                ParamterKey.articlesCount.stringValue: DefaultParameter.articlesCount.value,
                ParamterKey.includeArticleImage.stringValue: DefaultParameter.includeArticleImage.value,
                ParamterKey.includeArticleCategories.stringValue: DefaultParameter.includeArticleCategories.value,
                ParamterKey.articleBodyLen.stringValue: DefaultParameter.articleBodyLen.value,
                ParamterKey.apiKey.stringValue: APIConstant.eventRegistryKey
            ]
        case .fetchRecentEvents:
            return [
                "eventPages": DefaultParameter.eventsPage.value,
                "includeEventConcepts": DefaultParameter.includeEventConcepts.value,
                "eventsCount": DefaultParameter.eventsCount.value
            ]
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .fetchDefaultArticles:
            return .requestWith(
                url: parameters, 
                body: nil, 
                encoding: .query
            )
        case .fetchArticles:
            return .requestWith(
                url: parameters,
                body: nil,
                encoding: .query
            )
        case .fetchRecentEvents:
            return .requestWith(
                url: parameters,
                body: nil,
                encoding: .query
            )
        }
    }
    
    public var header: HTTPHeader? {
        return nil
    }
}
