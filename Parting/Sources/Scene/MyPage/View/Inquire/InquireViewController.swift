//
//  InquireViewController.swift
//  Parting
//
//  Created by 이병현 on 2023/09/26.
//

import UIKit
import RxSwift
import RxCocoa

final class InquireViewController: BaseViewController<InquireView> {
    private var viewModel: InquireViewModel
    
    init(viewModel: InquireViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textViewPlaceHolder = "내용을 입력하세요"
    
    private let barImageTitleButton = BarImageTitleButton(imageName: Images.icon.back, title: "문의하기")
    
    private let emailInfoButtonValid = BehaviorRelay<Bool>(value: false)
    private let emailValid = BehaviorRelay<Bool>(value: false)
    private let inquireValid = BehaviorRelay<Bool>(value: false)
    private let totalValid = BehaviorRelay<Bool>(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.inquireTextView.delegate = self
        configureNavigationBar()
        bind()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = barImageTitleButton
    }
    
    private func bind() {
        rootView.inquireTextView
            .rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                owner.rootView.updateTextCountLabel(text: text)
            }
            .disposed(by: disposeBag)
        
        rootView.infoCheckButton
            .rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let currentValid = owner.emailInfoButtonValid.value
                owner.emailInfoButtonValid.accept(!currentValid)
            }
            .disposed(by: disposeBag)
        
        emailInfoButtonValid
            .withUnretained(self)
            .bind { owner, valid in
                owner.rootView.checkButtonValid(checkOn: valid)
            }
            .disposed(by: disposeBag)
        
        rootView.emailTextField
            .rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                if text.count > 5 {
                    owner.emailValid.accept(true)
                } else {
                    owner.emailValid.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        rootView.inquireTextView
            .rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                if text.count > 3 {
                    owner.inquireValid.accept(true)
                } else {
                    owner.inquireValid.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(self.emailValid, self.inquireValid, self.emailInfoButtonValid)
            .bind { [weak self] email, text, button in
                guard let self else { return }
                if email && text && button {
                    self.totalValid.accept(true)
                } else {
                    self.totalValid.accept(false)
                }
            }
            .disposed(by: disposeBag)
        
        totalValid.withUnretained(self)
            .bind { owner, valid in
                owner.rootView.finishButtonValid(valid: valid)
            }
            .disposed(by: disposeBag)
        
        barImageTitleButton.backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, tap in
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension InquireViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if rootView.inquireTextView.text == textViewPlaceHolder {
            rootView.inquireTextView.text = nil
            rootView.inquireTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if rootView.inquireTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            rootView.inquireTextView.text = textViewPlaceHolder
            rootView.inquireTextView.textColor = .lightGray
        }
    }
}
