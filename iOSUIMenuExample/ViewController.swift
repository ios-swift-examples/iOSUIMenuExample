//
//  ViewController.swift
//  iOSUIMenuExample
//
//  Created by 영준 이 on 2023/12/29.
//

import UIKit

class MainViewController: UIViewController {
    
    var menu: UIEditMenuInteraction!
    var button: UIButton = {
        var value = UIButton.init()
        value.translatesAutoresizingMaskIntoConstraints = false
        value.widthAnchor.constraint(equalToConstant: 100).isActive = true
        value.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        value.setTitle("Show menu", for: .normal)
        value.setTitleColor(.orange, for: .normal)
        
        return value
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupHandlers()
    
        view.backgroundColor = .white
    }
    
    func setupLayouts() {
        let centerXAnchor = self.view.centerXAnchor
        let centerYAnchor = self.view.centerYAnchor

        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupHandlers() {
        menu = .init(delegate: self)
        
        button.addInteraction(menu)
        button.addAction(.init(handler: onShowMenuFromButton), for: .touchUpInside)
    }
    
    lazy var onShowMenuFromButton: UIActionHandler = { [weak self](act) in
        print("onShowMenuFromButton");
        
        guard let self = self, let fromView = act.sender as? UIView else {
            return
        }
        
        let menuConfig = UIEditMenuConfiguration.init(identifier: nil, sourcePoint: fromView.center)
        
        menu.presentEditMenu(with: menuConfig)
    }
}

extension MainViewController: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
        let actions: [UIAction] = [.init(title: "Copy") { act in
            //
        }, .init(title: "Remove") { act in
            //
        }, .init(title: "Clone") { act in
            //
        }]
                                         
        let submenu: UIMenu = .init(title: "menu",
                                 children: actions)
        
        let menu: UIMenu = .init(title: "menu",
                                 children: [submenu])
        
        return menu
    }
    
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, targetRectFor configuration: UIEditMenuConfiguration) -> CGRect {
        let rect = self.button.frame(in: self.view) ?? .zero
        
        return .init(origin: .init(x: button.frame.width / 2, y: 0),
                     size: .init(width: .zero, height: button.frame.height))
    }
}
