//
//  JoinViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/15.
//

import UIKit
import RxSwift
import AuthenticationServices

class JoinViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: JoinViewModel
    private let mainView = JoinView()
    
    override func loadView() {
        self.view = mainView
    }
    
    init(viewModel: JoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundUI()
    }
    
    private func backgroundUI() {
        mainView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
    
    private func navigationUI() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        mainView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
    }
    
    @objc func appleLoginButtonClicked() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

extension JoinViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let idToken = credential.identityToken else { return }
            guard let tokeStr = String(data: idToken, encoding: .utf8) else { return }
            print(tokeStr)
            guard let code = credential.authorizationCode else { return }
            guard let codeStr = String(data: code, encoding: .utf8) else { return }
            print(codeStr)
            
            let user = credential.user
            print(user)
            self.viewModel.input.viewChangeTrigger.onNext(())
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}
