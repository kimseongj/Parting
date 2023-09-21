//
//  UserAgreementView.swift
//  Parting
//
//  Created by 박시현 on 2023/09/20.
//

import UIKit
import SnapKit

enum ButtonType {
    case serviceAgreement
    case personalInfoAgreement
    case nextButton
}

class UserAgreementView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userAgreementTitleLabel: UILabel = {
        let label = UILabel()
        label.text = """
이용 약관에
동의해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let serviceConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용 약관"
        label.font = AppFont.Medium.of(size: 15)
        label.textColor = AppColor.gray700
        label.sizeToFit()
        return label
    }()
    
    let serviceConditionTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 10
        view.textColor = AppColor.gray500
        view.font = AppFont.Regular.of(size: 13)
        view.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.text = """
제1조(목적)

이 약관은 팟팅 (이하 '회사' 라고 합니다)가 제공하는 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.


제2조(정의)

이 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다.

'서비스'라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 '이용자'가 이용할 수 있는 회사가 제공하는 제반 서비스를 의미합니다.
'이용자'란 이 약관에 따라 회사가 제공하는 서비스를 받는 '개인회원' , '기업회원' 및 '비회원'을 말합니다.
'개인회원'은 회사에 개인정보를 제공하여 회원등록을 한 사람으로, 회사로부터 지속적으로 정보를 제공받고 '회사'가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
'기업회원'은 회사에 기업정보 및 개인정보를 제공하여 회원등록을 한 사람으로, 회사로부터 지속적으로 정보를 제공받고 회사가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.
'비회원'은 회원가입 없이 회사가 제공하는 서비스를 이용하는 자를 말합니다.
'아이디(ID)'라 함은 회원의 식별과 서비스이용을 위하여 회원이 정하고 회사가 승인하는 문자 또는 문자와 숫자의 조합을 의미합니다.
'비밀번호'라 함은 회원이 부여받은 아이디와 일치되는 회원임을 확인하고 비밀의 보호를 위해 회원 자신이 정한 문자(특수문자 포함)와 숫자의 조합을 의미합니다.


제3조(약관 외 준칙)

이 약관에서 정하지 아니한 사항에 대해서는 법령 또는 회사가 정한 서비스의 개별약관, 운영정책 및 규칙 등(이하 세부지침)의 규정에 따릅니다. 또한 본 약관과 세부지침이 충돌할 경우에는 세부지침에 따릅니다.

제4조(약관의 효력과 변경)

이 약관은 팟팅(이)가 제공하는 모든 인터넷서비스에 게시하여 공시합니다. 회사는 '전자상거래등에서의 소비자보호에 관한 법률(이하 '전자상거래법'이라 함)', '약관의 규제에 관한 법률(이하' 약관규제법'이라 함)', '정보통신망 이용촉진 및 정보보호 등에 관한 법률(이하 '정보통신망법'이라 함)' 등 본 서비스와 관련된 법령에 위배되지 않는 범위에서 이 약관을 변경할 수 있으며, 회사는 약관이 변경되는 경우에 변경된 약관의 내용과 시행일을 정하여, 그 시행일로부터 최소 7일 (이용자에게 불리하거나 중대한 사항의 변경은 30일) 이전부터 시행일 후 상당한 기간 동안 공지하고, 기존 이용자에게는 변경된 약관, 적용일자 및 변경사유(변경될 내용 중 중요사항에 대한 설명을 포함)를 별도의 전자적 수단(전자우편, 문자메시지, 서비스 내 전자쪽지발송, 알림 메시지를 띄우는 등의 방법)으로 개별 통지합니다. 변경된 약관은 공지하거나 통지한 시행일로부터 효력이 발생합니다.
회사가 제1항에 따라 개정약관을 공지 또는 통지하는 경우 '변경에 동의하지 아니한 경우 공지일 또는 통지를 받은 날로부터 7일(이용자에게 불리하거나 중대한 사항의 변경인 경우에는 30일) 내에 계약을 해지할 수 있으며, 계약해지의 의사표시를 하지 아니한 경우에는 변경에 동의한 것으로 본다.' 라는 취지의 내용을 함께 통지합니다.
이용자가 제2항의 공지일 또는 통지를 받은 날로부터 7일(또는 이용자에게 불리하거나 중대한 사항의 변경인 경우에는 30일)내에 변경된 약관에 대해 거절의 의사를 표시하지 않았을 때에는 본 약관의 변경에 동의한 것으로 간주합니다.


제5조(이용자에 대한 통지)

회사는 이 약관에 별도 규정이 없는 한 이용자에게 전자우편, 문자메시지(SMS), 전자쪽지, 푸쉬(Push)알림 등의 전자적 수단을 이용하여 통지할 수 있습니다.
회사는 이용자 전체에 대한 통지의 경우 7일 이상 회사가 운영하는 웹사이트 내의 게시판에 게시함으로써 제1항의 통지에 갈음할 수 있습니다. 다만, 이용자 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 제1항의 개별 통지를 합니다.
회사는 이용자의 연락처 미기재, 변경 후 미수정, 오기재 등으로 인하여 개별 통지가 어려운 경우에 한하여 전항의 공지를 함으로써 개별 통지를 한 것으로 간주합니다


제6조(이용계약의 체결)

이용계약은 다음의 경우에 체결됩니다.
이용자가 회원으로 가입하고자 하는 경우 이용자가 약관의 내용에 대하여 동의를 한 다음 회원가입신청을 하고 회사가 이러한 신청에 대하여 승낙한 때
이용자가 회원 가입 없이 이용할 수 있는 서비스에 대하여 회원 가입의 신청없이 서비스를 이용하고자 하는 경우에는 회사 서비스 이용을 위해 결제하는 때
이용자가 회원가입 없이 이용할 수 있는 서비스에 대하여 회원가입의 신청없이 무료 서비스를 이용하고자 하는 경우에는 그 무료 서비스와 관련된 사항의 저장 등 부가서비스를 이용하면서 위 1호 및 2호의 절차를 진행한 때


제7조(회원가입에 대한 승낙)

회사는 이용계약에 대한 요청이 있을 때 서비스 이용을 승낙함을 원칙으로 합니다.
제1항에 따른 신청에 있어 회사는 서비스 제공에 필요한 경우 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.
회사는 서비스 관련 설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.
제3항에 따라 서비스 이용을 승낙하지 아니하거나 유보한 경우, 회사는 원칙적으로 이를 서비스 이용 신청자에게 알리도록 합니다. 단, 회사의 귀책사유 없이 이용자에게 알릴 수 없는 경우에는 예외로 합니다.
이용계약의 성립 시기는 제6조 제1호의 경우에는 회사가 가입완료를 신청절차 상에서 표시한 시점, 제6조 제2호의 경우에는 결제가 완료되었다는 표시가 된 시점으로 합니다.
회사는 회원에 대해 회사정책에 따라 등급별로 구분하여 이용시간, 이용횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.
회사는 회원에 대하여 '영화및비디오물의진흥에관한법률' 및 '청소년보호법' 등에 따른 등급 및 연령 준수를 위하여 이용제한이나 등급별 제한을 둘 수 있습니다.


제8조(회원정보의 변경)

회원은 개인정보관리화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 실명, 아이디 등은 수정이 불가능합니다.
회원은 회원가입신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 회사에 대하여 그 변경사항을 알려야 합니다.
제2항의 변경사항을 회사에 알리지 않아 발생한 불이익에 대하여는 회원에게 책임이 있습니다.


제9조(회원정보의 관리 및 보호)

회원의 아이디(ID)와 비밀번호에 관한 관리책임은 회원에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.
회사는 회원의 아이디(ID)가 개인정보 유출 우려가 있거나, 반사회적 또는 공서양속에 어긋나거나, 회사 또는 서비스의 운영자로 오인할 우려가 있는 경우, 해당 아이디(ID)의 이용을 제한할 수 있습니다.
회원은 아이디(ID) 및 비밀번호가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 회사에 통지하고 안내에 따라야 합니다.
제3항의 경우 해당 회원이 회사에 그 사실을 통지하지 않거나, 통지하였으나 회사의 안내에 따르지 않아 발생한 불이익에 대하여 회사는 책임지지 않습니다.


제10조(회사의 의무)

회사는 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 이를 지체 없이 수리 또는 복구하며, 다음 각 호의 사유 발생 시 부득이한 경우 예고 없이 서비스의 전부 또는 일부의 제공을 일시 중지할 수 있습니다. 이 경우 그 사유 및 중지 기간 등을 이용자에게 지체 없이 사후 공지합니다.
시스템의 긴급점검, 증설, 교체, 시설의 보수 또는 공사를 하기 위하여 필요한 경우
새로운 서비스를 제공하기 위하여 시스템교체가 필요하다고 판단되는 경우
시스템 또는 기타 서비스 설비의 장애, 유무선 Network 장애 등으로 정상적인 서비스 제공이 불가능할 경우
국가비상사태, 정전, 불가항력적 사유로 인한 경우
회사는 이용계약의 체결, 계약사항의 변경 및 해지 등 이용자와의 계약관련 절차 및 내용 등에 있어 이용자에게 편의를 제공하도록 노력합니다.


제11조(개인정보보호)

회사는 이용자들의 개인정보를 중요시하며, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 개인정보보호법 등 관련 법규를 준수하기 위해 노력합니다. 회사는 개인정보보호정책을 통하여 이용자가 제공하는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다
회사는 최종 사용일로부터 연속하여 1년 동안 서비스 사용 이력이 없는 경우 '개인정보보호법' 및 같은 법 시행령의 규정에 따라 이용자정보를 다른 이용자의 개인정보와 분리하여 별도로 저장 및 관리할 수 있습니다. 이때 분리 저장된 이용자의 개인정보는 이용자가 회원탈퇴신청 또는 개인정보삭제 요청을 할때까지 보관됩니다.
회사가 이용자의 개인정보의 보호 및 사용에 대해서 관련 법규 및 회사의 개인정보처리방침을 적용합니다. 다만, 회사에서 운영하는 웹 사이트 등에서 링크된 외부 웹페이지에서는 회사의 개인정보처리방침이 적용되지 않습니다


제12조(이용자의 의무)

이용자는 이용자가입을 통해 이용신청을 하는 경우 사실에 근거하여 신청서를 작성해야 합니다. 이용자가 허위, 또는 타인의 정보를 등록한 경우 회사에 대하여 일체의 권리를 주장할 수 없으며, 회사는 이로 인하여 발생한 손해에 대하여 책임을 부담하지 않습니다.
이용자는 본 약관에서 규정하는 사항과 기타 회사가 정한 제반 규정, 회사가 공지하는 사항을 준수하여야 합니다.  또한 이용자는 회사의 업무를 방해하는 행위 및 회사의 명예를 훼손하는 행위를 하여서는 안 됩니다.
이용자는 주소, 연락처, 전자우편 주소 등 회원정보가 변경된 경우 즉시 온라인을 통해 이를 수정해야 합니다. 이 때 변경된 정보를 수정하지 않거나 수정이 지연되어 발생하는 책임은 이용자가 지게 됩니다.
이용자는 이용자에게 부여된 아이디와 비밀번호를 직접 관리해야 합니다. 이용자의 관리 소홀로 발생한 문제는 회사가 책임을 부담하지 않습니다.
이용자가 아이디, 닉네임, 기타 서비스 내에서 사용되는 명칭 등을 선정할 때에는 다음 각 호에 해당하는 행위를 해서는 안 됩니다.
회사가 제공하는 서비스의 공식 운영자를 사칭하거나 이와 유사한 명칭을 사용하여 다른 이용자에게 혼란을 주는 행위
선정적이고 음란한 내용이 포함된 명칭을 사용하는 행위
제3자의 상표권, 저작권 등 권리를 침해할 가능성이 있는 명칭을 사용하는 행위
제3자의 명예를 훼손하거나, 그 업무를 방해할 가능성이 있는 명칭을 사용하는 행위
기타 반사회적이고 관계법령에 저촉되는 내용이 포함된 명칭을 사용하는 행위
이용자는 회사의 명시적 동의가 없는 한 서비스 이용 권한, 기타 이용 계약상의 지위에 대하여 매도, 증여, 담보제공 등 처분행위를 할 수 없습니다.
본 조와 관련하여 서비스 이용에 있어 주의사항 등 그 밖의 자세한 내용은 운영정책으로 정하며, 이용자가 서비스 이용약관 및 운영정책을 위반하는 경우 서비스 이용제한, 민형사상의 책임 등 불이익이 발생할 수 있습니다.


제13조(서비스의 제공)

회사의 서비스는 연중무휴, 1일 24시간 제공을 원칙으로 합니다. 다만 회사 시스템의 유지 보수를 위한 점검, 통신장비의 교체 등 특별한 사유가 있는 경우 서비스의 전부 또는 일부에 대하여 일시적인 제공 중단이 발생할 수 있습니다.
회사가 제공하는 개별 서비스에 대한 구체적인 안내사항은 개별 서비스 화면에서 확인할 수 있습니다.
회사가 제공하는 서비스의 내용은 다음과 같습니다
일회성 모임 매칭 서비스


제14조(서비스의 제한 등)

회사는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 부득이한 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다.
무료서비스는 전항의 규정에도 불구하고, 회사의 운영정책 등의 사유로 서비스의 전부 또는 일부가 제한되거나 중지될 수 있으며, 유료로 전환될 수 있습니다.
회사는 서비스의 이용을 제한하거나 정지하는 때에는 그 사유 및 제한기간, 예정 일시 등을 지체없이 이용자에게 알립니다.
회사는 사전에 결제정보를 입력 받고, 무료로 제공중인 서비스를 유료로 전환할 경우, 그 사유와 유료 전환 예정 일시를 통지하고 유료 전환에 대한 이용자의 동의를 받습니다.


제15조(서비스의 해제·해지 및 탈퇴 절차)

이용자가 이용 계약을 해지하고자 할 때는 언제든지 홈페이지 상의 이용자 탈퇴 신청을 통해 이용계약 해지를 요청할 수 있습니다. 단, 신규가입 후 일정 시간 동안 서비스 부정이용 방지 등의 사유로 즉시 탈퇴가 제한될 수 있습니다.
회사는 이용자가 본 약관에서 정한 이용자의 의무를 위반한 경우 등 비정상적인 이용 또는 부당한 이용과 이용자 금지프로그램 사용하는 경우 또는 타인의 명예를 훼손하거나 모욕하는 방송과 게시물을 작성한 경우 이러한 행위를 금지하거나 삭제를 요청하였음에도 불구하고 최초의 금지 또는 삭제 요청을 포함하여 2회 이상 누적되는 경우 이용자에게 통지하고, 계약을 해지할 수 있습니다.
회사는 이용자의 청약철회, 해제 또는 해지의 의사표시를 수신한 후 그 사실을 이용자에게 회신합니다. 회신은 이용자가 회사에 대하여 통지한 방법 중 하나에 의하고, 이용자가 회사에 대하여 통지한 연락처가 존재하지 않는 경우에는 회신하지 않을 수 있습니다.


제16조(손해배상)

회사 또는 이용자는 상대방의 귀책에 따라 손해가 발생하는 경우 손해배상을 청구할 수 있습니다. 다만, 회사는 무료서비스의 장애, 제공 중단, 보관된 자료 멸실 또는 삭제, 변조 등으로 인한 손해에 대하여는 배상책임을 부담하지 않습니다.
회사가 제공하는 서비스의 이용과 관련하여 회사의 운영정책 및 개인 정보 보호정책, 기타 서비스별 이용약관에서 정하는 내용에 위반하지 않는 한 회사는 어떠한 손해에 대하여도 책임을 부담하지 않습니다.


제17조(면책사항)

회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임을 지지 않습니다.
회사는 이용자의 귀책사유로 인한 서비스 이용장애에 대하여 책임을 지지 지 않습니다.
회사는 이용자가 서비스를 이용하며 기대하는 수익을 얻지 못한 것에 대하여 책임 지지 않으며 서비스를 통하여 얻은 자료로 인한 손해 등에 대하여도 책임을 지지 않습니다.
회사는 이용자가 웹페이지에 게재한 내용의 신뢰도, 정확성 등 내용에 대해서는 책임지지 않으며, 이용자 상호간 또는 이용자와 제3자 상호간 서비스를 매개로 발생한 분쟁에 개입하지 않습니다.


제18조(권리의 귀속)

회사가 제공하는 서비스에 대한 저작권 등 지식재산권은 회사에 귀속 됩니다.
회사는 서비스와 관련하여 이용자에게 회사가 정한 조건 따라 회사가 제공하는 서비스를 이용할 수 있는 권한만을 부여하며, 이용자는 이를 양도, 판매, 담보제공 하는 등 처분행위를 할 수 없습니다.


제19조(관할법원 및 준거법)

서비스와 관련하여 분쟁이 발생한 경우 관할법원은 민사소송법에 따른 관할법원으로 정하며, 준거법은 대한민국의 법령을 적용합니다.

부칙

제1조(시행일)

본 약관은 2023.09.18부터 시행됩니다.
"""
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let serviceAgreeButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = AppColor.gray200.cgColor
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    let serviceAgreeButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "이용약관 동의(필수)"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    let serviceButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리 방침"
        label.font = AppFont.Medium.of(size: 15)
        label.textColor = AppColor.gray700
        label.sizeToFit()
        return label
    }()
    
    let personalInfoTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 10
        view.textColor = AppColor.gray500
        view.font = AppFont.Regular.of(size: 13)
        view.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.text = """
< 팟팅 >('앱'이하 '팟팅')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.

○ 이 개인정보처리방침은 2023년 9월 18부터 적용됩니다.


제1조(개인정보의 처리 목적)

< 팟팅 >('앱'이하 '팟팅')은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

1. 홈페이지 회원가입 및 관리

회원 가입의사 확인 목적으로 개인정보를 처리합니다.




제2조(개인정보의 처리 및 보유 기간)

① < 팟팅 >은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.

1.<홈페이지 회원가입 및 관리>
<홈페이지 회원가입 및 관리>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<3년>까지 위 이용목적을 위하여 보유.이용됩니다.
보유근거 : 홈페이지 회원정보 수집 등에 관한 기록
관련법령 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
예외사유 :


제3조(처리하는 개인정보의 항목)

① < 팟팅 >은(는) 다음의 개인정보 항목을 처리하고 있습니다.

1< 홈페이지 회원가입 및 관리 >
필수항목 : 생년월일, 성별, 자택주소, 직업 유무
선택항목 :


제4조(개인정보의 파기절차 및 파기방법)


① < 팟팅 > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.

② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.
1. 법령 근거 :
2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜

③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
1. 파기절차
< 팟팅 > 은(는) 파기 사유가 발생한 개인정보를 선정하고, < 팟팅 > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.

2. 파기방법

전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다



제5조(정보주체와 법정대리인의 권리·의무 및 그 행사방법에 관한 사항)



① 정보주체는 팟팅에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.

② 제1항에 따른 권리 행사는팟팅에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 팟팅은(는) 이에 대해 지체 없이 조치하겠습니다.

③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.

④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.

⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.

⑥ 팟팅은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.



제6조(개인정보의 안전성 확보조치에 관한 사항)

< 팟팅 >은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.

1. 개인정보에 대한 접근 제한
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.




제7조(개인정보를 자동으로 수집하는 장치의 설치·운영 및 그 거부에 관한 사항)



팟팅 은(는) 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용하지 않습니다.

제8조 (개인정보 보호책임자에 관한 사항)

① 팟팅 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

▶ 개인정보 보호책임자
성명 :정민욱
직책 :개인
직급 :개인
연락처 :PartingTeam007@gmail.com
② 정보주체께서는 팟팅 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 팟팅 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.

제9조(개인정보의 열람청구를 접수·처리하는 부서)
정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.
< 팟팅 >은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.



제10조(정보주체의 권익침해에 대한 구제방법)



정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.

1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)
3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)

