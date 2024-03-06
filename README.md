# 👬 새로운 사람들과 새로운 모임을 가져볼까요? Parting!
<img src="https://github.com/kimseongj/Drinkin/assets/88870642/ff5d1d50-fa35-437f-a56b-8da2a31688f6" width=200>

<br/>
<br/>

> 👬 *Parting*
> 
>개발기간: 2024.01.01~ing
>
>Party 와 -ing의 합성어로 이용자가 원하는 카테고리의 일회성 모임, 번개 모임 등을 생성하고 참여할 수 있는 앱입니다. 다양한 카테고리의 모임을 가까운 지역에서 찾을 수 있습니다.

<br/>
<br/>

## ⚒️ 기능 소개
다양한 사람들과 새로운 모임을 해보고 싶나요?

Parting을 통해 시작해보세요!

원하는 카테고리의 모임을 찾아보고 참여해보세요!

지도를 통해서 근처 파티를 찾아보세요!


### Parting UI
#### 앱진입
|로그인|상세정보 기입|카테고리 설정|세부 카테고리 설정|
|:----:|:----:|:----:|:----:|
|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/0e92261f-da33-4966-b04b-a55a5f968ecb" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/e1d47d14-b9b8-48d9-be60-e913fe9375e2" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/2f4a0ee6-e849-45c4-ad5f-fd8dff16179e" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/4b20fcc1-1c5e-4efb-8feb-7a3ad9ac60ee" width=150>

<br/>

#### 메인화면
|메인화면|파티리스트|파티리스트 세부설정|달력UI|
|:----:|:----:|:----:|:----:|
|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/7ffaa2bd-c873-484e-9370-3083e878b241" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/c166311b-aa7b-4dc4-96f9-0d98ba5569e6" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/366a2a6e-67a4-48f9-89d4-f4dbfb64e041" width=150>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/e2f0be20-f59e-4f16-ae56-0610520832b6" width=150>

<br/>

#### 기타 탭바
|NaverMap |마이페이지|프로필 수정|
|:----:|:----:|:----:|
|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/dc7e26a6-4b7f-41e0-81d8-12ae637b8435" width=200>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/46255b8a-65a4-4d85-9f3f-c353805980b3" width=200>|<img src="https://github.com/kimseongj/Drinkin/assets/88870642/ad9dfc13-f87d-4e63-80ae-9c4892811580" width=200>|


<br/>
<br/>

## ⚙️ 기술 스택
<img src="https://img.shields.io/badge/MVVM-100AF?style=flat-square"/>
<img src="https://img.shields.io/badge/Coordinator-019999?style=flat-square"/>
<img src="https://img.shields.io/badge/RxSwifft-AAA1AF?style=flat-square"/>
<img src="https://img.shields.io/badge/Alamofire-100000?style=flat-square"/>
<img src="https://img.shields.io/badge/KingFisher-FF0000?style=flat-square"/>
<img src="https://img.shields.io/badge/Tabman-EEE6C4?style=flat-square"/>
<img src="https://img.shields.io/badge/FSCalendar-DDA2FF?style=flat-square"/> 

<br/>
<br/>
<br/>
<br/>

