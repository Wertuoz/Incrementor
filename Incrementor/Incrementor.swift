//
//  Incrementor.swift
//  Incrementor
//
//  Created by Anton Trofimenko on 11/03/2019.
//  Copyright © 2019 Anton Trofimenko. All rights reserved.
//

import Foundation

/**
 Коды возможных ошибок по ходу работы Incrementor
 - MaxLessThanZero: для проверки максимального значения на знак(<0).
 */
enum IncrementorErrorCode: Int {
    /// Код при ошибке проверки максимального значения на знак(<0).
    case MaxLessThanZero = 1
}

/**
 Сообщения возможных ошибок по ходу работы Incrementor
 - MaxLessThanZero: для проверки максимального значения на знак(<0).
 */
enum IncrementorErrorMessage: String {
    /// Сооющение при ошибке проверки максимального значения на знак(<0).
    case MaxLessThanZero = "Max number can't be less than 0"
}

/**
 Возможные ошибки по ходу работы Incrementor
 - minValueError: ошибка установки максимального значения <0.
 */
struct IncrementorError {
    /// Ошибка установки максимального значения <0
    static let minValueError = NSError(domain: "", code: IncrementorErrorCode.MaxLessThanZero.rawValue, userInfo: [NSLocalizedDescriptionKey: IncrementorErrorMessage.MaxLessThanZero.rawValue])
}

/// Класс для безопасного инкремента с проверкой на выход за границы максимального числа
class Incrementor {
    
    /// Текущее значение
    private var currentValue = 0
    
    /// Максимальное значение
    private var maxValue = Int.max

    /**
        Getter для currentValue
        - Returns: Текущее значение currentValue.
     */
    func getNumber() -> Int {
        return currentValue
    }
    
    /// Увеличивает текущее значение с проверкой на выход за границы диапозона
    func incrementNumber() {
        currentValue += 1
        checkForOverflow()
    }
    
    /**
        Setter для maxValue
        - Parameters:
            - maximumValue: Ограничение для максимального значения
        - Throws: Возможна ошибка IncrementorError.minValueError при установке значения <0.
     */
    func setMaximumValue(_ maximumValue: Int) throws {
        if maximumValue < 0 {
            throw IncrementorError.minValueError
        }
        maxValue = maximumValue
        checkForOverflow()
    }
    
    /// Проверка на выход currentValue за границы диапозона maxValue
    private func checkForOverflow() {
        if currentValue >= maxValue {
            currentValue = 0
        }
    }
    
}
