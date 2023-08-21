//
//  JoinViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class JoinViewController: BaseViewController<JoinView> {
	private let viewModel: JoinViewModel
//    private let disposeBag = DisposeBag()
    
    init(viewModel: JoinViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("JoinVC 메모리 해제")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundUI()
    }
    
    private func backgroundUI() {
        rootView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
    
    private func navigationUI() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        rootView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        rootView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonClicked), for: .touchUpInside)
    }
    
    @objc func kakaoLoginButtonClicked() {
        if(AuthApi.hasToken()) { // 토큰이 있는 경우
            UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        //MARK: - 로그인 필요함
                    } else {
                        //MARK: - 기타 에러
                    }
                } else {
                    //MARK: - 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    // 이미 토큰을 발급받은 상태이기 때문에, 홈화면으로 이동하거나 해당하는 화면에 대한 분기처리
                    guard let alreadyToken = accessTokenInfo else { return }
                    print("이미 토큰을 발급받았습니다. \(alreadyToken)")
                    self.viewModel.input.viewChangeTrigger.onNext(())
                }
            }
        } else {
            //MARK: - 로그인 필요 (토큰이 없는 경우)
            if(UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("loginWithKakaoAccount() success.")
                        guard let loginToken = oauthToken else { return }
                        print("\(loginToken.accessToken) 이건 로그인 토큰이야 💛💛")
                        self.viewModel.input.viewChangeTrigger.onNext(())

                    }
                }
            }
        }
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
			viewModel.input.viewChangeTrigger.onNext(())
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}
