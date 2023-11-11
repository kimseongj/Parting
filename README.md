# 팟팅(Party + ing)

안녕하세요, 메일플러그에 지원한 iOS 개발자 박시현입니다.


## 스크린샷
<img width="1337" alt="스크린샷 2023-10-11 오후 10 30 38" src="https://github.com/tlguszz1010/Parting/assets/62739187/c4003526-be99-4ca4-bf82-19455e26c120">




## 기술 스택

| Kinds        | Stack                         |
| ------ | ---------------- |
| Architecture | MVVM + Input - Output Pattern, State |
| Network      | Alamofire + Router            |
| Library      | RxSwift, RxGesture, Almofire, Toast, SnapKit, Realm |
| Tools        | Git, Github                   |



## 프로젝트 고려사항
- 프로젝트 관리 : 전체 프로젝트 관리를 기능단위로 나누고, 각 기능 별로 branch를 나누어 작업하였습니다.
- 요구사항 명세 : 과제에 제시된 요구사항을 체크리스트로 만들어 전체 프로젝트를 관리하였고, 우대사항에 명시된 Rxswift 및 LocalDB(Realm)를 바탕으로 전체 프로젝트를 구성하였습니다.

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
- Repository Pattern 을 사용하여, Realm의 CRUD를 한곳에서 관리하도록 하였습니다.
- View의 재사용성 : BoardView를 공유함으로써 코드의 재사용성을 증가시켰습니다.
- DesignSystem : App에 사용되는 폰트, 컬러, 이미지등을 Enum을 통해 관리하였습니다.
- 컴파일 성능 고려 : 상속이 필요하지 않은 class에 Final 키워드를 사용함으로써 static Dispatch로 동작하도록 구현하였습니다.
  

## TroubleShooting
### CellViewModel의 ActionHandler를 통해 Cell 이벤트 처리
- Cell에 대한 이벤트를 처리하는 과정에서, Cell을 그려주는 데이터소스의 CellForRowAt 부분에 Cell내의 컴포넌트들의 이벤트에 대한 코드가 들어가게 되었습니다. 저는 CellForRowAt은 Cell을 그려주는 configure 메서드만 존재해야 한다고 생각했고, 이러한 로직을 분리하기 위해, CellViewModel내부의 ActionHandler를 통해 ViewModel에 이벤트를 전달하여 처리를 할 수 있도록 구현하였습니다.
  
<img width="623" alt="스크린샷 2023-10-28 오후 4 17 44" src="https://github.com/tlguszz1010/MailPlugAssignment/assets/62739187/af445840-853b-437a-8193-3bf1ad1b86e9">

<img width="789" alt="스크린샷 2023-10-28 오후 4 17 57" src="https://github.com/tlguszz1010/MailPlugAssignment/assets/62739187/678b2b0f-2a4d-4fd0-b823-11433d9db946">

<img width="607" alt="스크린샷 2023-10-28 오후 4 26 11" src="https://github.com/tlguszz1010/MailPlugAssignment/assets/62739187/3289ca20-3a7d-4e1f-a3b2-2bdb3bb5b36e">

### 검색내역 중복기능 구현
- 검색내역을 중복되지 않도록 하기 위한 방법들이 여러가지가 있었습니다. 첫번째로는, 중복되는 검색어가 들어온다면, LocalDB 에서 검색어에 해당하는 데이터를 삭제하고, 추가하는 방법이었고, 두번째는, 바뀐 Column의 Date를 기존의 데이터에 업데이트 해주는 방법이었습니다. 저는 두번째 방법을 선택하였는데, 그 이유는 Date 기준으로 데이터를 업데이트 한다면 삭제 추가 로직 없이, transaction의 단위가 줄어드는 코드를 작성 할 수 있었습니다.
  
<img width="628" alt="스크린샷 2023-10-28 오후 3 57 29" src="https://github.com/tlguszz1010/MailPlugAssignment/assets/62739187/84fb75da-4040-4173-b753-1a9901b1380e">

<img width="531" alt="스크린샷 2023-10-27 오후 6 01 34" src="https://github.com/tlguszz1010/MailPlugAssignment/assets/62739187/a5220be3-db12-45ad-9091-67e2fcfac31e">

