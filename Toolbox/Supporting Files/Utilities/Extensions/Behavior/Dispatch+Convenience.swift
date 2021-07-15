//
//  Dispatch+Convenience.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation

// MARK: - Convenience Global Dispatchers

// MARK: Main Queue

func dispatchAsyncInMainQueue(after delay: Double = 0,
                              block: @escaping () -> Void) {
    DispatchQueue.main.async(after: delay, execute: block)
}

// MARK: Quality of service

func dispatchAsync(after delay: Double = 0,
                   qos: DispatchQoS,
                   function: String = #function,
                   block: @escaping () -> Void) {
    DispatchQueue(qos: qos, function: function).async(after: delay, execute: block)
}

func dispatchSync(qos: DispatchQoS,
                  function: String = #function,
                  block: @escaping () -> Void) {
    DispatchQueue(qos: qos, function: function).sync(execute: block)
}

// MARK: - DispatchQueue

extension DispatchQueue {
    convenience init(qos: DispatchQoS = .unspecified,
                     attributes: DispatchQueue.Attributes = [],
                     autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit,
                     target: DispatchQueue? = nil,
                     function: String) {
        self.init(
            label: "com.tbxnet.Toolbox.\(function)",
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: target)
    }

    fileprivate func async(after delay: Double = 0, execute block: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: block)
    }
}
