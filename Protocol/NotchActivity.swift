protocol NotchActivity {
    static var timeToDie: TimeInterval { get }
    var disapearAfterTimer: Timer { get }
    static var supportedFrameSizes: [ActivitySize : CGSize] { get }
    var frameSize: CGSize { get set }
    
    static func dismiss(_ reason: ActivityDismissalReason)
}