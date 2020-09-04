//
//  DiabloNews.swift
//  DiabloNews
//
//  Created by JerryLiu on 2020/7/31.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    public typealias Entry = SimpleEntry

    typealias Intent = DiabloHeroIntent
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), configuration: DiabloHeroIntent(), size: context.displaySize, smallArticle: Article.placeHolderData,columnUrlString: "", mediumLogo: nil, mediumNightLogo: nil, mediumArticles: [Article.placeHolderData,Article.placeHolderData], largeCoverAritle: Article.placeHolderData, largeArticles: [Article.placeHolderData,Article.placeHolderData], relevance: TimelineEntryRelevance(score: 0.0))
    }
    
    func getSnapshot(for configuration: DiabloHeroIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let currentDate = Date()
        configuration.YourHero?.identifier
        let fetchArticleNums = fetchArticleCount(currentFamily: context.family)
                
        let topicId =  1
        
        DataManager.fetchFeedList(topicId: topicId, articleNum: fetchArticleNums, shouldLoadLogo: false, articleImageSize: CGSize(width: 0, height: 0)) { (dataModel, error) in
            let feedListModel: DataModel
            
            if error != nil {
                feedListModel = DataModel.placeHolderData
            } else {
                feedListModel = dataModel ?? DataModel.placeHolderData
            }
            
            let entryDisplaySize = context.displaySize
            
            var smallArticle : Article!
            
            var logoData : Data!
            
            var logoNightData : Data!
            
            var mediumArticles : [Article]!
            
            var largeCoverArticle : Article!
            
            var largeArticlesList : [Article]!
            
            var columnUrlString : String = ""
            
            let nextScore : Float = feedListModel.score ?? 0.0
            
            switch context.family {
            case .systemSmall:
                smallArticle = Article.demoData2
            case .systemMedium:
                logoData = nil
                logoNightData = nil
                mediumArticles = [Article.demoData1]
                
            case .systemLarge:
                largeCoverArticle = Article.demoData2
                let totalArticles = feedListModel.articles
                largeArticlesList = Array(totalArticles?[0...2] ?? [Article.placeHolderData,Article.placeHolderData])
            default:
                largeCoverArticle = feedListModel.articles?.first ?? Article.placeHolderData
                let totalArticles = feedListModel.articles
                largeArticlesList = Array(totalArticles?[0...2] ?? [Article.placeHolderData,Article.placeHolderData])
            }
            
            
            let snapShotEntry = SimpleEntry(date: currentDate, configuration: configuration, size: entryDisplaySize, smallArticle: smallArticle, columnUrlString:columnUrlString, mediumLogo: logoData, mediumNightLogo: logoNightData, mediumArticles: mediumArticles, largeCoverAritle: largeCoverArticle, largeArticles: largeArticlesList, relevance: TimelineEntryRelevance(score: nextScore))
            completion(snapShotEntry)
        }
    }
    
    func getTimeline(for configuration: DiabloHeroIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        
        let fetchArticleNums = fetchArticleCount(currentFamily: context.family)
                
        let topicId =  1
        
        DataManager.fetchFeedList(topicId: topicId, articleNum: fetchArticleNums, shouldLoadLogo: false, articleImageSize: CGSize(width: 0, height: 0)) { (dataModel, error) in
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
            
            let feedListModel: DataModel
            
            if error != nil {
                feedListModel = DataModel.placeHolderData
            } else {
                feedListModel = dataModel ?? DataModel.placeHolderData
            }
            
            let entryDisplaySize = context.displaySize
            
            var smallArticle : Article!
            
            var logoData : Data!
            
            var logoNightData : Data!
            
            var mediumArticles : [Article]!
            
            var largeCoverArticle : Article!
            
            var largeArticlesList : [Article]!
            
            var columnUrlString : String = ""
            
            let nextScore : Float = feedListModel.score ?? 0.0
            
            switch context.family {
            case .systemSmall:
                smallArticle = Article.demoData2
            case .systemMedium:
                logoData = nil
                logoNightData = nil
                mediumArticles = [Article.demoData1]
                
            case .systemLarge:
                largeCoverArticle = Article.demoData3
                let totalArticles = feedListModel.articles
                largeArticlesList = Array(totalArticles?[0...2] ?? [Article.placeHolderData,Article.placeHolderData])
            default:
                largeCoverArticle = feedListModel.articles?.first ?? Article.placeHolderData
                let totalArticles = feedListModel.articles
                largeArticlesList = Array(totalArticles?[0...2] ?? [Article.placeHolderData,Article.placeHolderData])
            }
            
            
            let entry = SimpleEntry(date: currentDate, configuration: configuration, size: entryDisplaySize, smallArticle: smallArticle, columnUrlString:columnUrlString, mediumLogo: logoData, mediumNightLogo: logoNightData, mediumArticles: mediumArticles, largeCoverAritle: largeCoverArticle, largeArticles: largeArticlesList, relevance: TimelineEntryRelevance(score: nextScore))
            
            
            
            let timeLine = Timeline(entries: [entry], policy:.after(refreshDate))
            completion(timeLine)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: DiabloHeroIntent
    
    public let size: CGSize
    
    //Small
    public let smallArticle : Article?
    
    //Medium
    public let columnUrlString : String?
    public let mediumLogo : Data?
    public let mediumNightLogo : Data?
    public let mediumArticles : [Article]?
    
    //large
    public let largeCoverAritle : Article?
    public let largeArticles : [Article]?
    
    let relevance: TimelineEntryRelevance?
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct DiabloNewsEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetSmallView(article: entry.smallArticle!,currentSize: entry.size)
                .widgetURL(URL(string: entry.smallArticle?.clientUrl ?? ""))
        case .systemMedium:
            MediumWidgetView(article: Article.demoData1, currentSize: entry.size)
        case .systemLarge:
            WidgetLargeView(topArticle: entry.largeCoverAritle!, articleList: entry.largeArticles!, currentSize: entry.size)
        default:
            WidgetSmallView(article: entry.smallArticle!,currentSize: entry.size)
                .widgetURL(URL(string: entry.smallArticle?.clientUrl ?? ""))
        }
    }
}


