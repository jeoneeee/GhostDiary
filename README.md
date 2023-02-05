# 👻 Ghost Diary 

<br>
<br>

📖 [노션 페이지 바로가기](https://nimble-umbra-cac.notion.site/7752163db0aa43ad94ae2aebccee936b)

<p align="center"><img src="https://user-images.githubusercontent.com/105197393/216773055-f0d98d42-bef5-445d-ac5d-53f52d8908bb.png" width="50%"></p>

## 📚 앱 소개
*Ghost Diary 앱은 하루에 한개씩 주어지는 질문에 대답을 작성하고 기록하는 앱 입니다.*

<br>

### ✅ 나의 감정과 질문에 따른 답변을 기록할 수 있습니다.

매일 나의 감정과 질문에 따른 답변을 기록해 보세요!

### ✅ 나의 기록 흔적을 확인할 수 있습니다.

캘린더, 리스트, 차트를 통해 나의 기록들을 확인해 보세요!


<br>

## 🐾 팀원 소개
|<img src="https://avatars.githubusercontent.com/u/105197393?v=4" width=150>|<img src="https://avatars.githubusercontent.com/u/52197436?v=4" width=150>|
|:---:|:---:|
|**이지연**|**이학진**|
|[jeoneeee](https://github.com/jeoneeee)|[LEEHAKJIN-VV](https://github.com/LEEHAKJIN-VV)|
> **이지연** 🍓 : 사용자 경험과 디자인 시스템에 진심이고 싶은 iOS 개발자입니다.

> **이학진** 🍑 :  좋은 코드에 진심이고 싶은 iOS 개발자입니다.

<br>

## 🌳 목차
- [화면 구성](#-화면-구성)
- [기능](#-기능)
- [협업 방법](#-협업-방법)
- [활용한 기술](#-활용한-기술)
- [개발 환경](#-개발-환경)
- [목표 및 후기](#-목표-및-후기)


<br>

## 📱 화면 구성 
<details>
<summary>라이트모드</summary>
<div markdown="1">


|<img src="" width=80%>|<img src="https://user-images.githubusercontent.com/105197393/216819304-0d641b65-9a46-4c1b-9a4d-e4fd3d6ca615.gif" width=80%>|<img src="" width=80%>|<img src="https://user-images.githubusercontent.com/105197393/216819371-c1d48ab9-ccd3-4850-b429-138f2af1a42a.gif" width=80%>|
|:---:|:---:|:---:|:---:|
|회원가입|홈|캘린더|차트|
  
</div>
</details>
<details>
<summary>다크모드</summary>
<div markdown="2">
  
|<img src="" width=80%>|<img src="https://user-images.githubusercontent.com/105197393/216819448-95490a54-69ee-44f5-98ea-bbf3b1c6c55d.gif" width=80%>|<img src="" width=80%>|<img src="https://user-images.githubusercontent.com/105197393/216819467-49cc9877-89f8-453c-bff2-634fc29f6cbd.gif" width=80%>|
|:---:|:---:|:---:|:---:|
|회원가입|홈|캘린더|차트|

</div>
</details>

<br>

## 💡 기능

### 로그인

- 사용자는 이메일로 회원가입할 수 있다.
    - 사용자는 이메일 중복확인을 할 수 있다.
- 사용자는 회원가입한 이메일로 로그인할 수 있다.
- 사용자는 애플로 로그인할 수 있다.
- 사용자는 구글로 로그인할 수 있다.

### 글쓰기

- 사용자는  글쓰기 화면에서 오늘의 질문을 확인할 수 있다.
- 사용자는 질문에 대한 감정을 선택할 수 있다.
- 사용자는 질문에 대한 답변을 작성할 수 있다.
- 사용자는 작성한 답변을 확인할 수 있다.

### 타임라인

- 캘린더
    - 타임라인 탭에서 캘린더를 확인할 수 있다.
        - 캘린더는 현재년도, 월 이전까지의 날짜들을 보여준다.
    - 캘린더에서 그날 작성한 답변에 대한 감정을 확인할 수 있다.
    - 감정을 클릭하면 질문과 답변을 확인할 수 있는 디테일 뷰로 이동한다.
- 리스트
    - 질문에 대답한 답변들을 리스트로 확인할 수 있다.
    - 리스트는 최근 답변한 순으로 정렬된다.
    - 각 셀을 클릭하면 질문과 답변을 확인할 수 있는 디테일 뷰로 이동한다.

### 분석보고서

- 분석 보고서 탭에서 해당 월에 작성한 답변들의 감정을 확인할 수 있다.
- 각 감정들의 통계를 차트로 확인할 수 있다.
- 차트는 현재년도, 월 이전까지의 날짜들을 보여준다.

<br>

## 🤝 협업 방법
- `Figma`를 통해 View를 구상
- 하루콩, 플로리 앱(iOS)을 참고
 
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
📦 GhostDiary
| 
+ 🗂 Configuration
|         
+------🗂 Extensions   // extension 모음
│         
+------🗂 Fonts  // 폰트 모음: 무료 폰트인 나눔손글씨 느릿느릿체 사용
│         
+------🗂 Modifiers       // modifier 모음
│         
+------🗂 Utilities       // 앱 전반에 사용되는 코드
│         
+ 🗂 Sources
|
+------🗂 Model      // Json을 받기 위한 Hashable, Codable, Identifiable 프로토콜을 체택한 struct 관리
│         
+------🗂 ViewModel     // ObservableObject을 체택하여 네트워크 관리
|
+------🗂 View       // 여러 View를 모음
        |
        +------🗂 Question        // Tab1
        │         
        +------🗂 TimeLine          // Tab 2
        |
        +------🗂 Analysis        // Tab 3
        |
        +------🗂 Login   // 구글, 애플, 이메일 로그인
```
<br>

## 🔗 활용한 기술
- Firebase Firestore
- Firebase Auth
- Charts
- Custom Calendar

<br>

## ✨ 개발 환경
- iOS 16.0 이상
- 다크모드 지원
- 모든 디바이스 크기 대응
- 가로모드 미지원

<br>

## 🔥 목표 및 후기
### 목표
- 이지연 : 지금까지 멋사에서 배웠던 지식을 유령일기를 통해 사용해보고, 앱 구상 A to Z를 알아가고싶다.
- 이학진 : iOS 개발 프로세스 처음부터 끝까지 경험하는 것이 목표

<br>

### 후기
- 이지연 : 평일 시간을 쪼개 조금씩 개발을 진행해서 생각보다 오래 걸렸지만 A-Z까지 소수인원으로 진행하는 첫 프로젝트라서 기획, 개발, 디자인 다양한 측면에서 많은 점을 느끼고 배울 수 있었습니다
- 이학진 : 짧은 시간안에 개발 프로세스를 끝까지 진행하고 완성하면서 시간 배분의 중요성을 느낄 수 있었습니다.
