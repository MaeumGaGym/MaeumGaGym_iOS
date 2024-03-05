import XCTest
import MGCameraKit

final class MGCameraUnitTest: XCTestCase {
    public var cameraView: MGCamera!

    override class func setUp() {
        super.setUp()
        
        cameraView = MGCamera(frame: CGRect(x: 0, y: 0, width: 430, height: 573)).then {
            $0.setAspectRatio(.full)
            $0.setBackgroundColor(.white)
            $0.setFlashMode(.off)
            $0.setCameraPosition(.back)
        }
    }
    
    public func test_카메라를_실행했을_경우() {
        
    }
    
    public func test_카메라를_멈추었을_경우() {
        
    }
    
    public func test_카메라의_비율을_square로_바꾸었을_경우() {
        
    }
    
    public func test_카메라의_비율을_full로_바꾸었을_경우() {
        
    }
    
    public func test_카메라의_비율을_portrait로_바꾸었을_경우() {
        
    }
    
    public func test_카메라의_비율을_landscape로_바꾸었을_경우() {
        
    }
    
    public func test_카메라의_플레쉬를_켰을_경우() {
        
    }
    
    public func test_카메라의_방향을_정면으로_정한_경우() {
        
    }
    
    public func test_카메라의_방향을_후면으로_정한_경우() {
        
    }
    
    public func test_카메라의_이미지를_성공적으로_저장한_경우() {
        
    }
    
    public func test_카메라의_캡처가_될_경우() {
        
    }

    override class func tearDown() {
        super.tearDown()
        
        cameraView = nil
    }
}
