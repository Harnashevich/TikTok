//
//  RecordButton.swift
//  TikTok
//
//  Created by Andrei Harnashevich on 29.02.24.
//

import UIKit

class RecordButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = nil
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.5
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = height/2
    }

    enum State {
        case recording
        case notRecording
    }

    public func toggle(for state: State) {
        switch state {
        case .recording:
            backgroundColor = .systemRed
        case .notRecording:
            backgroundColor = nil
        }
    }

}

