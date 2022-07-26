//
//  InternetConnection.swift
//  MiniFacebookCloneApp
//
//  Created by Jhansi Ch on 25/07/22.
//

import Foundation
import Network

class NetworkMonitor{
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectiontype : ConnetionType = .unknown
    
    enum ConnetionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }

    private init()
    {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
        self?.isConnected = path.status == .satisfied
            self?.getConnectionType(_path: path)
        }
        
    }
    public func stopMonitoring(){
        monitor.cancel()
    }
    private func getConnectionType(_path : NWPath){
        if _path.usesInterfaceType(.wifi){
            connectiontype = .wifi
        }
        if _path.usesInterfaceType(.cellular){
            connectiontype = .cellular
        }
        if _path.usesInterfaceType(.wiredEthernet){
            connectiontype = .ethernet
        }
        else{
            connectiontype = .unknown
        }

    }
}

