//
//  UserProfileWidget.swift
//  DiabloWidget
//
//  Created by JerryLiu on 2020/8/5.
//

import SwiftUI
import WidgetKit

struct UserProfileProvider: TimelineProvider {
    func placeholder(in context: Context) -> UserEntry {
        return UserEntry(date: Date())
    }
    
    public typealias Entry = UserEntry
    
    func getSnapshot(in context: Context, completion: @escaping (UserEntry) -> Void) {
        let entry = UserEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<UserEntry>) -> Void) {
        var entries: [UserEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = UserEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct UserEntry: TimelineEntry {
    public let date: Date
}

struct UserProfilePlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct UserProfileWidgetEntryView : View {
    var entry: UserProfileProvider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct UserProfileWidget: Widget {
    private let kind: String = "UserProfileWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: UserProfileProvider()) { entry in
            UserProfileWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("凯恩之角")
        .description("用户信息Widget")
    }
}

struct UserProfileWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("第二个Widget")
        }
    }
}

@main
struct WidgetDemoBundle : WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        UserProfileWidget()
        DiabloNews()
    }
}