struct DiabloNews: Widget {
    private let kind: String = "DiabloNews"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: DiabloHeroIntent.self, provider: Provider()) { entry in
            DiabloNewsEntryView(entry: entry)
        }
        .configurationDisplayName("Diablo3")
        .description("拜命三归，暗黑再临")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct DiabloNews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetSmallView(article: Article.demoData2, currentSize: CGSize(width: 141, height: 141))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .redacted(reason: .placeholder)
            MediumWidgetView(article: Article.demoData1, currentSize: CGSize(width: 322, height: 148))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .redacted(reason: .placeholder)
            WidgetLargeView(topArticle: Article.demoData, articleList: [Article.demoData, Article.demoData1, Article.demoData2], currentSize: CGSize(width: 322, height: 324))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .redacted(reason: .placeholder)
        }
    }
}


/**
 小尺寸SmallSizeView
 */
struct WidgetSmallView: View {
    let article : Article
    let currentSize : CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            if (article.imageData != nil) {
                //如果图片存在
                //最底下放置一张底图
                let colors = UIImage(data: article.imageData ?? Data())?.getColors() ?? UIImageColors(background: UIColor(.white), primary: UIColor(.white), secondary: UIColor(.white), detail: UIColor(.white))
                
                let titleColorName = colors.background.fetchWidgetArticleTitleColorName() ?? "articleTitleForDarkBG"
                
                Color.init(colors.background)
                
                VStack(alignment: .leading, spacing:0) {
                    ZStack(alignment: .top) {
                        Image(uiImage: UIImage(data: article.imageData!)!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: currentSize.height * 0.56)
                            .clipped()
                        
                        HStack {
                            Spacer()
                            Image("logo")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .padding(.top, 11)
                        .padding(.trailing)
                    }
                    
                    VStack(alignment: .leading, spacing:4) {
                        Text(article.title ?? "")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .foregroundColor(Color.init(titleColorName))
                            .lineSpacing(4)
                            .font(.footnote)
                        
                        HStack(spacing:8) {
                            if ((article.tagList?.text) != nil) {
                                Text("\(article.tagList?.text ?? "")")
                            }

                            if !article.transCommentToString().isEmpty {
                                Text("\(article.transCommentToString())")
                            }
                        }
                        .foregroundColor(Color.init(titleColorName))
                        .font(.caption2)
                    }
                    .padding(.top,6)
                    .padding([.leading, .trailing, .bottom], 11)
                }
            } else {
                Color("WidgetBackground")
                
                VStack(alignment: .leading, spacing:0) {
                    ZStack(alignment: .top) {
                        Color("blackEE")
                        
                        HStack {
                            Spacer()
                            Image("logo")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .padding(.top, 11)
                        .padding(.trailing)
                    }
                    
                    VStack(alignment: .leading, spacing:4) {
                        Text(article.title ?? "")
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(2)
                            .foregroundColor(Color("black33"))
                            .lineSpacing(4)
                            .font(.footnote)
                        
                        HStack(spacing:8) {
                            if ((article.tagList?.text) != nil) {
                                Text("\(article.tagList?.text ?? "")")
                            }

                            if !article.transCommentToString().isEmpty {
                                Text("\(article.transCommentToString())")
                            }
                        }
                        .foregroundColor(Color("black33"))
                        .font(.caption2)
                    }
                    .padding(.top,6)
                    .padding([.leading, .trailing, .bottom], 11)
                }
            }
        }
    }
}

