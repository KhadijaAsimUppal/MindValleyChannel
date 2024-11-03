//
//  NetworkReachability.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import Foundation
import Network

class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    @Published private(set) var isConnected: Bool = true
    
    private init() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }
}
