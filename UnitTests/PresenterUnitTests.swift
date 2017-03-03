import XCTest
@testable import PresenterAndViewModelFun

// MARK: - MockDataLayer

class MockDataLayer: DataLayer {
    
    var lastSelectedCrementingNumber: CrementingNumber?
    
    var saveCallResult: CallResult<CrementingNumber> = .notCalled
    func save(_ crementingNumber: CrementingNumber) {
        saveCallResult = .called(with: crementingNumber)
    }
}

// MARK: MockPresenterView

class MockPresenterView: PresenterView {
    
    var updateCrementingViewCallResult: CallResult<String> = .notCalled
    func updateCrementingView(with valueLabelText: String) {
        updateCrementingViewCallResult = .called(with: valueLabelText)
    }
    
    var updateMessageLabelCallResult = CallResult<String>.notCalled
    func updateMessageLabel(with messageLabelText: String?) {
        updateMessageLabelCallResult = .called(with: messageLabelText)
    }
}

// MARK: - PresenterUnitTests

class PresenterUnitTests: XCTestCase {
    
    // MARK: - Stored Properties
    
    private var mockDataLayer = MockDataLayer()
    private var mockPresenterView = MockPresenterView()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockDataLayer = MockDataLayer()
        mockPresenterView = MockPresenterView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - UpdateCrementingView
    
    func testUpdatesCrementingViewWithDefaultTextWhenCrementingNumberIsNil() {
        mockDataLayer.lastSelectedCrementingNumber = nil
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.updateViews()
        
        let expected = CallResult.called(with: "###")
        let actual = mockPresenterView.updateCrementingViewCallResult
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUpdatesCrementingViewWithCrementingNumberValue() {
        let crementingNumberValue = 42
        
        mockDataLayer.lastSelectedCrementingNumber = CrementingNumber(
            value: crementingNumberValue,
            crementBy: 23
        )
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.updateViews()
        
        let expected = CallResult.called(with: "42")
        let actual = mockPresenterView.updateCrementingViewCallResult
        
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: - UpdateMessageLabel
    
    func testUpdatesMessageLabelWithNilWhenCrementingNumberNotInFibonacciSequence() {
        let crementingNumberValue = 9
        
        mockDataLayer.lastSelectedCrementingNumber = CrementingNumber(
            value: crementingNumberValue,
            crementBy: 89
        )
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.updateViews()
        
        let expected = CallResult<String>.called(with: nil)
        let actual = mockPresenterView.updateMessageLabelCallResult
        
        XCTAssertEqual(expected, actual)
    }
    
    func testUpdatesMessageLabelWithFibonacciMessageWhenCrementingNumberIsInFibonacciSequence() {
        let crementingNumberValue = 13
        
        mockDataLayer.lastSelectedCrementingNumber = CrementingNumber(
            value: crementingNumberValue,
            crementBy: 56
        )
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.updateViews()
        
        let expected = CallResult<String>.called(with: "Fibonacci!")
        let actual = mockPresenterView.updateMessageLabelCallResult
        
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: - CrementingViewDidTap
    
    func testSavesDecrementedValueToDataLayerOnCrementingViewDidTapDecrement() {
        let value = 87
        let crementedBy = 3
        let decrementedValue = 84 // value - crementedBy
        
        mockDataLayer.lastSelectedCrementingNumber = CrementingNumber(
            value: value,
            crementBy: crementedBy
        )
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.crementingViewDidTapDecrement()
        
        let decrementedCrementingNumber = CrementingNumber(
            value: decrementedValue, 
            crementBy: crementedBy
        )
        
        let expected = CallResult.called(with: decrementedCrementingNumber)
        let actual = mockDataLayer.saveCallResult
        
        XCTAssertEqual(expected, actual)
    }
    
    func testSavesIncrementedValueToDataLayerOnCrementingViewDidTapIncrement() {
        let value = 43
        let crementedBy = 7
        let incrementedValue = 50 // value + crementedBy
        
        mockDataLayer.lastSelectedCrementingNumber = CrementingNumber(
            value: value,
            crementBy: crementedBy
        )
        
        let presenter = Presenter(
            dataLayer: mockDataLayer,
            view: mockPresenterView
        )
        presenter.crementingViewDidTapIncrement()
        
        let incrementedCrementingNumber = CrementingNumber(
            value: incrementedValue,
            crementBy: crementedBy
        )
        
        let expected = CallResult.called(with: incrementedCrementingNumber)
        let actual = mockDataLayer.saveCallResult
        
        XCTAssertEqual(expected, actual)
    }
}
