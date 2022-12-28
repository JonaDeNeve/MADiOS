//
//  PARequest.swift
//  Pokade
//
//  Created by Jona De Neve on 26/12/2022.
//

import Foundation
import Combine

//Overgenomen uit voorbeeldproject Enroute en aangepast
class PARequest<Fetched> where Fetched: Codable, Fetched: Hashable
{
    private(set) var results = CurrentValueSubject<Set<Fetched>, Never>([])

    let batchSize = 15
    var offset: Int = 0
    lazy var howMany: Int = batchSize
    private(set) var fetchInterval: TimeInterval = 0

    // MARK: - Subclassers Overrides
    
    var cacheKey: String? { return nil } // nil means no cacheing
    var query: String { "" } // e.g. Enroute?airport=KSFO
    func decode(_ json: Data) -> Set<Fetched> { Set<Fetched>() } // json is JSON received from PokeAPI
    func filter(_ results: Set<Fetched>) -> Set<Fetched> { results } // optional filtering of results
    var fetchTimer: Timer? // so that subclasses can throttle fetches of their kind of object

    // MARK: - Private Data
    
    private var urlRequest: URLRequest? { Self.authorizedURLRequest(query: query) }
    private var fetchCancellable: AnyCancellable?
    private var fetchSequenceCount: Int = 0
    
    private var cacheData: Data? { cacheKey != nil ? UserDefaults.standard.data(forKey: cacheKey!) : nil }
    private var cacheTimestampKey: String { (cacheKey ?? "")+".timestamp" }
    private var cacheAge: TimeInterval? {
        let since1970 = UserDefaults.standard.double(forKey: cacheTimestampKey)
        if since1970 > 0 {
            return since1970
        } else {
            return nil
        }
    }

    // MARK: - Fetching
    
    // sets the fetchInterval to interval and fetch()es
    func fetch(andRepeatEvery interval: TimeInterval, useCache: Bool? = nil) {
        fetchInterval = interval
        if useCache != nil {
            fetch(useCache: useCache!)
        } else {
            fetch()
        }
    }
    
    // stops fetching
    // fetching can be restarted by calling one of the fetch functions
    func stopFetching() {
        fetchCancellable?.cancel()
        fetchTimer?.invalidate()
        fetchInterval = 0
        fetchSequenceCount = 0
    }
    
    // immediately fetches new data (from cache if available and requested)
    // and, when that data returns, calls handleResults with it
    // (which will schedule the next fetch if appropriate)
    func fetch(useCache: Bool = true) {
        if !useCache || !fetchFromCache() {
            if let urlRequest = self.urlRequest {
                print("fetching \(urlRequest)")
                if offset == 0 { fetchSequenceCount = 0 }
                fetchCancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
                    .map { [weak self] data, response in
                        return self?.decode(data) ?? []
                    }
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] results in self?.handleResults(results) }
            }
        }
    }
    
    // unions the newResults with our existing results.value
    // keeps fetching immediately (1s later) if ...
    //   our results.value.count < howMany
    //   and we haven't done howMany/15 fetches in a row (throttle)
    // otherwise schedules our next fetch after fetchInterval (and caches results)
    private func handleResults(_ newResults: Set<Fetched>, age: TimeInterval = 0, isCacheable: Bool = true) {
        let existingCount = results.value.count
        let newValue = fetchSequenceCount > 0 ? results.value.union(newResults) : newResults.union(results.value)
        let added = newValue.count - existingCount
        results.value = filter(newValue)
        let sequencing = age == 0 && added == batchSize && results.value.count < howMany && fetchSequenceCount < (howMany-(batchSize-1))/batchSize
        let interval = sequencing ? 1 : (age > 0 && age < fetchInterval) ? fetchInterval - age : fetchInterval
        if isCacheable, age == 0, !sequencing {
            cache(newValue)
        }
        if interval > 0 { // }, urlRequest != nil {
            if sequencing {
                fetchSequenceCount += 1
            } else {
                offset = 0
                fetchSequenceCount = 0
            }
            fetchTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { [weak self] timer in
                if (self?.fetchInterval ?? 0) > 0 || (self?.fetchSequenceCount ?? 0) > 0 {
                    self?.fetch()
                }
            })
        }
    }
    
    // MARK: - Cacheing
    
    // this is mostly because, during a demo, we're constantly re-launching the application
    // and there's no need to be refetching data that was just fetched
    // the real solution to this is to make the data persistent
    // (for example, in Core Data)
    
    private func fetchFromCache() -> Bool { // returns whether we were able to
        if fetchSequenceCount == 0, let key = cacheKey, let age = cacheAge {
            if age > 0, (fetchInterval == 0) || (age < fetchInterval) || urlRequest == nil, let data = cacheData {
                if let cachedResults = try? JSONDecoder().decode(Set<Fetched>.self, from: data) {
                    print("using \(Int(age))s old cache \(key)")
                    handleResults(cachedResults, age: age)
                    return true
                } else {
                    print("couldn't decode information from \(Int(age))s old cache \(cacheKey!)")
                }
            }
        }
        return false
    }
    
    private func cache(_ results: Set<Fetched>) {
        if let key = self.cacheKey, let data = try? JSONEncoder().encode(results) {
            print("caching \(key)") 
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    // MARK: - Utility
        
    static func authorizedURLRequest(query: String) -> URLRequest? {
        let PokeAPI = "https://pokeapi.co/api/v2/"
        if let url = URL(string: PokeAPI + query) {
            let request = URLRequest(url: url)
            return request
        }
        return nil
    }
}

// MARK: - Extensions

extension String {
    mutating func addPokeAPIArgument(_ value: Int? = nil, `default` defaultValue: Int = 0) {
        if value != nil, value != defaultValue {
            addPokeAPIArgument("\(value!)")
        }
    }
    
    mutating func addPokeAPIArgument(_ value: String?) {
        if value != nil {
            self += value!
        }
    }
}

