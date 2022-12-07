# 유령일기 👻
*바쁜 일상 속 매일 한개의 질문을 통해 나를 발견해나가는 앱*


## 🤝 협업 방법
- `Figma`를 통해 View를 구상
- 하루콩, 플로리 앱(iOS)를 참고
 
### 코드 컨벤션
```
- [Feat] 새로운 기능 구현
- [Chore] 코드 수정, 내부 파일 수정, 주석
- [Add] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
- [Fix] 버그, 오류 해결
- [Del] 쓸모없는 코드 삭제
- [Move] 파일 이름/위치 변경
```

### 깃 브랜치
- feat/이슈번호-큰기능명/세부기능명
```
예시)
feat/13-tab1/map
feat/13-tab1/search
feat/26-tab2/recipe
```

### 폴더링 컨벤션
```
📦 Tteokbokking
| 
+ 🗂 Configuration
|         
+------🗂 Constants   // 기기의 제약사항: width, height를 struct로 관리
│         
+------🗂 Extensions  // extension 모음
│         
+------🗂 Fonts       // 폰트 모음: 무료 폰트인 Pretendard 사용
│         
+ 🗂 Sources
|
+------🗂 Models      // Json을 받기 위한 Hashable, Codable, Identifiable 프로토콜을 체택한 struct 관리
│         
+------🗂 Network     // ObservableObject을 체택하여 네트워크 관리
|
+------🗂 Views       // 여러 View를 모음
        |
        +------🗂 Splash        // Splash View
        │         
        +------🗂 Home          // Tab 1
        |
        +------🗂 Search        // Tab 2
        |
        +------🗂 Register(+)   // Tab 3
        │         
        +------🗂 Bookmark      // Tab 4
        |
        +------🗂 Profile       // Tab 5
        |
        +------🗂 Detail        // Tab 1, 2, 4 -> 가게 상세 View
        │         
        +------🗂 Map           // Map View
        |
        +------🗂 ETC.          // 여분의 View: CustomTabView 등
```
<br>

## ⚒️ 활용한 기술
- ?
- ?

<br>

## ⚙️ 개발 환경
- iOS 16.0 이상
- iPhone 14 Pro에서 최적화됨
- 가로모드 미지원 미지원
<br>

## 👻 팀 소개
|<img src="https://avatars.githubusercontent.com/u/105197393?v=4" width=150>|<img src="https://avatars.githubusercontent.com/u/52197436?v=4" width=150>|
|:---:|:---:|
|**이지연**|**이학진**|
|[jeoneeee](https://github.com/jeoneeee)|[LEEHAKJIN-VV](https://github.com/LEEHAKJIN-VV)|
> **이지연** 🍓 : 사용자 경험과 디자인 시스템에 진심이고 싶은 iOS 개발자입니다.

> **이학진** 🍑 :  좋은 코드에 진심이고 싶은 iOS 개발자입니다.

<br>

## 🔥 처음 목표
- 이지연 : 지금까지 멋사에서 배웠던 지식을 유령일기를 통해 사용해보고, 앱 구상 A to Z를 알아가고싶다.
- 이학진 : iOS 개발 프로세스 처음부터 끝까지 경험하는 것이 목표

<br>

## 👣 후기
- 이지연 : 
- 이학진 : 
