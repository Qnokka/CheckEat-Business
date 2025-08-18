//
//  ManageBusinessHoursView.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import SwiftUI

struct ManageBusinessHoursView: View {
    
    // MARK: 스크린 상태 값
    @Binding var showManageBusinessHours: Bool
    let storeId: Int
    @StateObject private var viewModel = ManageStoreTimeViewModel()
    
    @FocusState private var fieldIsFocused: Bool
    let midnight = Calendar.current.startOfDay(for: Date())
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    //MARK: 영업시간 관리 - 전부 동일
    //영업시간(오픈, 마감) 변수 선언
    @State private var openTimeSameAll = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeSameAll = Calendar.current.startOfDay(for: Date())
    @State private var savedOpenTime: Date?
    @State private var savedCloseTime: Date?
    //휴게시간 변수 선언
    @State var breakTimesSameAll: [BreakTime] = []
    
    //MARK: 영업시간 관리 - 평일/주말 다름
    //평일 | 영업시간(오픈, 마감) 변수 선언
    @State private var openTimeWeekday = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeWeekday = Calendar.current.startOfDay(for: Date())
    //평일 | 휴게시간 변수 선언
    @State var breakTimesWeekday: [BreakTime] = []
    //주말 | 영업시간(오픈, 마감) 변수 선언
    @State private var openTimeWeekend = Calendar.current.startOfDay(for: Date())
    @State private var closeTimeWeekend = Calendar.current.startOfDay(for: Date())
    //주말 | 휴게시간 변수 선언
    @State var breakTimesWeekend: [BreakTime] = []
    
    @State private var is24Hours = false
    @State private var showTimeWarning = false
    @State private var showTimeAlert = false
    @State private var showOvernightConfirm = false
    @State private var allowOvernightBusiness = false
    
    enum BusinessHourType {
        case sameAll
        case weekdayWeekendDifferent
    }
    @State private var businessHourType: BusinessHourType = .sameAll
    