/**
大尺寸
*/
struct WidgetLargeView: View {
    let topArticle : Article
    let articleList : [Article]
    let currentSize : CGSize
    
    var body: some View {
        ZStack() {
            Color("articleTitleForLightBG")
            
            VStack(alignment: .leading, spacing:0) {
                ForEach(articleList, id: \.self) { article in
                    Link(destination: URL(string: article.clientUrl ?? "newsapp://")!) {
                        MediumWidgetView(article: article, currentSize: CGSize(width: currentSize.width, height: currentSize.height/3))
                    }
                }
            }
        }
        .padding(.vertical)
    }
}


struct MediumWidgetView: View {
    var article:Article
    let currentSize : CGSize
    
    var body: some View {
        
        //如果图片为空
        if article.imageData != nil {
            let articleImage = UIImage(data: article.imageData!)
            let colors = articleImage!.getColors(quality: .high)
            let titleColorName = colors!.background.fetchWidgetArticleTitleColorName() ?? "black33"
            
            ZStack(alignment: .leading) {
                HStack(spacing: 0) {
                    ZStack() {
                        Image(uiImage: articleImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: currentSize.width * 0.617, height: currentSize.height)
                            .clipped()
                    }
                    Spacer()
                }
                
                ZStack() {
                    
                    HStack(spacing: 0) {
                        Spacer()
                        
                        LinearGradient(gradient: Gradient(colors: [.clear,Color.init(colors!.background)]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: currentSize.width * 0.62 / 2)
                        
                        Color(colors!.background)
                            .frame(width: currentSize.width * 0.38)
                    }
                    .frame(height: currentSize.height)
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(article.title ?? "")
                                .font(.headline)
                                .foregroundColor(Color(titleColorName))
                                .lineLimit(3)
                                .lineSpacing(4)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            HStack(alignment: .center) {
                                if ((article.tagList?.text) != nil) {
                                    Text(article.tagList?.text ?? "")
                                }
                                
                                if !article.transCommentToString().isEmpty {
                                    Text("\(article.transCommentToString())")
                                }
                            }
                            .foregroundColor(Color(titleColorName))
                            .font(.caption2)
                        }
                        .padding([.top, .trailing, .bottom])
                        .frame(width: currentSize.width * 0.5)
                    }
                    .frame(height: currentSize.height)
                }
            }

        } else {
            ZStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    Color("blackDD")
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(article.title ?? "")
                        .font(.headline)
                        .foregroundColor(Color("articleTitleForDarkBG"))
                        .lineLimit(3)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(alignment: .center) {
                        if ((article.tagList?.text) != nil) {
                            Text(article.tagList?.text ?? "")
                        }
                        
                        if !article.transCommentToString().isEmpty {
                            Text("\(article.transCommentToString())")
                        }
                    }
                    .foregroundColor(Color("articleTitleForDarkBG"))
                    .font(.caption2)
                }
                .padding([.top, .leading, .bottom])
            }
        }
    }
}
