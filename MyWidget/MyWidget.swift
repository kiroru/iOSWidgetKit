//
//  MyWidget.swift
//  MyWidget
//
//  Created by 高田 朋輝 on 2021/02/11.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> MyWidgetEntry {
        let item = DatabaseManager().items.first
        return MyWidgetEntry(date: Date(),
                             item: item ?? Item())
    }

    func getSnapshot(in context: Context, completion: @escaping (MyWidgetEntry) -> ()) {
        let item = DatabaseManager().items.first
        let entry = MyWidgetEntry(date: Date(),
                                  item: item ?? Item())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MyWidgetEntry>) -> ()) {
        let item = DatabaseManager().items.first
        let entry = MyWidgetEntry(date: Date(),
                                  item: item ?? Item())
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct MyWidgetEntry: TimelineEntry {
    let date: Date
    let item: Item
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.yellow
            VStack(alignment: .leading, spacing: 6) {
                Text(entry.item.title)
                Text(entry.item.explanation)
            }
            .padding()
        }
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: MyWidgetEntry(date: Date(),
                                               item: Item()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
