//
//  StarsView.swift
//  SwiftyStars
//
//  Created by Hussein Jaber on 15/10/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

public class StarsView: UIView {
    
    /// The total number of stars in the view. Default value is 5
    @IBInspectable public var numberOfStars: Int = 5 {
        didSet {
            var arr = [UIImageView]()
            for _ in 0..<numberOfStars {
                arr.append(emptyStarImageView)
            }
            stackView.subviews.forEach({ $0.removeFromSuperview() })
            imageViews.removeAll()
            imageViews.append(contentsOf: arr)
            imageViews.forEach({ stackView.addArrangedSubview($0) })
        }
    }
    
    /// Set the current rating, default is 3.
    public var currentRating = 3 {
        didSet {
            updateCurrentStars(oldValue: oldValue)
        }
    }
    
    /// Indicates if a haptic feedback should be generated when tapping a star. Default is true
    @IBInspectable public var generateHapticFeedbackOnSelection: Bool = true
    
    /// Private: The selected rating,
    private(set) var selectedRating: Int = 1 {
        didSet {
            if selectedRating != oldValue {
                if generateHapticFeedbackOnSelection {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                didChangeSelection?(selectedRating)
            }
        }
    }
    
    /// The color of the star
    @IBInspectable public var starColor: UIColor? {
        didSet {
            imageViews.forEach({ $0.tintColor = starColor })
        }
    }
    
    /// Closure indicating that the selection did change, returns the value
    /// of the selection
    public var didChangeSelection: ((Int) -> Void)?
    
    
    /// Used to adjust the spacing distance between stars
    @IBInspectable public var starsSpacing: NSNumber? {
        didSet {
            stackView.spacing = CGFloat(starsSpacing!.floatValue)
        }
    }
    
    /// StackView that holds imageviews
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    /// Image view initiated with empty stars images
    private var emptyStarImageView: UIImageView {
        let imgView = UIImageView()
        imgView.image = emptyImage
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }
    
    /// The image of the filled star
    open var filledImage: UIImage {
        UIImage(named: "starFilledLarge", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
    }
    
    /// The image of the empty star
    open var emptyImage: UIImage {
        UIImage(named: "starEmptyLarge", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
    }
    
    /// Initial image views
    private lazy var imageViews: [UIImageView] = {
        var arr = [UIImageView]()
        for i in 0..<numberOfStars {
            arr.append(emptyStarImageView)
        }
        return arr
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        imageViews.forEach({ stackView.addArrangedSubview($0) })
    }
    
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleTouches(touches)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        handleTouches(touches)
    }
    
    private func handleTouches(_ touches: Set<UITouch>) {
        guard let firstTouch = touches.first
            else { return }
        let location = firstTouch.location(in: stackView)
        imageViews.forEach {
            if $0.frame.contains(location) {
                guard let index = imageViews.firstIndex(of: $0) else { return }
                imageViews.forEach({ $0.image = emptyImage })
                for i in 0...index {
                    imageViews[i].image = filledImage
                }
                selectedRating = index + 1
            }
        }
    }
    
    private func updateCurrentStars(oldValue: Int) {
        guard currentRating > 1, currentRating < numberOfStars
            else { currentRating = oldValue; return }
        imageViews.forEach({ $0.image = emptyImage })
        for i in 0..<currentRating {
            imageViews[i].image = filledImage
        }
    }
}
