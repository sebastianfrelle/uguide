import EstimoteProximitySDK

protocol ProximityZoneDelegate: class {
    func didEnterZone(identifier: String)
    func didExitZone(identifier: String)
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
        
        self.proximityObserver = EPXProximityObserver(credentials: EPXCloudCredentials(appID: "uguide-0tg", appToken: "3366bcb26dba5d30e5846bce426837be")) { error in
            fatalError("failed to instantiate proximity observer with error: \(error)")
        }
        
        self.zones = [ProximityZone]()
        
        self.beacons = beacons
        for beacon in self.beacons {
            let zone = ProximityZone.create(for: beacon, withinMeters: 3)
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
    func didEnterZone(identifier: String) {
        print("Did enter zone of beacon w/identifier \(identifier)")
    }
    
    func didExitZone(identifier: String) {
        print("Did exit zone of beacon w/identifier \(identifier)")
    }
}

class ProximityZone {
    typealias ZoneActionHandler = (EPXDeviceAttachment) -> Void
    
    static func create(for beacon: Beacon, withinMeters range: Double) -> ProximityZone {
        let zone = EPXProximityZone(range: EPXProximityRange(desiredMeanTriggerDistance: range)!,
                                    attachmentKey: "identifier",
                                    attachmentValue: beacon.identifier)
        
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
            guard let identifier = attachment.payload["identifier"] as? String else {
                fatalError("attachment payload (\(attachment.payload)) did not have key 'identifier'")
            }
            
            self.delegate?.didEnterZone(identifier: identifier)
        }
    }
    
    private func onExitHandler() -> ZoneActionHandler {
        return { attachment in
            guard let identifier = attachment.payload["identifier"] as? String else {
                fatalError("attachment payload (\(attachment.payload)) did not have key 'identifier'")
            }
            
            self.delegate?.didExitZone(identifier: identifier)
        }
    }
}

typealias Serialized = [String: Any]

protocol Serializable {
    var serialized: Serialized { get }
    
    init(dictionary: Serialized)
}

struct Beacon {
    var identifier: String
}

extension Beacon: Serializable {
    var serialized: Serialized {
        return [
            "identifier": self.identifier
        ]
    }
    
    init(dictionary: Serialized) {
        guard let identifier = dictionary["identifier"] as? String else {
            fatalError("Could not instantiate beacon from dictionary \(dictionary)")
        }
        
        self.identifier = identifier
    }
}
