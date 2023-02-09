//
//  NetworkRequestProtocol.swift
//  WAIE
//
//  Created by Anshu Kumar Ray on 09/02/23.
//
import Combine
import Foundation

public protocol NetworkRequestProtocol {
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
