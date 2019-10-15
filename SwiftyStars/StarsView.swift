//
//  StarsView.swift
//  SwiftyStars
//
//  Created by Hussein Jaber on 15/10/19.
//  Copyright © 2019 Hussein Jaber. All rights reserved.
//

import UIKit

final class StarsView: UIView {
    
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
    
    public var currentRating = 3 {
        didSet {
            updateCurrentStars(oldValue: oldValue)
        }
    }
    
    private(set) var selectedRating: Int = 1 {
        didSet {
            if selectedRating != oldValue {
                UISelectionFeedbackGenerator().selectionChanged()
                didChangeSelection?(selectedRating)
            }
        }
    }
    
    @IBInspectable public var starColor: UIColor? {
        didSet {
            imageViews.forEach({ $0.tintColor = starColor })
        }
    }
    
    public var didChangeSelection: ((Int) -> Void)?
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private var emptyStarImageView: UIImageView {
        let imgView = UIImageView()
        imgView.image = emptyImage
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }
    
    private var filledImage: UIImage {
        UIImage(named: "starFilledLarge", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
    }
    
    private var emptyImage: UIImage {
        UIImage(named: "starEmptyLarge", in: Bundle(for: Self.self), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
    }
    
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
    
    override func awakeFromNib() {
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
