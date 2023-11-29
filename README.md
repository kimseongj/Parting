# 팟팅(Party + ing) 

<img width="1337" alt="스크린샷 2023-10-11 오후 10 30 38" src="https://github.com/tlguszz1010/Parting/assets/62739187/c4003526-be99-4ca4-bf82-19455e26c120">


## 개발 기간
2023.06.30 ~ 현재 진행중

## 프로젝트 소개
- 팟팅(Parting)으로써 Party 와 -ing의 합성어입니다.
- 팟팅은 원하는 카테고리의 모임을 찾는 어플로써 새로운 사람들과 만나 어울리고 싶은 사람들을 위한 어플입니다.
- 카테고리는 대분류와 소분류로 나뉩니다.
  - 대분류: 문화생활팟, 관람팟, 자기개발팟, 한입팟, 운동팟, 오락팟, 카페팟, 한잔팟
  - 소분류: 영화, 공연, 연극, 카공, 스터디, 맛집탐방, 방탈출, 과제, 노래방, 스포츠(축구,야구,당구,볼링), 뮤지컬, 독서, PC방, 간맥, 운동, 전시회, 등


## 프로젝트 구조
<img width="629" alt="팟팅 프로젝트 구조" src="https://github.com/tlguszz1010/Parting/assets/62739187/fcf76885-68f3-48f4-8f61-93204d64cffa">


## 기술 스택

| Kinds        | Stack                         |
| ------ | ---------------- |
| Architecture | MVVM - Coordinator + Input - Output Pattern, State |
| Network      | Alamofire + Router            |
| Library      | RxSwift, Alamofire, Toast, SnapKit, FSCalendar, TabMan, KakaoOpenSDK, Toast, NaverMap |
| Tools        | Git, Github, Slack, Swagger                   |



## 프로젝트 고려사항
- 프로젝트 관리 : 전체 프로젝트 관리를 기능단위로 나누고, 각 기능 별로 branch를 나누어 작업하였습니다.

### UI/UX
- Pull To Refresh : 게시글 리스트 화면에서 Pull To Refresh 로직을 적용하여 밀어서 당기면 재통신 후 데이터를 갱신하도록 하였습니다.
- 검색 화면의 최근 검색내역을 10개로 제한하고, 최신순으로 정렬되도록 구현하였습니다.
- 네트워크 미연결시 예외처리 화면으로 이동하여 사용자에게 어떤 문제가 발생했는지 알 수 있도록 대응하였습니다.
- 통신에러 발생 / 최근 검색어 삭제 시, 토스트 라이브러리를 사용하여 사용자에게 알리도록 구현하였습니다. 
- Custom SearchBar를 만들어서 검색화면을 구현하였습니다.
- 가로모드 막기 / 다크모드 막기 / App Icon 설정 / Splash View 구현 / 게시글 리스트 디테일 화면 구성 


### 개발적 고려사항
- MVVM + Input/Output Pattern + State 을 사용하여, Input으로는 사용자의 이벤트 및 ViewLifeCycle에 대한 신호를 받고, Output 으로는 데이터 갱신에 대한 신호를, State에서는 View의 상태(데이터)를 관리하도록 하였습니다.
- cellViewModel을 통해 cell에 대한 상태 관리를 용이하게 구현하였습니다.
- DesignSystem : App에 사용되는 폰트, 컬러, 이미지등을 Enum을 통해 관리하였습니다.
- 컴파일 성능 고려 : 상속이 필요하지 않은 class에 Final 키워드를 사용함으로써 static Dispatch로 동작하도록 구현하였습니다.
  