    var body: some View {
        NavigationView {
        ScrollView {
            VStack(alignment: .leading) {
                businessHourTypeSection
                businessHoursSection
            }
            .padding(.top, 35)
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            completeButtonSection
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(uiColor: .systemBackground))
        }
        .navigationTitle("영업시간 관리")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showManageBusinessHours = false
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundStyle(.black)
                }
            }
        }
        .onTapGesture {
            fieldIsFocused = false
        }
        .scrollDismissesKeyboard(.interactively)
    }
    }
    
    private var businessHourTypeSection: some View {
        VStack(alignment: .leading) {
            Text("영업시간을 알려주세요")
                .semibold16()
            HStack {
                Button {
                    businessHourType = .sameAll
                } label: {
                    Text("전부 동일함")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .selectedButtonStyle(isSelected: businessHourType == .sameAll, width: UIScreen.main.bounds.width/2.5)
                
                Button {
                    businessHourType = .weekdayWeekendDifferent
                } label: {
                    Text("평일/주말 다름")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
                .selectedButtonStyle(isSelected: businessHourType == .weekdayWeekendDifferent, width: UIScreen.main.bounds.width/2.5)
            }
            .padding(.vertical)
        }
    }
    
    private var businessHoursSection: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color("Button_OP20"))
                .frame(height: 1)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
            
            if businessHourType == .sameAll {
                BusinessHoursPickerView(
                    openTime: $openTimeSameAll,
                    closeTime: $closeTimeSameAll,
                    showTimeWarning: $showTimeWarning,
                    is24Hours: $is24Hours,
                    shows24HourOption: true
                )
                BreakTimeAddListView(breakTimes: $breakTimesSameAll)
                
            } else if businessHourType == .weekdayWeekendDifferent {
                BusinessHoursPickerView(
                    openTime: $openTimeWeekday,
                    closeTime: $closeTimeWeekday,
                    showTimeWarning: $showTimeWarning
                )
                BreakTimeAddListView(breakTimes: $breakTimesWeekday)
                BusinessHoursPickerView(
                    openTime: $openTimeWeekend,
                    closeTime: $closeTimeWeekend,
                    showTimeWarning: $showTimeWarning
                )
                BreakTimeAddListView(breakTimes: $breakTimesWeekend)
            }
        }
    }
    
    private var completeButtonSection: some View {
        Button {
            completeButtonAction()
            
        } label: {
            Text("완료")
        }
        .primaryButtonStyle()
        .padding(.vertical, 24)
        .alert("영업시간을 확인해주세요", isPresented: $showTimeAlert) {
            Button("확인", role: .cancel) { }
        } message: {
            Text("오픈 시간이 마감 시간과 같거나 이후일 수 없습니다.")
        }
        .alert("밤샘 영업 확인", isPresented: $showOvernightConfirm) {
            Button("취소", role: .cancel) { }
            Button("밤샘 영업", role: .none) {
                allowOvernightBusiness = true
                completeButtonAction()
            }
        } message: {
            Text("오픈 시간이 마감 시간보다 늦습니다. 밤샘 영업인가요?")
        }
    }
    
    private func completeButtonAction() {
        var errorFound = false
        
        switch businessHourType {
        case .sameAll:
            if is24Hours {
                openTimeSameAll = Calendar.current.startOfDay(for: Date())
                closeTimeSameAll = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: openTimeSameAll) ?? openTimeSameAll.addingTimeInterval(86340)
            }
            if openTimeSameAll == closeTimeSameAll {
                errorFound = true
                showTimeAlert = true
            }
            if openTimeSameAll > closeTimeSameAll && !allowOvernightBusiness {
                showOvernightConfirm = true
                return
            }
            breakTimesSameAll.removeAll { $0.breakStartTime == $0.breakEndTime }
            
            //MARK: - 영업시간 (오픈 ~ 클로즈)
            let open = dateFormatter.string(from: openTimeSameAll)
            let close = dateFormatter.string(from: closeTimeSameAll)
            print("영업시간: \(open) ~ \(close)")

            if breakTimesSameAll.isEmpty {
                print("휴게시간 없음")
            } else {
                for (index, breakTime) in breakTimesSameAll.enumerated() {
                    let start = dateFormatter.string(from: breakTime.breakStartTime)
                    let end = dateFormatter.string(from: breakTime.breakEndTime)
                    //MARK: - 휴게시간 (시작 ~ 마감)
                    print("휴게시간 \(index + 1): \(start) ~ \(end)")
                }
            }
        case .weekdayWeekendDifferent:
            if openTimeWeekday == closeTimeWeekday || openTimeWeekend == closeTimeWeekend {
                errorFound = true
                showTimeAlert = true
                return
            }
            if (openTimeWeekday > closeTimeWeekday || openTimeWeekend > closeTimeWeekend) && !allowOvernightBusiness {
                showOvernightConfirm = true
                return
            }
            breakTimesWeekday.removeAll { $0.breakStartTime == $0.breakEndTime }
            breakTimesWeekend.removeAll { $0.breakStartTime == $0.breakEndTime }
            
            
            let weekdayOpen = dateFormatter.string(from: openTimeWeekday)
            let weekdayClose = dateFormatter.string(from: closeTimeWeekday)
            print("평일 영업시간: \(weekdayOpen) ~ \(weekdayClose)")

            if breakTimesWeekday.isEmpty {
                print("평일 휴게시간 없음")
            } else {
                for (index, breakTime) in breakTimesWeekday.enumerated() {
                    let start = dateFormatter.string(from: breakTime.breakStartTime)
                    let end = dateFormatter.string(from: breakTime.breakEndTime)
                    print("평일 휴게시간 \(index + 1): \(start) ~ \(end)")
                }
            }

            let weekendOpen = dateFormatter.string(from: openTimeWeekend)
            let weekendClose = dateFormatter.string(from: closeTimeWeekend)
            print("주말 영업시간: \(weekendOpen) ~ \(weekendClose)")

            if breakTimesWeekend.isEmpty {
                print("주말 휴게시간 없음")
            } else {
                for (index, breakTime) in breakTimesWeekend.enumerated() {
                    let start = dateFormatter.string(from: breakTime.breakStartTime)
                    let end = dateFormatter.string(from: breakTime.breakEndTime)
                    print("주말 휴게시간 \(index + 1): \(start) ~ \(end)")
                }
            }
        }
        if !errorFound {
            //TODO: 영업시간 및 휴게시간 서버로 전송 로직 구현
            switch businessHourType {
            case .sameAll:
                // 모두 같은 시간으로 넣으면 됨
                let holi_break: String?
                if breakTimesSameAll.isEmpty {
                    holi_break = "NONE"
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let breaks = breakTimesSameAll.map { "\(dateFormatter.string(from: $0.breakStartTime))~\(dateFormatter.string(from: $0.breakEndTime))" }
                    holi_break = breaks.joined(separator: ",")
                }
                let openClose = "\(dateFormatter.string(from: openTimeSameAll))~\(dateFormatter.string(from: closeTimeSameAll))"
                viewModel.saveRunTime(
                    sto_id: storeId,
                    holi_break: holi_break,
                    holi_runtime_sun: openClose,
                    holi_runtime_mon: openClose,
                    holi_runtime_tue: openClose,
                    holi_runtime_wed: openClose,
                    holi_runtime_thu: openClose,
                    holi_runtime_fri: openClose,
                    holi_runtime_sat: openClose,
                    completion: { _ in }
                )
            case .weekdayWeekendDifferent:
                let holi_break: String?
                if breakTimesWeekday.isEmpty && breakTimesWeekend.isEmpty {
                    holi_break = "NONE"
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm"
                    let weekdayBreaks = breakTimesWeekday.map { "\(dateFormatter.string(from: $0.breakStartTime))~\(dateFormatter.string(from: $0.breakEndTime))" }.joined(separator: ",")
                    let weekendBreaks = breakTimesWeekend.map { "\(dateFormatter.string(from: $0.breakStartTime))~\(dateFormatter.string(from: $0.breakEndTime))" }.joined(separator: ",")
                    var parts: [String] = []
                    if !weekdayBreaks.isEmpty {
                        parts.append("W:\(weekdayBreaks)")
                    }
                    if !weekendBreaks.isEmpty {
                        parts.append("E:\(weekendBreaks)")
                    }
                    holi_break = parts.joined(separator: ";")
                }
                let weekdayOpenClose = "\(dateFormatter.string(from: openTimeWeekday))~\(dateFormatter.string(from: closeTimeWeekday))"
                let weekendOpenClose = "\(dateFormatter.string(from: openTimeWeekend))~\(dateFormatter.string(from: closeTimeWeekend))"
                viewModel.saveRunTime(
                    sto_id: storeId,
                    holi_break: holi_break,
                    holi_runtime_sun: weekendOpenClose,
                    holi_runtime_mon: weekdayOpenClose,
                    holi_runtime_tue: weekdayOpenClose,
                    holi_runtime_wed: weekdayOpenClose,
                    holi_runtime_thu: weekdayOpenClose,
                    holi_runtime_fri: weekdayOpenClose,
                    holi_runtime_sat: weekendOpenClose,
                    completion: { _ in }
                )
            }
            showManageBusinessHours = false
        }
    }
}
