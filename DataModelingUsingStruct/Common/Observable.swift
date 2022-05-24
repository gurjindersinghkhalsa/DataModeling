//
//  Observable.swift
//  DataModelingUsingStruct
//
//  Created by Gurjinder Singh on 24/05/22.
//

import Foundation

class Observable<Value> {
    private var closure: ((Value) -> ())?
    
    public var value: Value {
        didSet { closure?(value) }
    }
    public init(_ value: Value) {
        self.value = value
    }
    public func observe(_ closure: @escaping (Value) -> Void) {
        self.closure = closure
        closure(value)
    }
}
