//
//  AstronomyViewModel.swift
//  WAIE
//
//  Created by Anshu Kumar Ray on 09/02/23.
//

import Combine
import Foundation
import Network

class AstronomyViewModel: ObservableObject {
    @Published var planetaryResponse: PlanetaryResponse? = nil
    var subscriptions = Set<AnyCancellable>()
    
    let planetaryService: PlanetaryServiceable
    
    init(planetaryService: PlanetaryServiceable = PlanetaryService(networkRequest: NetworkRequestable())) {
        self.planetaryService = planetaryService
        fetchAstronomyData()
    }
    
    func fetchAstronomyData() {
        planetaryService.getPlanetaryItems()
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                print("Response:: \(response)")
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        subscriptions.removeAll()
    }
}

protocol PlanetaryServiceable {
    func getPlanetaryItems() -> AnyPublisher<PlanetaryResponse, NetworkError>
}

class PlanetaryService: PlanetaryServiceable {
    
    private var networkRequest: NetworkRequestProtocol
    private var environment: Environment
    
    init(networkRequest: NetworkRequestProtocol, environment: Environment = .staging) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func getPlanetaryItems() -> AnyPublisher<PlanetaryResponse, NetworkError> {
        let endpoint = APIEndpoints.getPlanetary
        let request = endpoint.createRequest(key: apiKey, environment: self.environment)
        return self.networkRequest.request(request)
    }
    
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
      }
    }
}

public struct PlanetaryResponse: Codable {
    public let copyright: String?
    public let explanation: String?
    public let imageUrl: String?
    
    public enum CodingKeys: String, CodingKey {
        case copyright
        case explanation
        case imageUrl = "hdurl"
    }
}
