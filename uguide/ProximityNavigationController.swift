import EstimoteProximitySDK

protocol ProximityZoneDelegate: class {
    func didEnterZone(location: String)
    func didExitZone(location: String)
}

class ProximityNavigationController {
    class func setup(for beacons: [Beacon]) -> ProximityNavigationController {
        let proxNavCtrl = ProximityNavigationController(beacons: beacons)
        proxNavCtrl.startListening()
        
        return proxNavCtrl
    }
    
    enum State {
        case started, stopped
    }
    
    var beacons: [Beacon]
    var zones: [ProximityZone]
    
    var proximityObserver: EPXProximityObserver
    
    var state: State
    
    init(beacons: [Beacon]) {
        self.state = .stopped
        
        self.proximityObserver = EPXProximityObserver(
            credentials: EPXCloudCredentials(
                appID: "uguide-0tg",
                appToken: "3366bcb26dba5d30e5846bce426837be"),
            errorBlock: { error in fatalError("failed to instantiate proximity observer with error: \(error)") })
        
        self.zones = [ProximityZone]()
        
        self.beacons = beacons
        for beacon in self.beacons {
            let zone = ProximityZone.create(for: beacon, withinMeters: 2)
            zone.delegate = self
            
            self.zones.append(zone)
        }
    }
    
    func startListening() {
        proximityObserver.startObserving(self.zones.map { $0.zone })
        self.state = .started
    }
    
    func stopListening() {
        proximityObserver.stopObservingZones()
        self.state = .stopped
    }
}

extension ProximityNavigationController: ProximityZoneDelegate {
    func didEnterZone(location: String) {
        print("Did enter zone of beacon w/location \(location)")
        for i in 0..<self.beacons.count {
            if self.beacons[i].location != location {
                continue
            }
            
            self.beacons[i].activate()
            return
        }
        
        print("did not find beacon with location \(location)")
    }
    
    func didExitZone(location: String) {
        print("Did exit zone of beacon w/location \(location)")
        for i in 0..<self.beacons.count {
            if self.beacons[i].location != location {
                continue
            }
            
            self.beacons[i].deactivate()
            return
        }
        
        print("did not find beacon with location \(location)")
    }
}

class ProximityZone {
    typealias ZoneActionHandler = (EPXDeviceAttachment) -> Void
    
    static func create(for beacon: Beacon, withinMeters range: Double) -> ProximityZone {
        let zone = EPXProximityZone(range: EPXProximityRange(desiredMeanTriggerDistance: range)!,
                                    attachmentKey: "location",
                                    attachmentValue: beacon.location)
        
        return ProximityZone(zone: zone)
    }
    
    var zone: EPXProximityZone
    
    weak var delegate: ProximityZoneDelegate?
    
    init(zone: EPXProximityZone) {
        self.zone = zone
        
        self.zone.onEnterAction = onEnterHandler()
        self.zone.onExitAction = onExitHandler()
    }
    
    private func onEnterHandler() -> ZoneActionHandler {
        return { attachment in
            guard let location = attachment.payload["location"] as? String else {
                fatalError("attachment payload (\(attachment.payload)) did not have key 'location'")
            }
            
            self.delegate?.didEnterZone(location: location)
        }
    }
    
    private func onExitHandler() -> ZoneActionHandler {
        return { attachment in
            guard let location = attachment.payload["location"] as? String else {
                fatalError("attachment payload (\(attachment.payload)) did not have key 'location'")
            }
            
            self.delegate?.didExitZone(location: location)
        }
    }
}

typealias Serialized = [String: Any]

protocol Serializable {
    var serialized: Serialized { get }
    
    init(dictionary: Serialized)
}

struct Beacon {
    enum State {
        case activated, deactivated
    }
    
    var state: State = .deactivated
    
    var identifier, location: String
    var view: BeaconView?
    
    mutating func activate() {
        self.view?.activate()
        self.state = .activated
    }
    
    mutating func deactivate() {
        self.view?.deactivate()
        self.state = .deactivated
    }
}

extension Beacon: Serializable {
    var serialized: Serialized {
        return [
            "identifier": self.identifier,
            "location": self.location
        ]
    }
    
    init(dictionary: Serialized) {
        guard let identifier = dictionary["identifier"] as? String,
            let location = dictionary["location"] as? String else {
            fatalError("Could not instantiate beacon from dictionary \(dictionary)")
        }
        
        self.identifier = identifier
        self.location = location
    }
}
