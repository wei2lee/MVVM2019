//
//  RxOperator.swift
//  AIA
//
//  Created by lee yee chuan on 5/6/17.
//  Copyright © 2017 tiny. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    public func unwrapNext<O>() -> RxCocoa.SharedSequence<Self.SharingStrategy, O>  where Element == Event<O> {
        return self.flatMap { (o:Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> in
            switch o {
            case .completed:
                return RxCocoa.SharedSequence<Self.SharingStrategy, O>.never()
            case .next(let element):
                return RxCocoa.SharedSequence<Self.SharingStrategy, O>.just(element)
            case .error( _):
                return RxCocoa.SharedSequence<Self.SharingStrategy, O>.never()
            }
        }
    }
    public func unwrapError<O>() -> RxCocoa.SharedSequence<Self.SharingStrategy, Error>  where Element == Event<O> {
        return self.flatMap { (o:Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, Error> in
            switch o {
            case .completed:
                return RxCocoa.SharedSequence<Self.SharingStrategy, Error>.never()
            case .next( _):
                return RxCocoa.SharedSequence<Self.SharingStrategy, Error>.never()
            case .error(let error):
                return RxCocoa.SharedSequence<Self.SharingStrategy, Error>.just(error)
            }
        }
    }
    public func unwrapStopEvent<O>() -> RxCocoa.SharedSequence<Self.SharingStrategy, Void>  where Element == Event<O> {
        return self.flatMap { (o:Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, Void> in
            switch o {
            case .completed:
                return RxCocoa.SharedSequence<Self.SharingStrategy, Void>.just(())
            case .next( _):
                return RxCocoa.SharedSequence<Self.SharingStrategy, Void>.never()
            case .error( _):
                return RxCocoa.SharedSequence<Self.SharingStrategy, Void>.just(())
            }
        }
    }
}

extension Observable {
    func unwrap<O>() -> Observable<O> where Element == Optional<O> {
        return self.flatMap { (o:Element) -> Observable<O> in
            switch o {
            case .none: return Observable<O>.empty()
            case .some(let wrapped): return Observable<O>.just(wrapped)
            }
        }
    }
}
extension SharedSequenceConvertibleType {
    public func unwrap<O>() -> RxCocoa.SharedSequence<Self.SharingStrategy, O>  where Element == Optional<O> {
        return self.flatMap { (o:Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> in
            switch o {
            case .none: return RxCocoa.SharedSequence<Self.SharingStrategy, O>.empty()
            case .some(let wrapped): return RxCocoa.SharedSequence<Self.SharingStrategy, O>.just(wrapped)
            }
        }
    }
}
extension ObservableType {
    public func compactMap<O>(_ selector: @escaping (Self.Element) throws -> O?) -> Observable<O> {
        return self.flatMap { (o:Self.Element) -> Observable<O> in
            do {
                if let e:O = try selector(o) {
                    return RxSwift.Observable<O>.just(e)
                } else {
                    return RxSwift.Observable<O>.empty()
                }
            } catch {
                return RxSwift.Observable<O>.empty()
            }
        }
    }
}
extension SharedSequenceConvertibleType {
    public func compactMap<O>(_ selector: @escaping (Self.Element) throws -> O?) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> {
        return self.flatMap { (o:Self.Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> in
            do {
                if let e:O = try selector(o) {
                    return RxCocoa.SharedSequence<Self.SharingStrategy, O>.just(e)
                } else {
                    return RxCocoa.SharedSequence<Self.SharingStrategy, O>.empty()
                }
            } catch {
                return RxCocoa.SharedSequence<Self.SharingStrategy, O>.empty()
            }
        }
    }
}
extension ObservableType {
    public func compactMapLatest<O>(_ selector: @escaping (Self.Element) throws -> O?) -> Observable<O> {
        return self.flatMapLatest { (o:Self.Element) -> Observable<O> in
            do {
                if let e:O = try selector(o) {
                    return RxSwift.Observable<O>.just(e)
                } else {
                    return RxSwift.Observable<O>.empty()
                }
            } catch {
                return RxSwift.Observable<O>.empty()
            }
        }
    }
}
extension SharedSequenceConvertibleType {
    public func compactMapLatest<O>(_ selector: @escaping (Self.Element) throws -> O?) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> {
        return self.flatMapLatest { (o:Self.Element) -> RxCocoa.SharedSequence<Self.SharingStrategy, O> in
            do {
                if let e:O = try selector(o) {
                    return RxCocoa.SharedSequence<Self.SharingStrategy, O>.just(e)
                } else {
                    return RxCocoa.SharedSequence<Self.SharingStrategy, O>.empty()
                }
            } catch {
                return RxCocoa.SharedSequence<Self.SharingStrategy, O>.empty()
            }
        }
    }
}
extension Observable {
    func asVoid() -> Observable<Void> {
        return self.map { _ in () }
    }
}
extension Observable {
    func replaceNilWith(value: Element) -> Observable<Element> {
        return map {element in element == nil ? value : element}
    }
}
extension Observable where Element: Equatable {
    public func filterOut(targetValue: Element) -> Observable<Element> {
        return self.filter {value in targetValue != value}
    }
}

extension Observable {
    public func optional() -> Observable<Element?> {
        return self.flatMap { Observable<Element?>.just($0) }
    }
}

extension Observable {
    public func catchErrorJustSkip() -> Observable<Element> {
        return self.catchError({ _ in return Observable.never() })
        
    }
    public func asDriverOnErrorJustSkip() -> Driver<Element> {
        return self.catchErrorJustSkip().asDriverOnErrorJustComplete()
    }
}

extension SharedSequenceConvertibleType {
    public func asVoid() -> RxCocoa.SharedSequence<Self.SharingStrategy, Void> {
        return self.map { _ in () }
    }
}

extension SharedSequenceConvertibleType {
    public func optional() -> RxCocoa.SharedSequence<Self.SharingStrategy, Element?> {
        return self.flatMap { RxCocoa.SharedSequence<Self.SharingStrategy, Element?>.just($0) }
    }
}

public enum AIAResult<Value> {
    case success(Value)
    case failure(Error)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    public var nserror: NSError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error as NSError
        }
    }
}
