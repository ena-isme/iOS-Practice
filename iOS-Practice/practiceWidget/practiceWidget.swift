//
//  practiceWidget.swift
//  practiceWidget
//
//  Created by 신지원 on 12/21/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //찰칵 하면서 어떻게 위젯이 보이길바라는지에 대한 정보
        
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //시간에 따른 Data 를 의미한다.
        //공개되기 전에 sneak peek 한다고 표현
        
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        //policy 의 옵션 - atEnd, after(Date), never
        //atEnd 는 시간마다 반복
        //after(Date) 는 특정 시간
        //never 는 바뀌지 않음. 사용자의 entry에 의존하는 어플일 때 주로 설정 ex) 메모
        
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct practiceWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct practiceWidget: Widget {
    let kind: String = "practiceWidget"

    var body: some WidgetConfiguration {
        // 유저가 위젯 설정을 할 수 있는 부분
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                practiceWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                practiceWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    practiceWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
