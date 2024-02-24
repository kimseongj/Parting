//
//  PartyListView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit
import SnapKit

class PartyListView: BaseView {
    let buttonTitleLabel: UILabel = {
        let label = UILabel()
         label.text = "기본순"
         label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
         return label
     }()
    
    lazy var sortingOptionButton: UIButton = {
       let button = UIButton()
        button.layer.backgroundColor = UIColor(red: 0.979, green: 0.979, blue: 0.979, alpha: 1).cgColor
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1).cgColor
        
        let bottomArrowImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "bottomArrow")
            return imageView
        }()
        
        button.addSubview(buttonTitleLabel)
        button.addSubview(bottomArrowImageView)
        
        buttonTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        
        bottomArrowImageView.snp.makeConstraints {
            $0.size.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(buttonTitleLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 1

        
        return button
    }()
    
    let noPartyListView = UIView()
    
    let noPartyListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noPartyIcon")
        return imageView
    }()
    
    let noPartyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 22)
        label.text = "근처에 파티가 없어요!"
        return label
    }()
    
    let recommendMakingPartyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.679, green: 0.679, blue: 0.679, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.text = "파티를 직접 만들어볼까요?"
        return label
    }()
    
    let makePartyButton: UIButton = {
        let button = UIButton()
        button.setTitle("개설하기", for: .normal)
        button.setTitleColor(UIColor(red: 0.969, green: 0.325, blue: 0.463, alpha: 1),
                             for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)

        return button
    }()
    
	let partyListTableView: UITableView = {
		let tableView = UITableView()
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
    
    lazy var footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        
        return view
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
	
	let addButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = AppColor.brand
		button.layer.cornerRadius = 27
		return button
	}()
	
	private let addImageView: UIImageView = {
		let config = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: Images.sfSymbol.plus, withConfiguration: config)
		let imageView = UIImageView(image: image)
		imageView.isUserInteractionEnabled = false
		imageView.tintColor = AppColor.white
		return imageView
	}()
	
	
	override func makeConfigures() {
        super.makeConfigures()
		self.backgroundColor = .white
		
        addSubview(sortingOptionButton)
		addSubview(partyListTableView)
		addSubview(addButton)
		addSubview(noPartyListView)
        
        addButton.addSubview(addImageView)
        
        noPartyListView.addSubview(noPartyLabel)
        noPartyListView.addSubview(noPartyListImageView)
        noPartyListView.addSubview(recommendMakingPartyLabel)
        noPartyListView.addSubview(makePartyButton)
		
        footerView.addSubview(activityIndicator)
        partyListTableView.tableFooterView = footerView
	}
	
	override func makeConstraints() {
        sortingOptionButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(30 )
        }
        
        noPartyListView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        noPartyListImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(170)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        noPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(noPartyListImageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview()
        }
        
        recommendMakingPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(noPartyLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        makePartyButton.snp.makeConstraints { make in
            make.top.equalTo(recommendMakingPartyLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
		partyListTableView.snp.makeConstraints { make in
            make.top.equalTo(sortingOptionButton.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
			make.bottom.equalToSuperview()
		}
		
		addButton.snp.makeConstraints { make in
			make.width.equalTo(55)
			make.height.equalTo(55)
			make.right.equalToSuperview().offset(-16)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16)
		}
		
		addImageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
	}
    
    func hidePartyListTableView() {
        partyListTableView.isHidden = true
        noPartyListView.isHidden = false
    }
    
    func showPartyListTableView() {
        partyListTableView.isHidden = false
        noPartyListView.isHidden = true
    }
}
