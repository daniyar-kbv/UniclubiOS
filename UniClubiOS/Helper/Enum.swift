//
//  Enum.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

enum PtSansStyles: String {
    case regular = "Regular"
    case italic = "Italic"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
}

enum FontStyles: String {
    case mediumItalic = "MediumItalic"
    case medium = "Medium"
    case lightItalic = "LightItalic"
    case light = "Light"
    case bookItalic = "BookItalic"
    case book = "Book"
    case ultraItalic = "UltraItalic"
    case ultra = "Ultra"
    case boldItalic = "BoldItalic"
    case bold = "Bold"
    case extraLightItalic = "ExtraLightItalic"
    case extraLight = "ExtraLight"
}

enum FilterType {
    case ageGroup
    case attendanceType
    case administrativeDivision
    case lessonGroup
    case lessonType
    
    var logo: UIImage {
        switch self {
        case .ageGroup:
            return UIImage(named: "filter1")!
        case .attendanceType:
            return UIImage(named: "filter2")!
        case .administrativeDivision:
            return UIImage(named: "filter3")!
        case .lessonGroup:
            return UIImage(named: "filter4")!
        case .lessonType:
            return UIImage(named: "filter5")!
        }
    }
    
    var title: String {
        switch self {
        case .ageGroup:
            return "Возрастная категория"
        case .attendanceType:
            return "Вид посещения"
        case .administrativeDivision:
            return "Административное деление"
        case .lessonGroup:
            return "Группа занятий"
        case .lessonType:
            return "Вид занятия"
        }
    }
}

enum FormFieldType {
    case firstName
    case lastName
    case companyName
    case phone
    case email
    
    var title: String {
        switch self {
        case .firstName:
            return "Имя"
        case .lastName:
            return "Фамилия"
        case .companyName:
            return "Название компании"
        case .phone:
            return "Номер телефона"
        case .email:
            return "E-mail"
        }
    }
    
    var placeholer: String {
        switch self {
        case .firstName:
            return "Введите имя"
        case .lastName:
            return "Введите фамилию"
        case .companyName:
            return "Введите название компании"
        case .phone:
            return "+7 7ХХ ХХХ ХХ ХХ"
        case .email:
            return "Введите E-mail"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .phone:
            return .decimalPad
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
}

enum FormType {
    case partner
    case booking
    
    var title: String {
        switch self {
        case .partner:
            return "Стать партнером UniClub"
        case .booking:
            return "Бронирование"
        }
    }
}

enum TimeTypes: String {
    case beforeLunch = "BEFORE_LUNCH"
    case afterLunch = "AFTER_LUNCH"
    case allDay = "ALL_DAY"
    
    var title: String {
        switch self {
        case .beforeLunch:
            return "До обеда"
        case .afterLunch:
            return "После обеда"
        case .allDay:
            return "Весь день"
        }
    }
}

enum WeekDays: Int {
    case mon = 0
    case tue = 1
    case wed = 2
    case thu = 3
    case fri = 4
    case sat = 5
    case sun = 6
    
    var name: String {
        switch self {
        case .mon:
            return "Понедельник"
        case .tue:
            return "Вторник"
        case .wed:
            return "Среда"
        case .thu:
            return "Четверг"
        case .fri:
            return "Пятница"
        case .sat:
            return "Суббота"
        case .sun:
            return "Воскресенье"
        }
    }
    
    var nameShort: String {
        switch self {
        case .mon:
            return "Пн"
        case .tue:
            return "Вт"
        case .wed:
            return "Ср"
        case .thu:
            return "Чт"
        case .fri:
            return "Пт"
        case .sat:
            return "Сб"
        case .sun:
            return "Вс"
        }
    }
}

enum DetailButtonStates: String {
    case chooseSchedule = "Выбрать расписание"
    case changeSchedule = "Изменить расписание"
    case addToCart = "Добавить в корзину"
    case apply = "Применить"
}
