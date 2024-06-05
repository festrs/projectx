import UIKit
import _Concurrency
import PlaygroundSupport

var greeting = "Hello, playground"

protocol Service: AnyObject {
    var id: UUID { get }
}

actor ServiceRegistry {
    enum Errors: LocalizedError {
        case notFound
        case parsing
    }

    enum Entry {
        case instance(Service)
        case factory((ServiceRegistry) throws -> Service)
    }

    private var services = [ObjectIdentifier: Entry]()

    func store<O>(_ type: O.Type, factory: @escaping (ServiceRegistry) -> some Service) {
        let key = ObjectIdentifier(type)
        services[key] = .factory(factory)
    }

    func service<S>(withID id: S.Type, serviceLocator: ServiceRegistry) throws -> S {
        let key = ObjectIdentifier(id)

        guard let entry = services[key] else {
            throw Errors.notFound
        }

        switch entry {
        case let .factory(factor):
            let service = try factor(serviceLocator)
            services[key] = .instance(service)
            guard let returnType = service as? S else {
                throw Errors.parsing
            }
            return returnType

        case let .instance(service):
            guard let returnType = service as? S else {
                throw Errors.parsing
            }
            return returnType
        }
    }
}

protocol IdentityVerificationService: Service {
    func retrieve()
}

class LocalIdentityVerificationService: IdentityVerificationService {
    var id: UUID = UUID()


    func retrieve() {
        print("retrieve here")
    }
}

let serviceregistryobject = ServiceRegistry()
let idvService = LocalIdentityVerificationService()

let queueOne = DispatchQueue(label: "my.queue.one")
let queueTwo = DispatchQueue(label: "my.queue.two")

Task {
    sleep(2)
    await serviceregistryobject.store(IdentityVerificationService.self) { _ in
        return LocalIdentityVerificationService()
    }
    print("done")
}

Task {
    let serviceidv: IdentityVerificationService = try await serviceregistryobject.service(
        withID: IdentityVerificationService.self,
        serviceLocator: serviceregistryobject
    )
    serviceidv.retrieve()
}


PlaygroundPage.current.needsIndefiniteExecution = true
