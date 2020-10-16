import Foundation

public class PowerJSONEncoder {
    public var dataEncodingStrategy: PowerJSONEncoder.DataEncodingStrategy = .base64
    public var dateEncodingStrategy: PowerJSONEncoder.DateEncodingStrategy = .deferredToDate
    public var keyEncodingStrategy: PowerJSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    public var outputFormatting: PowerJSONEncoder.OutputFormatting = []

    /// 逆向模型转化
    /// - Parameters:
    ///   - value: 实现Encodable对象
    ///   - outputType: 输出类型, 只支持[Data String JSONStructure(json结构)]
    /// - Throws: 解析异常
    /// - Returns: 输出值
    func encode<T, U>(value: T, to: U.Type) throws -> U.Wrapper where T: Encodable, U: JSONCodingSupport {
        let encoder = PowerInnerJSONEncoder(value: value)
        try value.encode(to: encoder)
        let topLevel = encoder.jsonValue
        let options = Formatter.Options(formatting: self.outputFormatting, dataEncoding: self.dataEncodingStrategy, dateEncoding: self.dateEncodingStrategy, keyEncoding: self.keyEncodingStrategy)
        let formatter = Formatter(topLevel: topLevel, options: options, encoder: encoder)
        let data: Data = try formatter.writeJSON()
        if to.Wrapper == Data.self {
            return data as! U.Wrapper
        } else if to.Wrapper == String.self {
            return (String(data: data, encoding: String.Encoding.utf8) ?? "error") as! U.Wrapper
        } else if to.Wrapper == Any.self {
            return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! U.Wrapper
        } else {
            throw CodingError.unsupportType()
        }
    }
}

protocol JSONValue {
    var jsonValue: JSON { get }
}

class PowerInnerJSONEncoder: Encoder {
    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]
    fileprivate var container: JSONValue?

    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }
    var paths: [Path] = []
    var value: Encodable
    var mappingKeys: [String: String]?

    init(value: Encodable) {
        self.value = value
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        assertCanCreateContainer()
        let container = EncodingKeyed<Key>(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return KeyedEncodingContainer(container)
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        assertCanCreateContainer()
        let container = EncodingUnkeyed(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        assertCanCreateContainer()
        let container = EncodingSingleValue(encoder: self, codingPath: self.codingPath, userInfo: self.userInfo)
        self.container = container
        return container
    }
}

extension PowerInnerJSONEncoder: TypeConvertible {}

extension PowerInnerJSONEncoder: JSONValue {
    var jsonValue: JSON {
        return container?.jsonValue ?? .null
    }
}