## 📝 아키텍쳐- MVVM/C
![MVVM - C](https://github.com/kimseongj/Drinkin/assets/88870642/4a75210d-0770-43fb-9f2f-64311e06a44c)


<br/>
<br/>

## 🏃기술적 도전
<details>
    <summary><big>MVVM - C</big></summary> 
    
### MVVM - C

> MVVM-C 아키텍쳐 패턴은 MVVM패턴을 유지하며 Coordinator패턴을 통해 화면 전환을 하는 복합패턴입니다. 대부분 View에서 Coordinator를 의존하는 형태이지만 해당 프로젝트에서는 Coordinator를 ViewModel에서 의존하고 있습니다. ViewModel이 Coordinator를 의존하고 있는 이유는 ViewModel의 input이 View의 사용자 이벤트, lifeCycle 등을 enum으로 관리하고 있기 때문입니다. 이 input을 binding하여 해당 이벤트가 발생할 때, ViewModel에서 그 이벤트에 맞는 반응을 해줘야하기 때문에 ViewModel이 Coordinator를 의존하고 있는 형태를 띄고 있습니다.

:fire: 결론은 MVVM과 Coordinator의 합성에 있어 Coordinator의 의존성을 받는 곳이 View이든 ViewModel이든 기능에 맞게 설계할 수 있습니다. 


 </details>

    
<details>
<summary><big>RxSwift</big></summary> 
    
### RxSwift
> RxSwift는 반응형 프로그래밍을 구축하기 위한 라이브러리로, Xcode 내장 프레임워크인 Combine이 만들어지기 전에 사용되던 라이브러리입니다. RxSwift는 현재도 많은 기업에서 채택하고 있는 라이브러리로 해당 프로젝트를 진행하면서 다뤄볼 수 있었습니다. 
RxSwift는 Observable(= Publisher)와 Observer(= subscriber)로 이루어져있습니다. 
    
- Observable은 비동기 이벤트가 일어날 때마다 item을 방출합니다. 
- Observer는 Observable를 구독하여 비동기처리가 끝나는 시점에 이벤트를 실행할 수 있는 closure를 지원해줍니다. 
- Subject는 Observer이기 때문에 Observable을 구독할 수 있으며, 동시에 Observable이기 때문에 새로운 항목들을 방출할 수 있습니다.
</details>
    
<details>
<summary><big>NaverMap API활용</big></summary> 
    
### NaverMap
>NaverMap API를 활용하여 카메라 이동에 따른 API호출을 구현할 수 있었습니다. 또한 카메리 이동시 호출된 데이터를 통해 마커를 표시하여 현재 카메라에 있는 파티들을 띄어주는 기능을 구현했습니다.  

:fire: 해당 이벤트 호출에 있어 카메라 위치가 바뀔때마다 호출되는 `mapViewCameraIdle(_ mapView: NMFMapView)`메서드가 있습니다. 해당 메서드는 카메라를 움직일때마다 바로바로 호출되기 때문에 너무 많은 API호출을 하게 될 수 있습니다. 이를 방지하기 위해 아래와 같이 `timeInterval`을 사용했습니다.
    
```swift
func startAPICallDebouncer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleAPICall), userInfo: nil, repeats: false)
    }
    
    @objc func handleAPICall() {
        let southWest = rootView.mapView.mapView.projection.latlngBounds(fromViewBounds: self.view.frame).southWest
        let northEast = rootView.mapView.mapView.projection.latlngBounds(fromViewBounds: self.view.frame).northEast
        viewModel.searchPartyOnMap(searchHighLatitude: northEast.lat, searchHighLongitude: northEast.lng, searchLowLatitude: southWest.lat, searchLowLongitude: southWest.lng)
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        startAPICallDebouncer()
    }
    
```
    
 </details>

<details>
<summary><big>ViewModel Input/Output/State 분리</big></summary> 
    
### Input/Output
> ViewModel에서 Input과 Output을 나누는 것은 코드 가독성에 이점을 줍니다. 
    
- Input의 경우 enum을 `Relay`로 생성하여 구독하는 형태로 enum case에 여러 이벤트들을 설정해줍니다. 
```swift
enum Input {
        case BirthTextFieldTrigger
        case viewdidLoadTrigger
        case editCompleteButtonClicked
}
    var input = PublishRelay<Input>()
```
    
- Output의 경우 struct 구조로 다양한 `Relay`들을 인스턴스로 가지고 있습니다.
```swift
struct Output {
        var nameTextField = BehaviorRelay<String>(value: "")
        var selectedGender = BehaviorRelay(value: GenderCase.man)
        var birthTextField = BehaviorRelay<String>(value: "")
        var regionTextField = BehaviorRelay<String>(value: "")
        var introduceTextView = BehaviorRelay<String>(value: "")
        var completeButtonIsValidState = BehaviorRelay(value: false)
}
```
    
:fire: Input, Output을 `Relay`로 사용하는 이유 : `Subject`의 경우 Completed, Error 등의 여러 closure를 제공합니다. 하지만 input과 output의 경우 Error처리 및 Completed를 처리할 필요가 없습니다. 그렇기 때문에 `Next` closure만 제공하는 Relay를 사용합니다. (Error처리가 필요할 경우 Subject로 바꿀 필요 있음) 
 </details>    
    
<details>
<summary><big>페이징 구현</big></summary> 
    
### 페이징 구현
> API호출 시 다량의 데이터가 한번에 호출되는 경우를 방지하기 위해 TableView의 페이징을 구현했습니다. page를 나누고 데이터 배열에서 10개씩 가져오도록 구현하였으며, TableView의 RootView에 Activity Indicator를 삽입하여 페이징이 진행되고 있음을 UI에 구현하였습니다. 
  
    
<img src="https://github.com/kimseongj/Drinkin/assets/88870642/7ed54c15-408c-4acd-a702-4364ab47cea0" width=250>    
    
- Paging 구현 시 제일 중요한 메서드인 `scrollViewDidScroll(_ scrollView: UIScrollView)`를 사용하였습니다. 해당 메서드는 ViewController 내부에서 실행되는 Scrolling Event를 감지합니다.
- 아래 그림과 같이 Height1(Scrolling한 길이)가 Height2(TableView ContentView의 Height - 디바이스의 Height)를 넘어서면 분기처리를 하여 Paging이벤트를 실행시킵니다.



```swift
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) && !isPaging && viewModel.output.hasNextPage {
            rootView.activityIndicator.startAnimating()
            beginPaging()
        } 
    }
    
    func beginPaging() {
        isPaging = true
        pagepartyListTableView()
    }
    
    func pagepartyListTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            viewModel.pagePartyList()
            self.rootView.activityIndicator.stopAnimating()
            self.isPaging = false
        }
    }
```
 </details>
