# CoreDataProject
iOS 앱개발 심화 개인 과제

## ToDo 프로젝트 다이어그램
![TodoDiagram](https://github.com/angwoo0503/CoreDataProject/assets/136118540/a865481c-8356-4be3-8b70-9df3eb844f02)


## 1. UserDefaults와 CoreData의 차이점
UserDefaults와 CoreData는 iOS 앱에서 데이터를 저장하고 관리하는 서로 다른 저장소입니다.

### UserDefaults
- Key-Value 형태의 데이터를 간단하게 저장하고 검색하는 데 사용됩니다.
- 주로 설정, 사용자 기본 정보 등 간단한 데이터를 저장하는 데 적합합니다.
- 데이터 모델이 복잡하지 않고 데이터 양이 적을 때 유용합니다.
- 데이터베이스 형태로 구현되지 않으며, 데이터 관계나 복잡한 쿼리를 처리하기에는 적합하지 않습니다.

### CoreData
- 객체 그래프 관리 및 지속성 프레임워크로 데이터를 관리합니다.
- 데이터 모델을 정의하고 데이터를 저장하고 검색하는 데 사용됩니다.
- 복잡한 데이터 모델과 관계를 처리하기에 적합합니다.
- 데이터를 영구적으로 보존하고 복구할 수 있으며, 데이터베이스와 유사한 기능을 제공합니다.

## 2. MVC와 MVVM 비교
### MVC (Model-View-Controller)

- Model: 데이터와 비즈니스 로직을 담당하며, 주로 CoreData와 같은 데이터 관련 작업을 처리합니다.
- View: 사용자 인터페이스를 나타내며, 주로 Storyboard와 코드로 작성된 UIViewController를 사용합니다.
- Controller: View와 Model 사이의 중간 역할을 합니다. 주로 UIViewController가 이 역할을 합니다.

### MVVM (Model-View-ViewModel):

- Model: 데이터와 비즈니스 로직을 처리합니다. 주로 CoreData와 같은 데이터 작업을 수행합니다. MVVM에서는 Model과 직접 상호작용하지 않고 ViewModel을 통해 간접적으로 접근합니다.
- View: 사용자 인터페이스를 나타내며, UIViewController 또는 SwiftUI의 View가 이 역할을 합니다.
- ViewModel: Model과 View 사이의 매개체로 동작합니다. View에 표시할 데이터를 가공하고, 사용자 입력을 처리하며, View의 상태를 관리합니다.

MVVM은 MVC보다 데이터와 로직을 더 효과적으로 분리하고, 테스트 용이성을 향상시키며, 코드의 재사용성을 높이는 데 도움을 줍니다. 또한 SwiftUI와 같은 최신 프레임워크와 더 잘 어울리는 패턴입니다.

## 3. ProfileViewController와 ToDo 앱 구조 설명
### ProfileViewController
- Model: Profile 객체 및 User 정보를 저장하는 데이터 관리 작업을 수행합니다.
- View: 사용자 인터페이스 요소를 포함하는 화면을 표시하며, 사용자가 프로필 정보를 확인하고 편집하는 데 사용됩니다.
- ViewModel: Model과 View 간의 중간 계층으로, 프로필 데이터를 가공하고 View에 표시할 데이터를 제공합니다.

### ToDo
- Model: CoreData를 사용하여 데이터를 저장하고 관리하는 데 사용됩니다. TaskManager 클래스는 Task 관련 데이터 작업을 처리합니다.
- View: UIKit과 라이브러리인 SnapKit을 사용하여 화면을 구성하고 사용자 인터페이스를 표시합니다. ToDoViewController와 ToDoTableViewCell은 주요 View 역할을 합니다.
- ViewModel: MVVM 패턴을 사용하여 View와 Model 사이의 중간 계층을 형성합니다. ToDoListViewModel은 Task 데이터를 가공하고 관리하며, ProfileViewController와 데이터 일관성 화면은 각각 ViewModel을 사용하여 데이터를 관리하고 화면에 표시합니다.

이러한 구조는 데이터와 UI를 효과적으로 분리하여 앱을 관리하고 확장하기 쉽게 만들어 줍니다. 또한 MVVM 패턴을 사용하여 사용자 인터페이스를 관리하면 유지 보수 및 테스트 작업도 더 쉬워집니다.
