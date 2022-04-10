//
//  URLBuilder.swift
//  AQUA
//
//  Created by Илья Желтиков on 09.04.2022.
//

import Foundation

final class URLBuilder {

    private var scheme = "https"
    private var host: String?
    private var port: Int?
    private var path = ""

    func with(scheme: String) -> URLBuilder {
        self.scheme = scheme
        return self
    }

    func with(host: String) -> URLBuilder {
        self.host = host
        return self
    }

    func with(port: Int) -> URLBuilder {
        self.port = port
        return self
    }

    func with(path: String) -> URLBuilder {
        self.path = path
        return self
    }
}

extension URLBuilder {

    func build() throws -> URL {
        guard let host = host else {
            throw URLBuilderError.emptyHost
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = path

        guard let url = urlComponents.url else {
            throw URLBuilderError.systemError
        }

        return url
    }
    enum URLBuilderError: Error {
        case emptyHost
        case systemError
    }
}