「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.

※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.

제11조(개인정보 처리방침 변경)


① 이 개인정보처리방침은 2023년 9월 18부터 적용됩니다.
"""
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let personalInfoButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = AppColor.gray200.cgColor
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    let personalInfoButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 수집 이용 동의(필수)"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    let personalInfoButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nextStepButton = CompleteAndNextButton("다음")
    
    func changeButtonColor(buttonType: ButtonType, state: Bool) {
        switch buttonType {
        case .nextButton:
            if state {
                nextStepButton.backgroundColor = AppColor.brand
            } else {
                nextStepButton.backgroundColor = AppColor.brandNotValidate
            }
        case .serviceAgreement:
            if state {
                serviceAgreeButton.backgroundColor = AppColor.brand
                serviceAgreeButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                serviceAgreeButton.layer.borderWidth = 0
            } else {
                serviceAgreeButton.layer.borderColor = AppColor.gray200.cgColor
                serviceAgreeButton.setImage(UIImage(named: "checkButton"), for: .normal)
                serviceAgreeButton.backgroundColor = .white
            }
        case .personalInfoAgreement:
            if state {
                personalInfoButton.backgroundColor = AppColor.brand
                personalInfoButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                personalInfoButton.layer.borderWidth = 0
            } else {
                personalInfoButton.layer.borderColor  = AppColor.gray200.cgColor
                personalInfoButton.setImage(UIImage(named: "checkButton"), for: .normal)
                personalInfoButton.backgroundColor = AppColor.white
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceAgreeButton.layer.cornerRadius = serviceAgreeButton.frame.height / 2
        personalInfoButton.layer.cornerRadius = personalInfoButton.frame.height / 2
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [serviceAgreeButton, serviceAgreeButtonLabel].forEach {
            serviceButtonView.addSubview($0)
        }
        
        [personalInfoButton, personalInfoButtonLabel].forEach {
            personalInfoButtonView.addSubview($0)
        }
        
        [userAgreementTitleLabel, serviceConditionLabel, serviceConditionTextView, serviceButtonView, personalInfoLabel, personalInfoTextView, personalInfoButtonView, nextStepButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        serviceAgreeButton.snp.makeConstraints { make in
            make.width.height.equalTo(19)
            make.leading.top.equalToSuperview()
        }
        
        serviceAgreeButtonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(serviceAgreeButton.snp.trailing).offset(11)
        }
        
        personalInfoButton.snp.makeConstraints { make in
            make.width.height.equalTo(19)
            make.leading.top.equalToSuperview()
        }
        
        personalInfoButtonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(personalInfoButton.snp.trailing).offset(11)
        }
        
        userAgreementTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
        
        serviceConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(userAgreementTitleLabel.snp.bottom).offset(21)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        serviceConditionTextView.snp.makeConstraints { make in
            make.top.equalTo(serviceConditionLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(209)
        }
        
        serviceButtonView.snp.makeConstraints { make in
            make.top.equalTo(serviceConditionTextView.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        personalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceButtonView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        personalInfoTextView.snp.makeConstraints { make in
            make.top.equalTo(personalInfoLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(209)
        }
        
        personalInfoButtonView.snp.makeConstraints { make in
            make.top.equalTo(personalInfoTextView.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.top.equalTo(personalInfoButtonView.snp.bottom).offset(36
            )
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(38)
        }
    }
}
