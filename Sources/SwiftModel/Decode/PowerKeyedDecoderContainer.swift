import Foundation

final class PowerKeyedDecodingContainer<K: CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K
    private unowned let decoder: PowerInnerJSONDecoder
    private let rootObject: [String: JSON]
    
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }
    
    init(referencing decoder: PowerInnerJSONDecoder, wrapping object: [String: JSON]) {
        self.decoder  = decoder
        self.rootObject  = object
    }
    
    var allKeys: [Key] {
        return rootObject.keys.compactMap(Key.init)
    }
    
    func contains(_ key: Key) -> Bool {
        return rootObject[key.stringValue] != nil
    }

    @inline(__always)
    private func getObject(forKey key: Key) throws -> JSON {
        guard let object = rootObject[key.stringValue] else {
            if rootObject.count == 0 {
                return JSON(dictionaryLiteral: ("", ""))
            } else {
                if self.decoder.mappingKeys != nil {
                    for k in self.decoder.mappingKeys?[key.stringValue] ?? [] {
                        switch rootObject[k] {
                        case .none: continue
                        case .some(let json): return json
                        }
                    }
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please confirm MappingKeysControllable")
                    return JSON(dictionaryLiteral: ("", ""))
                } else {
                    debugPrint("key: \(key.stringValue) not found, use default value, if you want to custom define key please confirm MappingKeysControllable")
                    return JSON(dictionaryLiteral: ("", ""))
                }
            }
        }
        return object
    }
}

extension PowerKeyedDecodingContainer {
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unbox(object: getObject(forKey: key), forKey: key)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unboxNil(object: getObject(forKey: key), forKey: key)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        self.decoder.paths.push(value: Path.index(by: key.stringValue))
        defer {
            self.decoder.paths.pop()
        }
        debugPrint(self.decoder.paths.jsonPath)
        return try decoder.unboxDecodable(object: getObject(forKey: key), forKey: key)
    }
}

extension PowerKeyedDecodingContainer {
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(key)
        defer { codingPath.removeLast() }
        let object = try getObject(forKey: key)
        return try decoder.container(keyedBy: type, wrapping: object)
    }

    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let object = try getObject(forKey: key)

        return try decoder.unkeyedContainer(wrapping: object)
    }
}

extension PowerKeyedDecodingContainer {
    func superDecoder() throws -> Decoder {
        return try buildSuperDecoder(forKey: PowerJSONKey.super)
    }

    func superDecoder(forKey key: K) throws -> Decoder {
        return try buildSuperDecoder(forKey: key)
    }

    private func buildSuperDecoder(forKey key: CodingKey) throws -> Decoder {
        codingPath.append(key)
        defer { codingPath.removeLast() }

        let value = (key is PowerJSONKey) == true ? JSON.object(rootObject) : rootObject[key.stringValue, default: .null]
        return PowerInnerJSONDecoder(referencing: value, at: decoder.codingPath)
    }
}