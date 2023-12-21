//
//  practiceWidget.swift
//  practiceWidget
//
//  Created by 신지원 on 12/21/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }
    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        //찰칵 하면서 어떻게 위젯이 보이길바라는지에 대한 정보
        
        let entry = DayEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //시간에 따른 Data 를 의미한다.
        //공개되기 전에 sneak peek 한다고 표현
        
        var entries: [DayEntry] = []
        
        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = Calendar.current.startOfDay(for: entryDate)
            //다음날 자정에 업데이트하고자 하기 때문에 startOfDay 추가
            
            let entry = DayEntry(date: entryDate)
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

struct DayEntry: TimelineEntry {
    let date: Date
}

struct practiceWidgetEntryView : View {
    var entry: DayEntry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(config.emojiText)
                Text(entry.date.weekdayDisplayForms)
                    .font(.title3)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.6)    
                    .foregroundColor(config.weekdayTextColor)
//                Spacer()
            }
            
            Text(entry.date.dayDisplayForms)
                .font(.system(size: 80, weight: .heavy))
                .foregroundColor(config.dayTextColor)
        }
    }
}

struct practiceWidget: Widget {
    let kind: String = "practiceWidget"
    
    var body: some WidgetConfiguration {
        // 유저가 위젯 설정을 할 수 있는 부분
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                var config = MonthConfig.determineConfig(from: entry.date)
                
                practiceWidgetEntryView(entry: entry)
                    .containerBackground(config.backgroundColor, for: .widget)
                //                    .onAppear {
                //                        print("17 이상")
                //                    }
            } else {
                practiceWidgetEntryView(entry: entry)
                    .padding()
                    .background(Color.clear)
            }
        }
        .configurationDisplayName("JiwonStyle")
        .description("I made it. haha blabla haha💖")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

#Preview(as: .systemSmall) {
    practiceWidget()
} timeline: {
    DayEntry(date: .now)
    DayEntry(date: .now)
}

extension Date {
    var weekdayDisplayForms: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    
    var dayDisplayForms: String {
        self.formatted(.dateTime.day())
    }
}
