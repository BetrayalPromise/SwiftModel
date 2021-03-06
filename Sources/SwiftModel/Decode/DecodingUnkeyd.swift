import Foundation

struct DecodingUnkeyed: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] {
        get { return decoder.codingPath }
        set { decoder.codingPath = newValue }
    }

    var count: Int? {
        return json.count
    }
    
    var isAtEnd: Bool {
        return currentIndex >= json.count
    }
    
    var currentIndex: Int = 0

    private unowned let decoder: PowerInnerJSONDecoder
    private let json: [JSON]

    init(decoder: PowerInnerJSONDecoder, json: [JSON]) {
        self.json = json
        self.decoder = decoder
    }

    private var currentKey: CodingKey {
        return Path.index(by: self.currentIndex)
    }

    @inline(__always)
    private mutating func getCurrentObject() throws -> JSON {
        guard !isAtEnd else {
            throw CodingError.Decoding.valueNotFound(type: JSON.self, codingPath: decoder.codingPath + [currentKey])
        }
        defer { currentIndex += 1 }
        return json[currentIndex]
    }
}

extension DecodingUnkeyed {
    var paths: [Path] {
        get { return self.decoder.wrapper?.paths ?? [] }
        set { self.decoder.wrapper?.paths = newValue }
    }
}

extension DecodingUnkeyed {
    mutating func decodeNil() throws -> Bool {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unboxNil(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode(_ type: String.Type) throws -> String {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unbox(object: getCurrentObject(), forKey: currentKey)
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        self.paths.push(value: Path.index(by: currentIndex))
        defer { self.paths.pop() }
        debugPrint(self.paths.jsonPath)
        return try decoder.unboxDecodable(object: getCurrentObject(), forKey: currentKey)
    }
}

extension DecodingUnkeyed {
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        codingPath.append(currentKey)
        defer { codingPath.removeLast() }
        return try decoder.container(keyedBy: type, wrapping: getCurrentObject())
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try decoder.unkeyedContainer(wrapping: getCurrentObject())
    }
}

extension DecodingUnkeyed {
    mutating func superDecoder() throws -> Decoder {
        return PowerInnerJSONDecoder(json: JSON.array(json), at: decoder.codingPath)
    }
}
