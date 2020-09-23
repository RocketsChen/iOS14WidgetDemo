//
//  AdopterWidget.swift
//  AdopterWidget
//
//  Created by 陈甸甸 on 2020/9/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quotes: Quotes(author: "...", content: ["..."], place: "..." ,date: "..."))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let myQuotes = Quotes(author: "Steve Jobs", content: ["Your time is limited, so don't waste it living someone else's life.", "Your time is limited, so don't waste it living someone else's life.", "I want to put a ding in the universe.", "Quality is more important than quantity. One home run is better than two doubles."],place: "Stanford University", date: "2005")
        let entry = SimpleEntry(date: Date(), quotes: myQuotes)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
    
        let myQuotes1 = Quotes(author: "Steve Jobs", content: ["Stay hungry, stay foolish.", "Your time is limited, so don't waste it living someone else's life.", "I want to put a ding in the universe.", "Quality is more important than quantity. One home run is better than two doubles."],place: "Stanford University", date: "2005")
        let entry1 = SimpleEntry(date: Date(), quotes: myQuotes1)

        let myQuotes2 = Quotes(author: "Steve Jobs", content: ["I want to put a ding in the universe.", "Your time is limited, so don't waste it living someone else's life.", "Quality is more important than quantity. One home run is better than two doubles.","Innovation distinguishes between a leader and a follower."],place: "Stanford University", date: "2005")
        let entry2 = SimpleEntry(date: Date(), quotes: myQuotes2)
        
        let myQuotes3 = Quotes(author: "Steve Jobs", content: ["I want to put a ding in the universe.", "Your time is limited, so don't waste it living someone else's life.", "Quality is more important than quantity. One home run is better than two doubles.", "Being the richest man in the cemetery doesn't matter to me ... Going to bed at night saying we've done something wonderful... that's what matters to me."],place: "Stanford University", date: "2005")
        let entry3 = SimpleEntry(date: Date(), quotes: myQuotes3)
        
        
        entries.append(entry1)
        entries.append(entry2)
        entries.append(entry3)
        
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
}

// MARK: - 模型
struct SimpleEntry: TimelineEntry {
    let date: Date
    let quotes: Quotes
}


struct Quotes {
    let author: String
    let content: [String]
    let place: String
    let date: String
}


// MARK: - 组件页面
struct AdopterWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        
        if family == .systemSmall {  // 小
            VStack(alignment: .center, spacing: 20, content: {
                
                Text(entry.quotes.author)
                    .font(.system(size: 17))
                Text(entry.quotes.content[0])
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Text("\(entry.quotes.date) at \(entry.quotes.place) ")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(16)
            .widgetURL(URL(string: "https://www.baidu.com/small"))

        }
        
        if family == .systemMedium { // 中
            
            VStack(alignment: .center, spacing: 8, content: {
                
                Text(entry.quotes.author)
                    .font(.system(size: 18))
                    .frame(height: 30, alignment: .top)
                
                Link(destination: URL(string: "https://www.baidu.com/medium/1")!) {
                    Text(entry.quotes.content[0])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }

                Link(destination: URL(string: "https://www.baidu.com/medium/2")!) {
                    Text(entry.quotes.content[1])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                
                Text("\(entry.quotes.date) at \(entry.quotes.place) ")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .frame(height: 20, alignment: .bottom)
            })
            .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).padding(16)
        }
        
        if family == .systemLarge { // 大
        
            VStack(alignment: .center, spacing: 20, content: {
            
                Text(entry.quotes.author)
                    .font(.system(size: 20))
                    .frame(height: 30, alignment: .top)
                
                Link(destination: URL(string: "https://www.baidu.com/large/1")!) {
                    Text(entry.quotes.content[0])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                Link(destination: URL(string: "https://www.baidu.com/large/2")!) {
                    Text(entry.quotes.content[1])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                Link(destination: URL(string: "https://www.baidu.com/large/3")!) {
                    Text(entry.quotes.content[2])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                Link(destination: URL(string: "https://www.baidu.com/large/4")!) {
                    Text(entry.quotes.content[3])
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                
                Text("\(entry.quotes.date) at \(entry.quotes.place) ")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .frame(height: 20, alignment: .bottom)
            })
            .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(16)
        }
    }
}


@main
struct AdopterWidget: Widget {
    let kind: String = "AdopterWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AdopterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Adopter Widget")
        .description("Show some quotes.")
        
    }
}


// MARK: - 预览
struct AdopterWidget_Previews: PreviewProvider {
    static var previews: some View {
        
        let myQuotes = Quotes(author: "Steve Jobs", content: ["I want to put a ding in the universe.", "Your time is limited, so don't waste it living someone else's life.", "Quality is more important than quantity. One home run is better than two doubles.", "Being the richest man in the cemetery doesn't matter to me ... Going to bed at night saying we've done something wonderful... that's what matters to me."] ,place: "Stanford University", date: "2005")
        let entry = SimpleEntry(date: Date(), quotes: myQuotes)
        
        /// 小
        AdopterWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        /// 中
        AdopterWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        /// 大
        AdopterWidgetEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        
    }
}


